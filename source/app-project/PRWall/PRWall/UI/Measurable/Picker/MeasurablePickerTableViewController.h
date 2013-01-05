//
//  MeasurablePickerTableViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/2/13.
//
//

#import <UIKit/UIKit.h>
#import "MeasurablePickerCollectionViewController.h"

@interface MeasurablePickerTableViewController : UITableViewController

@property NSArray* measurables;

@property NSPredicate* tablePredicate;
@property NSString* tableTitle;
@property NSString* tableImage;

@property id<MeasurablePickerDelegate> measurablePickerDelegate;

@end
