//
//  MeasurablePercentValuePickerView.m
//  CrossFitter
//
//  Created by Cleo Barretto on 11/24/12.
//
//

#import "MeasurablePercentValuePickerView.h"

@implementation MeasurablePercentValuePickerView

- (void)setValue:(NSNumber *)value {
  
  //Update local variables
  self.numberValue = value.intValue;
  self.decimalValue = (value.floatValue - self.numberValue) * 100;
  
  //Update the display
  [self selectRow:self.numberValue inComponent:0 animated:NO];
  [self selectRow:self.decimalValue inComponent:1 animated:NO];
}

///////////////////////////////////////////////////////////////////////
//UIPickerViewDelegate
///////////////////////////////////////////////////////////////////////

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
  UILabel* valueLabel = (view) ? (UILabel*)view : [[UILabel alloc]init];
  valueLabel.text = [NSString stringWithFormat:@"%d", row];
  return valueLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  
  //Update our local values
  if(component == 0) {
    self.numberValue = row;
  } else if(component == 1) {
    self.decimalValue = row;
  }
  
  //Trigger notification
  [self.measurableValuePickerViewDelegate valueSelectionChangedInMeasurableValuePickerView:self];
}

///////////////////////////////////////////////////////////////////////
//UIPickerViewDataSource
///////////////////////////////////////////////////////////////////////

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  
  if(component == 0) {
    return 100;
  } else if (component == 1) {
    return 100;
  }
  
  return 0;
}

@end
