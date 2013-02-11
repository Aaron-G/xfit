//
//  MeasurableShareDelegate.m
//  PR Wall
//
//  Created by Cleo Barretto on 10/15/12.
//
//

#import "MeasurableShareDelegate.h"

@implementation MeasurableShareDelegate

- (id)initWithViewController:(UIViewController *)viewController withMeasurableProvider: (id<MeasurableProvider>) measurableProvider {
  self = [super init];
  
  if(self) {
    self.viewController = viewController;
    self.measurableProvider = measurableProvider;
  }
  return self;
}

- (void) share {
  [self showActionSheetWithTitlePart:[NSString stringWithFormat:@"%@ %@", self.measurableProvider.measurable.metadata.category.name, self.measurableDetailTitle]];
}

- (void) shareFromToolBar:(UIToolbar*) toolbar {
  [self showActionSheetWithTitlePart:[NSString stringWithFormat:@"%@ %@", self.measurableProvider.measurable.metadata.category.name, self.measurableDetailTitle] fromToolBar:toolbar];
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
  UIImage *myImage = [UIImage imageNamed:@"exercise.png"];
  return UIImagePNGRepresentation(myImage);
}

- (NSString *)emailAttachmentFileName {
  return @"exercise";
}

@end
