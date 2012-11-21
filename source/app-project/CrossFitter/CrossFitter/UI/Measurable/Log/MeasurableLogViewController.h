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

//Marks this View Controller as needing to update its view
@property BOOL requiresViewUpdate;

//The location where the view should start displaying its content
@property CGPoint viewLayoutPosition;

- (void) share;
- (void) clearLog;

@end
