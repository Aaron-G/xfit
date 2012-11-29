//
//  MeasurableValuePickerView.h
//  CrossFitter
//
//  Created by Cleo Barretto on 11/24/12.
//
//

#import <UIKit/UIKit.h>
#import "Measurable.h"

@class MeasurableValuePickerView;

@protocol MeasurableValuePickerViewDelegate <NSObject>

@property (readonly) id<Measurable> measurable;

-(void)valueSelectionChangedInMeasurableValuePickerView:(MeasurableValuePickerView*) measurableValuePickerView;

@end

@interface MeasurableValuePickerView : UIPickerView <UIPickerViewDelegate, UIPickerViewDataSource>

@property NSNumber* value;

@property IBOutlet id<MeasurableValuePickerViewDelegate> measurableValuePickerViewDelegate;

- (UILabel*) createLabelForPickerWithText:(NSString*) text andFrame:(CGRect) frame;

@end

