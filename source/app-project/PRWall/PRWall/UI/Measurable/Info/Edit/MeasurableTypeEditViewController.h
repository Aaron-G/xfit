//
//  MeasurableTypeEditViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/27/12.
//
//

#import <UIKit/UIKit.h>

#import "Measurable.h"

@protocol MeasurableTypeEditViewControllerDelegate <NSObject>

- (void) didChangeMeasurableType:(MeasurableType*) measurableType;

@end

@interface MeasurableTypeEditViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property IBOutlet UITableView* tableView;
@property id<MeasurableTypeEditViewControllerDelegate> delegate;

- (void) editMeasurableType:(MeasurableType*) measurableType;

@end