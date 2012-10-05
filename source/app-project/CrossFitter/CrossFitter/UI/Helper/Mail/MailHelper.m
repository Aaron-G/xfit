//
//  MailHelper.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/15/12.
//
//

#import "MailHelper.h"
#import "MailAttachment.h"
#import "UIHelper.h"

@implementation MailHelper

NSString* kMailerHelperEmailSubjectKey = @"subject";
NSString* kMailerHelperEmailTextKey = @"text";
NSString* kMailerHelperEmailTextIsHtmlKey = @"is-text-html";
NSString* kMailerHelperEmailAttachmentstKey = @"attachments";
NSString* kMailerHelperEmailFromKey = @"from";
NSString* kMailerHelperEmailToKey = @"to";
NSString* kMailerHelperEmailCCKey = @"cc";
NSString* kMailerHelperEmailBCCKey = @"bcc";

static MailHelper *sharedInstance = nil;


#pragma MFMaileComposeViewControllerDelegate

- (void)displayEmailComposerWithEmailInfo: (NSDictionary*) emailInfo {
  
  if ([MFMailComposeViewController canSendMail]) {
    
    //Create controller
    MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
    mailer.mailComposeDelegate = self;
    
    
    //Set email TO
    id toObj = [emailInfo valueForKey:kMailerHelperEmailToKey];
    
    if(toObj) {
      [mailer setToRecipients: [NSArray arrayWithObject:toObj]];
    }
    
    //Set email subject
    id subjectObj = [emailInfo valueForKey:kMailerHelperEmailSubjectKey];
    
    if(subjectObj) {
      [mailer setSubject: (NSString*)subjectObj];
    }
    
    //Set email any attachments
    id attachmentsObj = [emailInfo valueForKeyPath:kMailerHelperEmailAttachmentstKey];
    if(attachmentsObj) {
      NSArray* attachments = (NSArray*) attachmentsObj;
      for (id attachementObj in attachments) {
        MailAttachment* attachement = (MailAttachment*)attachementObj;
        
        [mailer addAttachmentData: attachement.data
                         mimeType: attachement.mimeType
                         fileName: attachement.fileName];
      }
    }
    
    //Set email text
    id textObj = [emailInfo valueForKey:kMailerHelperEmailTextKey];
    if(textObj) {
      
      id htmlObj = [emailInfo valueForKey:kMailerHelperEmailTextIsHtmlKey];
      
      BOOL isHtml = NO;
      
      if ([@"yes" isEqualToString: (NSString*)htmlObj]) {
        isHtml = YES;
      } else if ([@"no" isEqualToString: (NSString*)htmlObj]) {
        isHtml = NO;
      }
      
      [mailer setMessageBody:(NSString*)textObj isHTML:isHtml];
    }
    
    //Display email composer
    [[UIHelper appViewController].navigationController.topViewController presentViewController:mailer animated:YES completion:nil];
    
  } else {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"cannot-share-title", @"Cannot Share")
                                                    message:NSLocalizedString(@"no-email-support-message", @"No email support")
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"ok-label", @"OK")
                                          otherButtonTitles: nil];
    [alert show];
  }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
  //CXB REVIEW_AND_IMPL
  if(result == MFMailComposeResultCancelled) {
    //    NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
  } else if(result == MFMailComposeResultSaved) {
    //    NSLog(@"Mail saved: you saved the email message in the drafts folder.");
  } else if(result == MFMailComposeResultSent) {
    //    NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
  } else if(result == MFMailComposeResultFailed) {
    //    NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
  } else {
    //    NSLog(@"Mail not sent.");
  }
  
  // Remove the mail view
  [[UIHelper appViewController].navigationController.topViewController dismissViewControllerAnimated:YES completion:nil];
}

////////////////////////////////////////////////
//Singleton Implementation
////////////////////////////////////////////////


+ (MailHelper *)sharedInstance
{
  if(sharedInstance == nil)
    {
    @synchronized(self)
      {
      if (sharedInstance == nil)
        sharedInstance = [[self alloc] init];
      }
    }
  
  return sharedInstance;
}


@end
