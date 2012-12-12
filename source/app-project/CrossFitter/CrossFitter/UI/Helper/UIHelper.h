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
#import "UserProfileViewController.h"
#import "ImageDisplayViewController.h"

@interface UIHelper : NSObject

+ (void) adjustImage: (UIButton*) buttonWithImage withMeasurableValueTrend: (MeasurableValueTrend) measurableValueTrend withMeasurableValueTrendBetterDirection: (MeasurableValueTrendBetterDirection) valueTrendBetterDirection;

+ (void) adjustImage: (UIButton*) buttonWithImage forMeasurable: (id <Measurable>) measurable;

+ (AppViewController*) appViewController;

+ (MeasurableViewController*) measurableViewController;

+ (UserProfileViewController*) userProfileViewController;

+ (ImageDisplayViewController*) imageDisplayViewController;

//Returns a new instance of the UIViewController that has the provided
//identifier on the Storyboard.
+ (UIViewController*) viewControllerWithViewStoryboardIdentifier: (NSString*) identifier;

+ (NSDateFormatter *)appDateFormat;

+ (void) showMessage:(NSString*) message withTitle:(NSString*) title;

+ (CGFloat) moveToYLocation:(CGFloat) yLocation reshapeWithSize:(CGSize) size orHide:(BOOL) hide view:(UIView*) view withVerticalSpacing:(NSInteger) verticalSpacing;

+ (NSUInteger)supportedInterfaceOrientations;

+ (NSUInteger)supportedInterfaceOrientationsWithLandscape;

+ (BOOL) isEmptyString:(NSString*) string;

+ (void)applyFontToSegmentedControl:(UISegmentedControl*) segmentedControl;

+ (void) clearSelectionInTableView:(UITableView*) tableView afterDelay:(CGFloat) delay;

@end
 