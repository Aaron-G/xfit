//
//  HomeScreenShareDelegate.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "HomeScreenShareDelegate.h"
#import "HomeViewController.h"

@implementation HomeScreenShareDelegate

- (void) share {
  [super showActionSheetWithTitlePart:NSLocalizedString(@"share-app", @"App")];
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
  return @"move";
}

- (UIImage *)twitterImage {
  return [UIImage imageNamed:@"default-user-profile-image"];
}

- (NSString *)twitterMessage {
  return NSLocalizedString(@"share-app-twitter-text", @"");
}

- (NSURL *)twitterURL {
  return [NSURL URLWithString:@"http://tinyurl.om/crossfitter"];
}

- (UIImage *)facebookImage {
  return [UIImage imageNamed:@"default-user-profile-image"];
}

- (NSString *)facebookMessage {
  return NSLocalizedString(@"share-app-facebook-text", @"");
}
- (NSURL *)facebookURL {
  return [NSURL URLWithString:@"http://download.itunes.com/crossfitter"];
}

@end
