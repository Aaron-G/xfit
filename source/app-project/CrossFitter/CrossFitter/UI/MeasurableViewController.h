//
//  MeasurableViewController.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/29/12.
//
//

#import <UIKit/UIKit.h>
#import "Measurable.h"
#import "MeasurableDetailSwitchViewController.h"
#import "MeasurableTitleView.h"

@class MeasurableDetailSwitchViewController;

@interface MeasurableViewController : UIViewController

@property id<Measurable> measurable;

@property IBOutlet UIBarButtonItem* barButtonItemLog;

@property IBOutlet UIToolbar* toolbar;

@property IBOutlet UIBarButtonItem* barButtonItemShareInfo;
@property IBOutlet UIBarButtonItem* barButtonItemEditInfo;
@property IBOutlet UIBarButtonItem* barButtonItemCopyMeasurable;

@property IBOutlet UIBarButtonItem* barButtonItemShareLog;
@property IBOutlet UIBarButtonItem* barButtonItemEditLog;
@property IBOutlet UIBarButtonItem* barButtonItemChartLog;

@property IBOutlet UIBarButtonItem* barButtonItemSpacerOne;
@property IBOutlet UIBarButtonItem* barButtonItemSpacerTwo;

@property (readonly) MeasurableDetailSwitchViewController* measurableDetailSwitchViewController;

@property IBOutlet UIPageControl* measurableDetailPageControl;
@property (readonly) MeasurableTitleView* measurableTitleView;

- (IBAction)editMeasurableAction:(id)sender;
- (IBAction)copyMeasurableAction:(id)sender;
- (IBAction)shareMeasurableAction:(id)sender;
- (IBAction)logMeasurableAction:(id)sender;


@end
