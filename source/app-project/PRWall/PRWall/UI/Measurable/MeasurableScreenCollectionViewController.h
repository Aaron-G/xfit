//
//  MeasurableScreenCollectionViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/30/12.
//
//

#import <UIKit/UIKit.h>
#import "Measurable.h"
#import "MeasurableViewController.h"
#import "MeasurableInfoViewController.h"
#import "MeasurableLogViewController.h"
#import "MeasurableTitleView.h"

@class MeasurableViewController;

@interface MeasurableScreenCollectionViewController : UICollectionViewController

@property id<Measurable> measurable;
@property MeasurableInfoViewController* infoViewController;
@property MeasurableLogViewController* logViewController;
@property (readonly) NSArray* logToolbarItems;
@property (readonly) NSArray* infoToolbarItems;

- (void)displayMeasurableInfo;
- (void)displayMeasurableLog;
- (UIViewController*) displayedMeasurableScreen;

@end
