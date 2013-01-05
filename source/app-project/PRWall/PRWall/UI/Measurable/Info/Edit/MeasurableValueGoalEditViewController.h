//
//  MeasurableValueGoalEditViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/28/12.
//
//

#import <UIKit/UIKit.h>
#import "Measurable.h"

@protocol MeasurableValueGoalEditViewControllerDelegate <NSObject>

- (void) didChangeMeasurableValueGoal:(MeasurableValueGoal) measurableValueGoal;

@end

@interface MeasurableValueGoalEditViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property IBOutlet UITableView* tableView;
@property id<MeasurableValueGoalEditViewControllerDelegate> delegate;

- (void) editMeasurableValueGoal:(MeasurableValueGoal) measurableValueGoal;

@end