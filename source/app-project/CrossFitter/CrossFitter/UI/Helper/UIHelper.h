//
//  UIHelper.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/9/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"
#import "MeasurableViewController.h"
#import "AppViewController.h"

@interface UIHelper : NSObject

+ (void) adjustImage: (UIButton*) buttonWithImage withMeasurableValueTrend: (MeasurableValueTrend) measurableValueTrend withMeasurableValueTrendBetterDirection: (MeasurableValueTrendBetterDirection) valueTrendBetterDirection;

+ (void) adjustImage: (UIButton*) buttonWithImage forMeasurable: (id <Measurable>) measurable;

+ (AppViewController*) appViewController;

+ (MeasurableViewController*) measurableViewController;

//Returns a new instance of the UIViewController that has the provided
//identifier on the Storyboard.
+ (UIViewController*) viewControllerWithViewStoryboardIdentifier: (NSString*) identifier;

@end
 