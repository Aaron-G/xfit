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
  self = [super init];
  
  if(self) {
    self.measurableProvider = measurableProvider;
  }
  return self;
}

- (void) share {
  [self showActionSheetWithTitlePart:[NSString stringWithFormat:@"%@ %@", self.measurableProvider.measurable.metadataProvider.type.displayName, self.measurableDetailTitle]];
}

- (void) shareFromToolBar:(UIToolbar*) toolbar {
  [self showActionSheetWithTitlePart:[NSString stringWithFormat:@"%@ %@", self.measurableProvider.measurable.metadataProvider.type.displayName, self.measurableDetailTitle] fromToolBar:toolbar];
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
  UIImage *myImage = [UIImage imageNamed:@"move.png"];
  return UIImagePNGRepresentation(myImage);
}

- (NSString *)emailAttachmentFileName {
  return @"move";
}

@end
