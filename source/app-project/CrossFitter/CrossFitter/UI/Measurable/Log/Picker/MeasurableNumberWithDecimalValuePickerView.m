//
//  MeasurableNumberWithDecimalValuePickerView.m
//  CrossFitter
//
//  Created by Cleo Barretto on 11/24/12.
//
//

#import "MeasurableNumberWithDecimalValuePickerView.h"

@interface MeasurableNumberWithDecimalValuePickerView ()

@end

@implementation MeasurableNumberWithDecimalValuePickerView

- (NSNumber *)value {  
  return [self.measurableValuePickerViewDelegate.measurable.metadataProvider.unit.unitSystemConverter convertToSystemValue:
          [NSNumber numberWithFloat:(self.numberValue + ((CGFloat)self.decimalValue)/100)]];
}

- (void)setValue:(NSNumber *)value {

  NSNumber* localValue = [self.measurableValuePickerViewDelegate.measurable.metadataProvider.unit.unitSystemConverter convertFromSystemValue:value];

  //Update local variables
  self.numberValue = localValue.intValue;
  self.decimalValue = (localValue.floatValue - self.numberValue) * 10;
  
  //Update the display
  [self selectRow:self.numberValue inComponent:0 animated:NO];
  [self selectRow:self.decimalValue inComponent:1 animated:NO];
}

///////////////////////////////////////////////////////////////////////
//UIPickerViewDelegate
///////////////////////////////////////////////////////////////////////

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
  if (component == 1) {
    return [super pickerView:pickerView viewForRow:row*10 forComponent:component reusingView:view];
  } else {
    return [super pickerView:pickerView viewForRow:row forComponent:component reusingView:view];
  }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

  //Update our local values
  if(component == 0) {
    self.numberValue = row;
  } else if(component == 1) {
    self.decimalValue = row * 10;
  }
  
  //Trigger notification
  [self.measurableValuePickerViewDelegate valueSelectionChangedInMeasurableValuePickerView:self];
}

///////////////////////////////////////////////////////////////////////
//UIPickerViewDataSource
///////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  
  if(component == 0) {
    return 1000;
  } else if (component == 1) {
    return 10;
  }
  
  return 0;
}


@end
