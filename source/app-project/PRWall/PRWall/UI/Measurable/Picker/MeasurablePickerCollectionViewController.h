//
//  MeasurablePickerCollectionViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/2/13.
//
//

#import <UIKit/UIKit.h>
#import "Measurable.h"
#import "MeasurablePickerDelegate.h"

@interface MeasurablePickerCollectionViewController : UICollectionViewController

@property UIPageControl* pickerPageControl;

- (void) pickMeasurableOfType:(MeasurableType*) measurableType fromMeasurables:(NSArray*) measurables withDelegate:(id<MeasurablePickerDelegate>) delegate;

@end
