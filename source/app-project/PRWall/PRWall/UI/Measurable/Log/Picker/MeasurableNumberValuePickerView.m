//
//  MeasurableNumberValuePickerView.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/24/12.
//
//

#import "MeasurableNumberValuePickerView.h"
#import "DefaultUnitValueFormatter.h"

@interface MeasurableNumberValuePickerView ()

@property NSInteger numberValue;
@property (readonly) NSString* valueUnitTitle;

@end

@implementation MeasurableNumberValuePickerView

@synthesize valueUnitTitle = _valueUnitTitle;

- (NSNumber *)value {
  return [self.measurableValuePickerViewDelegate.unit.unitSystemConverter convertToSystemValue:
          [NSNumber numberWithInt:self.numberValue]];
}

- (void)setValue:(NSNumber *)value {
  
  //Update local variables
  self.numberValue = [[self.measurableValuePickerViewDelegate.unit.unitSystemConverter convertFromSystemValue:value] intValue];
  
  //Update the display based on the new value
  [self selectRow:self.numberValue inComponent:0 animated:NO];
}

- (NSString*)valueUnitTitle {
  
  Unit* unit = self.measurableValuePickerViewDelegate.unit;
  
  if(!_valueUnitTitle && unit) {
    
    if([unit.valueFormatter isKindOfClass: [DefaultUnitValueFormatter class]]) {
      _valueUnitTitle = ((DefaultUnitValueFormatter*)unit.valueFormatter).suffixString;
    }
  }
  
  return _valueUnitTitle;
}

///////////////////////////////////////////////////////////////////////
//UIPickerViewDelegate
///////////////////////////////////////////////////////////////////////

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  
  //Update our local value
  self.numberValue = row;
  
  //Trigger notification
  [self.measurableValuePickerViewDelegate valueSelectionChangedInMeasurableValuePickerView:self];
}

///////////////////////////////////////////////////////////////////////
//UIPickerViewDataSource
///////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return 1000;
}

@end
