//
//  MeasurableDataEntryAdditionalInfoTableViewCell.h
//  PR Wall
//
//  Created by Cleo Barretto on 11/10/12.
//
//

#import <UIKit/UIKit.h>
#import "MeasurableDataEntry.h"

@interface MeasurableDataEntryAdditionalInfoTableViewCell : UITableViewCell

@property IBOutlet UICollectionView* mediaCollectionView;
@property IBOutlet UITextView* commentTextView;

@property MeasurableDataEntry* measurableDataEntry;
@property CGFloat minimumHeight;
@end
