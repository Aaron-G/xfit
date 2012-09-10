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

//CXB REVIEW_AND_IMPL
- (NSString*) textMessageText {
  return NSLocalizedString(@"share-app-text-message-text", @"Share app text message text");
}

#pragma MFMaileComposeViewControllerDelegate Helper methods

//CXB REVIEW_AND_IMPL
- (NSString *)emailSubject {
  return NSLocalizedString(@"share-app-email-subject", @"Share app email subject");
}

//CXB REVIEW_AND_IMPL
- (NSString *)emailText {
  return NSLocalizedString(@"share-app-email-text", @"Share app email text");
}

//CXB REVIEW_AND_IMPL
- (NSData *)emailAttachmentData {
  UIImage *myImage = [UIImage imageNamed:@"move.png"];
  return UIImagePNGRepresentation(myImage);
}

//CXB REVIEW_AND_IMPL
- (NSString *)emailAttachmentFileName {
  return @"move";
}

@end
