//
//  MeasurableDataEntryTableViewCell.h
//  PR Wall
//
//  Created by Cleo Barretto on 10/8/12.
//
//

#import <UIKit/UIKit.h>
#import "MeasurableDataEntry.h"
@interface MeasurableDataEntryTableViewCell : UITableViewCell

extern const NSInteger MeasurableDataEntryTableViewCellHeight;

@property IBOutlet UILabel* measurableValueLabel;
@property IBOutlet UILabel* measurableDateLabel;
@property IBOutlet UIButton* measurableTrendImageButton;
@property IBOutlet UIButton* measurableAdditionalInfoImageButton;

@property MeasurableDataEntry* measurableDataEntry;

@end
