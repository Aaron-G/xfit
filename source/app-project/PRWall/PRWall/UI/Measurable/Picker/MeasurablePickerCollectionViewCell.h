//
//  MeasurablePickerCollectionViewCell.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/2/13.
//
//

#import <UIKit/UIKit.h>
#import "MeasurablePickerTableViewController.h"

@interface MeasurablePickerCollectionViewCell : UICollectionViewCell

@property IBOutlet UILabel* title;
@property IBOutlet UIButton* image;
@property IBOutlet UITextView* message;
@property IBOutlet UITableView* tableView;
@property MeasurablePickerTableViewController* measurablePickerTableViewController;

@end
