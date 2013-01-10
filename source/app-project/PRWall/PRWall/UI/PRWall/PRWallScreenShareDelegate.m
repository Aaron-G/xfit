//
//  PRWallScreenShareDelegate.m
//  PR Wall
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "PRWallScreenShareDelegate.h"
#import "App.h"

@implementation PRWallScreenShareDelegate

#pragma UIActionSheetDelegate Helper methods

//CXB REVIEW_AND_IMPL
- (NSString*) textMessageText {
  return NSLocalizedString(@"share-prwall-text-message-text", @"Share prwall text message text");
}

- (void) share {
  [super showActionSheetWithTitlePart:[[App sharedInstance] appName]];
}

#pragma MFMaileComposeViewControllerDelegate Helper methods

//CXB REVIEW_AND_IMPL
- (NSString *)emailSubject {
  return NSLocalizedString(@"share-prwall-email-subject", @"Share prwall email subject");
}

//CXB REVIEW_AND_IMPL
- (NSString *)emailText {
  return NSLocalizedString(@"share-prwall-email-text", @"Share prwall email text");
}

//CXB REVIEW_AND_IMPL
- (NSData *)emailAttachmentData {
  
  UIImage *myImage = [UIImage imageNamed:@"prwall"];
  return UIImagePNGRepresentation(myImage);
}

//CXB REVIEW_AND_IMPL
- (NSString *)emailAttachmentFileName {
  return @"prwall";
}

@end
