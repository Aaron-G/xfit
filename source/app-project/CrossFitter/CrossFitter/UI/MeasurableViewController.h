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

@property IBOutlet UILabel* nameLabel;

@property IBOutlet UIBarButtonItem* barButtonItemLog;

@property IBOutlet UIToolbar* toolbar;

@property IBOutlet UIBarButtonItem* barButtonItemShareInfo;
@property IBOutlet UIBarButtonItem* barButtonItemEditInfo;
@property IBOutlet UIBarButtonItem* barButtonItemDoneInfo;
@property IBOutlet UIBarButtonItem* barButtonItemCopyMeasurable;

@property IBOutlet UIBarButtonItem* barButtonItemShareLog;
@property IBOutlet UIBarButtonItem* barButtonItemEditLog;
@property IBOutlet UIBarButtonItem* barButtonItemDoneLog;
@property IBOutlet UIBarButtonItem* barButtonItemChartLog;

@property IBOutlet UIBarButtonItem* barButtonItemSpacerOne;
@property IBOutlet UIBarButtonItem* barButtonItemSpacerTwo;

@property (readonly) MeasurableDetailSwitchViewController* measurableDetailSwitchViewController;

@property IBOutlet UIPageControl* measurableDetailPageControl;
@property (readonly) MeasurableTitleView* measurableTitleView;

- (IBAction)copyMeasurableAction:(id)sender;
- (IBAction)logMeasurableAction:(id)sender;
- (IBAction)editMeasurableInfoAction:(id)sender;
- (IBAction)editMeasurableLogAction:(id)sender;
- (IBAction)shareMeasurableInfoAction:(id)sender;
- (IBAction)shareMeasurableLogAction:(id)sender;
- (IBAction)chartMeasurableAction:(id)sender;
- (IBAction)doneEditMeasurableInfoAction:(id)sender;
- (IBAction)doneEditMeasurableLogAction:(id)sender;

@end
