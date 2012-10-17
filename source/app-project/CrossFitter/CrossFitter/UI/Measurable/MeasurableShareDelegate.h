//
//  MeasurableShareDelegate.h
//  CrossFitter
//
//  Created by Cleo Barretto on 10/15/12.
//
//

#import "ShareDelegate.h"
#import "MeasurableProvider.h"
#import "Measurable.h"

@interface MeasurableShareDelegate : ShareDelegate

@property id<MeasurableProvider> measurableProvider;
@property (readonly) NSString* measurableDetailTitle;

- (id)initWithViewController:(UIViewController *)viewController withMeasurableProvider: (id<MeasurableProvider>) measurableProvider;

@end
