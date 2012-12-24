//
//  MeasurableTableViewCell.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import <UIKit/UIKit.h>

@interface MeasurableTableViewCell : UITableViewCell

@property IBOutlet UILabel* measurableNameLabel;
@property IBOutlet UILabel* measurableValueLabel;
@property IBOutlet UILabel* measurableMetadataLabel;
@property IBOutlet UILabel* measurableDateLabel;
@property IBOutlet UIButton* measurableTrendImageButton;

@end
