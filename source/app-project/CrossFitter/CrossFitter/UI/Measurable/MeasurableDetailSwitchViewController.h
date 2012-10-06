//
//  MeasurableDetailSwitchViewController.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/30/12.
//
//

#import <UIKit/UIKit.h>
#import "Measurable.h"
#import "MeasurableInfoViewController.h"
#import "MeasurableLogViewController.h"
#import "MeasurableTitleView.h"

@interface MeasurableDetailSwitchViewController : UICollectionViewController

@property id<Measurable> measurable;
@property MeasurableInfoViewController* infoViewController;
@property MeasurableLogViewController* logViewController;

@property UIPageControl* measurableDetailPageControl;
@property MeasurableTitleView* measurableTitleView;

@end
