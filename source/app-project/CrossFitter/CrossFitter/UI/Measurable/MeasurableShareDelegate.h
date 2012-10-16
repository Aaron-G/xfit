//
//  MeasurableShareDelegate.h
//  CrossFitter
//
//  Created by Cleo Barretto on 10/15/12.
//
//

#import "AppScreenShareDelegate.h"
#import "MeasurableProvider.h"
#import "Measurable.h"

@interface MeasurableShareDelegate : AppScreenShareDelegate

@property id<MeasurableProvider> measurableProvider;

- (id)initWithViewController:(UIViewController *)viewController withMeasurableProvider: (id<MeasurableProvider>) measurableProvider;

@end
