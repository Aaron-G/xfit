//
//  MeasurablePickerContainerViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/3/13.
//
//

#import <UIKit/UIKit.h>
#import "Measurable.h"
#import "MeasurablePickerDelegate.h"
#import "MeasurableCategory.h"

@interface MeasurablePickerContainerViewController : UIViewController

@property IBOutlet UIPageControl* pageControl;

- (void) pickMeasurableOfCategory:(MeasurableCategory*) measurableCategory fromMeasurables:(NSArray*) measurables withTitle:(NSString*) title withDelegate:(id<MeasurablePickerDelegate>) delegate;

@end
