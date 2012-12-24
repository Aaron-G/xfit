//
//  MeasurableLogViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/30/12.
//
//

#import <UIKit/UIKit.h>
#import "Measurable.h"
#import "MeasurableProvider.h"
#import "MeasurableDataEntryViewController.h"
#import "MeasurableLayoutViewController.h"

@interface MeasurableLogViewController : MeasurableLayoutViewController <UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate, MeasurableDataEntryDelegate>

@property IBOutlet UITableView* tableView;
@property IBOutlet UITextView* messageTextView;

- (void) share;
- (void) clearLog;

- (void) logMeasurableDataEntry:(MeasurableDataEntry*)measurableDataEntry;

@end
