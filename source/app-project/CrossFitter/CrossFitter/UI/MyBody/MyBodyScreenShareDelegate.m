//
//  MyBodyScreenShareDelegate.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "MyBodyScreenShareDelegate.h"

@implementation MyBodyScreenShareDelegate

#pragma UIActionSheetDelegate Helper methods

//CXB REVIEW_AND_IMPL
- (NSString*) textMessageText {
  return NSLocalizedString(@"share-mybody-text-message-text", @"Share my body text message text");
}

#pragma MFMaileComposeViewControllerDelegate Helper methods

//CXB REVIEW_AND_IMPL
- (NSString *)emailSubject {
  return NSLocalizedString(@"share-mybody-email-subject", @"Share my body email subject");
}

//CXB REVIEW_AND_IMPL
- (NSString *)emailText {
  return NSLocalizedString(@"share-mybody-email-text", @"Share my body email text");
}

//CXB REVIEW_AND_IMPL
- (NSData *)emailAttachmentData {
  UIImage *myImage = [UIImage imageNamed:@"mybody.png"];
  return UIImagePNGRepresentation(myImage);
}

//CXB REVIEW_AND_IMPL
- (NSString *)emailAttachmentFileName {
  return @"body";
}

- (void) share {
  [super showActionSheetWithTitlePart:NSLocalizedString(@"share-mybody", @"Body Info")];
}

@end
