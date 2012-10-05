//
//  InfoViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/8/12.
//
//

#import "App.h"
#import "InfoViewController.h"
#import "AppViewController.h"
#import "InfoScreenSwitchDelegate.h"
#import "AppScreenShareDelegate.h"
#import "InfoScreenShareDelegate.h"
#import "MailHelper.h"
#import "UIHelper.h"

@interface InfoViewController () {
  
}

- (void) displayEmailComposerWithTo: (NSString*) to withSubject: (NSString*) subject withText: (NSString*) text includeAppInfo: (BOOL) includeAppInfo includeSystemInfo: (BOOL) includeSystemInfo;

@property AppViewController* appViewController;
@property AppScreenShareDelegate* appScreenShareDelegate;

@end

@implementation InfoViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self) {
    self.appScreenSwitchDelegate = [[InfoScreenSwitchDelegate alloc]initWithViewController:self];
    self.appScreenShareDelegate = [[InfoScreenShareDelegate alloc]initWithViewController:self];
    self.appViewController = [UIHelper appViewController];
  }
  
  return self;
}

- (IBAction) shareAppEmail {
  [self.appScreenShareDelegate displayEmailComposer];
  
}

- (IBAction) shareAppTextMessage {
  [self.appScreenShareDelegate displayTextMessageComposer];
}

- (IBAction) shareAppFacebook {
  [self.appScreenShareDelegate displayFacebookComposer];
}

- (void) rateApp {
  NSURL * rateAppURL = [NSURL URLWithString:NSLocalizedString(@"app-review-url", @"App Store App Review URL")];
  [[UIApplication sharedApplication] openURL: rateAppURL];
  
}

- (void) requestFeature {
  [self displayEmailComposerWithTo:[App sharedInstance].appSupportEmail
                       withSubject: NSLocalizedString(@"info-screen-request-feature-email-subject", @"Feature Request")
                          withText: NSLocalizedString(@"info-screen-request-feature-email-text", @"Feature Request default email text")
                    includeAppInfo: YES
                 includeSystemInfo: YES];
}

- (void) provideFeedback {
  [self displayEmailComposerWithTo:[App sharedInstance].appSupportEmail
                       withSubject: NSLocalizedString(@"info-screen-provide-feedback-email-subject", @"Feedback")
                          withText: NSLocalizedString(@"info-screen-provide-feedback-email-text", @"Provide Feedback default email text")
                    includeAppInfo: YES
                 includeSystemInfo: NO];
}

- (void) reportIssue {
  [self displayEmailComposerWithTo:[App sharedInstance].appSupportEmail
                       withSubject: NSLocalizedString(@"info-screen-report-issue-email-subject", @"Issue Report")
                          withText: NSLocalizedString(@"info-screen-report-issue-email-text", @"Report Issue default email text")
                    includeAppInfo: YES
                    includeSystemInfo: YES];
  
}

- (void) displayEmailComposerWithTo: (NSString*) to withSubject: (NSString*) subject withText: (NSString*) text includeAppInfo: (BOOL) includeAppInfo includeSystemInfo: (BOOL) includeSystemInfo {
  
  //HTML start elements
  NSMutableString* finalEmailText = [NSMutableString stringWithString:@"<html><body><p/>"];
  
  //Email Primary content
  [finalEmailText appendString:text];
  
  if(includeAppInfo || includeSystemInfo) {
    [finalEmailText appendString:@"<br><hr><font size='1'>"];
  }

  //App info
  if(includeAppInfo) {
    [finalEmailText appendString:@"<u><b>App Info</b></u><br>"];
    [finalEmailText appendString:[App sharedInstance].appInformation];
    [finalEmailText appendString:@"<br>"];
  }

  //System info
  if(includeSystemInfo) {
    [finalEmailText appendString:@"<u><b>System Info</b></u><br>"];
    [finalEmailText appendString:[App sharedInstance].systemInformation];
    [finalEmailText appendString:@"<br>"];
  }

  if(includeAppInfo || includeSystemInfo) {
    [finalEmailText appendString:@"</font><hr>"];
  }

  //HTML end elements
  [finalEmailText appendString:@"</body></html>"];
  
  NSMutableDictionary* emailInfo = [[NSMutableDictionary alloc] initWithCapacity:5];
  [emailInfo setValue:to forKey:kMailerHelperEmailToKey];
  [emailInfo setValue:subject forKey:kMailerHelperEmailSubjectKey];
  [emailInfo setValue:finalEmailText forKey:kMailerHelperEmailTextKey];
  [emailInfo setValue:@"yes" forKey:kMailerHelperEmailTextIsHtmlKey];
  
  [[MailHelper sharedInstance ] displayEmailComposerWithEmailInfo:emailInfo];
}


//Add proper behavior to cell selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  //NSLog(@"Group: %d Row: %d", indexPath.section, indexPath.item);
  
  NSInteger selectedIndex = indexPath.item;
  
  //Share Section
  if(indexPath.section == 1) {
    
    if (selectedIndex == 0) {
      [self shareAppFacebook];
    } else if (selectedIndex == 1) {
      [self shareAppTextMessage];
    } else if (selectedIndex == 2) {
      [self shareAppEmail];
    }    
  }
  //Review Section
  else if(indexPath.section == 2) {
    
    if (selectedIndex == 0) {
      [self rateApp];
    }
  }
  //Support Section
  else if(indexPath.section == 3) {
    
    if (selectedIndex == 0) {
      [self requestFeature];
    } else if (selectedIndex == 1) {
      [self provideFeedback];
    } else if (selectedIndex == 2) {
      [self reportIssue];
    }
  }
}

//Localize the table cells
- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Info Group
  self.aboutLabel.text = NSLocalizedString(@"info-cell-title-about", @"About");
  self.versionLabel.text = [NSString stringWithFormat: NSLocalizedString(@"info-cell-title-version-format", @"Version"), [[App sharedInstance] appVersion]];

  //Share Group
  self.facebookLabel.text = NSLocalizedString(@"info-cell-title-facebook", @"Facebook");
  self.messageLabel.text = NSLocalizedString(@"info-cell-title-message", @"Message");
  self.emailLabel.text = NSLocalizedString(@"info-cell-title-email", @"Email");

  //Review Group
  self.rateAppLabel.text = NSLocalizedString(@"info-cell-title-rateapp", @"Rate App");

  //Support Group
  self.featureLabel.text = NSLocalizedString(@"info-cell-title-feature", @"Request Feature");
  self.issueLabel.text = NSLocalizedString(@"info-cell-title-issue", @"Report Issue");
  self.feedbackLabel.text = NSLocalizedString(@"info-cell-title-feedback", @"Feedback");

}

//Localize the table section titles
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

  if(section == 0) {
    return NSLocalizedString(@"info-section-title-info", @"Info");
  } else if(section == 1) {
    return NSLocalizedString(@"info-section-title-share", @"Share");
  } else if(section == 2) {
    return NSLocalizedString(@"info-section-title-review", @"Review");
  } else if(section == 3) {
    return NSLocalizedString(@"info-section-title-support", @"Support");
  } else {
    return [super tableView:tableView titleForHeaderInSection:section];
  }
}


@end
