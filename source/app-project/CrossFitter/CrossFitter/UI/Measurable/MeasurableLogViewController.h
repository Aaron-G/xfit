//
//  MeasurableLogViewController.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/30/12.
//
//

#import <UIKit/UIKit.h>
#import "Measurable.h"
#import "MeasurableProvider.h"

@interface MeasurableLogViewController : UITableViewController <MeasurableProvider, UIAlertViewDelegate>

@property id<Measurable> measurable;

- (void) share;

- (void) clearLog;

@end
