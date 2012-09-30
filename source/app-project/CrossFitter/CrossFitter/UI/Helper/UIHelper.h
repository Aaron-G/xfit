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

@interface UIHelper : NSObject

+ (void) adjustImage: (UIButton*) buttonWithImage forMeasurable: (id <Measurable>) measurable;

+ (MeasurableViewController*) measurableViewController;
+ (UIViewController*) viewControllerWithViewControllerIdentifier: (NSString*) identifier;

@end
