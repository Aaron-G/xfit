//
//  MeasurableChartShareDelegate.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/21/12.
//
//

#import "MeasurableChartShareDelegate.h"
#import "MeasurableHelper.h"

@implementation MeasurableChartShareDelegate

- (id)initWithViewController:(UIViewController *)viewController withMeasurableProvider:(id<MeasurableProvider>)measurableProvider {

  self = [super initWithViewController:viewController withMeasurableProvider:measurableProvider];
  
  if(self) {
    self.modalScreenDisplayed = YES;
  }
  return self;  
}

- (NSString *)measurableDetailTitle {
  return NSLocalizedString(@"measurable-detail-chart-title", @"Chart");
}

- (UIImage *)chartImage {
  MeasurableChartViewController* measurableChartViewController = [MeasurableHelper measurableChartViewController];
  return [measurableChartViewController createChartImageForMeasurable:self.measurableProvider.measurable];
}

- (NSData *)emailAttachmentData {
  return UIImagePNGRepresentation([self chartImage]);
}

- (UIImage *)twitterImage {
  return [self chartImage];
}

- (UIImage *)facebookImage {
  return [self chartImage];
}

@end
