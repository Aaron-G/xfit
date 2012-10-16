//
//  MeasurableShareDelegate.m
//  CrossFitter
//
//  Created by Cleo Barretto on 10/15/12.
//
//

#import "MeasurableShareDelegate.h"

@implementation MeasurableShareDelegate

- (id)initWithViewController:(UIViewController *)viewController withMeasurableProvider: (id<MeasurableProvider>) measurableProvider {
  self = [super initWithViewController:viewController];
  
  if(self) {
    self.measurableProvider = measurableProvider;
  }
  return self;
}

- (void) share {
  [super showActionSheetWithTitlePart:self.measurableProvider.measurable.metadataProvider.type.displayName];
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
