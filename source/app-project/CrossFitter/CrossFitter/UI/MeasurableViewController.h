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

@interface MeasurableViewController : UIViewController

@property id<Measurable> measurable;

@property IBOutlet UIBarButtonItem* barButtonItemShare;
@property IBOutlet UIBarButtonItem* barButtonItemEdit;
@property IBOutlet UIBarButtonItem* barButtonItemCopy;
@property IBOutlet UIBarButtonItem* barButtonItemLog;

@property (readonly) MeasurableDetailSwitchViewController* measurableDetailSwitchViewController;

@property IBOutlet UIPageControl* pageControlInfoLog;

- (IBAction)editMeasurableAction:(id)sender;
- (IBAction)copyMeasurableAction:(id)sender;
- (IBAction)shareMeasurableAction:(id)sender;
- (IBAction)logMeasurableAction:(id)sender;


@end
