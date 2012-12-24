//
//  MeasurableFootInchValuePickerView.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/25/12.
//
//

#import "MeasurableFootInchValuePickerView.h"

@interface MeasurableFootInchValuePickerView ()

@property NSInteger feetValue;
@property NSInteger inchesValue;

@property BOOL labelsInitialized;

@end

@implementation MeasurableFootInchValuePickerView

static NSInteger PICKER_WIDTH = 100;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    self.labelsInitialized = NO;
  }
  return self;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  if(!self.labelsInitialized) {
    
    NSArray* labels = [NSArray arrayWithObjects: NSLocalizedString(@"feet-label", @"feet"), NSLocalizedString(@"inches-label", @"inches"), nil];
    
    NSInteger horizontalOffset = 85;
    
    for (int i = 0; i < labels.count; i++) {
      [super labelForPickerWithText: [labels objectAtIndex:i]  andFrame:CGRectMake( (PICKER_WIDTH * i) + horizontalOffset + 2, 94, 60, 30)];
    }
    
    self.labelsInitialized = YES;
  }
}

- (NSNumber *)value {
  
  NSNumber* valueFromFeet = [[Unit unitForUnitIdentifier:UnitIdentifierFoot].unitSystemConverter convertToSystemValue:[NSNumber numberWithInt:self.feetValue]];
  NSNumber* valueFromInch = [[Unit unitForUnitIdentifier:UnitIdentifierInch].unitSystemConverter convertToSystemValue:[NSNumber numberWithInt:self.inchesValue]];
  
  return [NSNumber numberWithFloat: (valueFromFeet.floatValue + valueFromInch.floatValue)];
}

- (void)setValue:(NSNumber *)value {
  
  NSNumber* localValue = [[Unit unitForUnitIdentifier:UnitIdentifierFoot].unitSystemConverter convertFromSystemValue:value];

  //Update local variables
  self.feetValue = localValue.integerValue;
  self.inchesValue = (localValue.floatValue - self.feetValue) * 12;
  
  //Update the display
  [self selectRow:self.feetValue inComponent:0 animated:NO];
  [self selectRow:self.inchesValue inComponent:1 animated:NO];
}

///////////////////////////////////////////////////////////////////////
//UIPickerViewDelegate
///////////////////////////////////////////////////////////////////////

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  
  //Update our local value
  if(component == 0) {
    self.feetValue = row;
  } else if(component == 1) {
    self.inchesValue = row;
  }
  
  //Trigger notification
  [self.measurableValuePickerViewDelegate valueSelectionChangedInMeasurableValuePickerView:self];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
  return PICKER_WIDTH;
}

///////////////////////////////////////////////////////////////////////
//UIPickerViewDataSource
///////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  
  if(component == 0) {
    return 100;
  } else if (component == 1) {
    return 12;
  }
  
  return 0;
}

@end
