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

@interface MeasurableLogViewController : UIViewController <MeasurableProvider, UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property id<Measurable> measurable;
@property IBOutlet UITableView* tableView;

- (void) share;

- (void) clearLog;

@end
