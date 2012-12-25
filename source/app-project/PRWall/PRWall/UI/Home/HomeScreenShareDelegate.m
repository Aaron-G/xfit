//
//  HomeScreenShareDelegate.m
//  PR Wall
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "HomeScreenShareDelegate.h"
#import "HomeViewController.h"
#import "App.h"
@implementation HomeScreenShareDelegate

- (void) share {
  [super showActionSheetWithTitlePart:[[App sharedInstance] appName]];
}

#pragma UIActionSheetDelegate Helper methods

- (NSString*) textMessageText {
  return NSLocalizedString(@"share-app-text-message-text", @"Share app text message text");
}

#pragma MFMaileComposeViewControllerDelegate Helper methods

- (NSString *)emailSubject {
  return NSLocalizedString(@"share-app-email-subject", @"Share app email subject");
}

- (NSString *)emailText {
  return NSLocalizedString(@"share-app-email-text", @"Share app email text");
}

- (NSData *)emailAttachmentData {
  UIImage *myImage = [UIImage imageNamed:@"default-user-profile-image"];
  return UIImagePNGRepresentation(myImage);
}

- (NSString *)emailAttachmentFileName {
  return @"exercise";
}

- (UIImage *)twitterImage {
  return [UIImage imageNamed:@"default-user-profile-image"];
}

- (NSString *)twitterMessage {
  return NSLocalizedString(@"share-app-twitter-text", @"");
}

- (NSURL *)twitterURL {
  return [NSURL URLWithString:@"http://tinyurl.om/prwall"];
}

- (UIImage *)facebookImage {
  return [UIImage imageNamed:@"default-user-profile-image"];
}

- (NSString *)facebookMessage {
  return NSLocalizedString(@"share-app-facebook-text", @"");
}
- (NSURL *)facebookURL {
  return [NSURL URLWithString:@"http://download.itunes.com/prwall"];
}

@end
