//
//  MeasurableValuePickerView.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/24/12.
//
//

#import "MeasurableValuePickerView.h"

@implementation MeasurableValuePickerView

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    
    // Initialization code
    self.delegate = self;
    self.dataSource = self;
  }
  return self;
  
}

///////////////////////////////////////////////////////////////////////
//UIPickerViewDelegate
///////////////////////////////////////////////////////////////////////
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
  return 50;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
  return 120;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  [self.measurableValuePickerViewDelegate valueSelectionChangedInMeasurableValuePickerView:self];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
  UILabel* valueLabel = (view) ? (UILabel*)view : [self labelForRow];
  valueLabel.text = [NSString stringWithFormat:@"%d", row];
  return valueLabel;
}


///////////////////////////////////////////////////////////////////////
//UIPickerViewDataSource
///////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return 0;
}

///////////////////////////////////////////////////////////////////////
//Subclass methods
///////////////////////////////////////////////////////////////////////
- (UILabel*) labelForPickerWithText:(NSString*) text andFrame:(CGRect) frame {
  UILabel *label = [[UILabel alloc] initWithFrame:frame];
  label.textAlignment = kCTLeftTextAlignment;
  label.text = text;
  label.font = [UIFont boldSystemFontOfSize:16];
  label.backgroundColor = [UIColor clearColor];
  label.shadowColor = [UIColor whiteColor];
  label.shadowOffset = CGSizeMake (0,1);
  [self addSubview:label];
  [self bringSubviewToFront:label];
  return label;
}

- (UILabel*) labelForRow {
  UILabel* label = [[UILabel alloc]init];
  label.font = [UIFont boldSystemFontOfSize:20];
  return label;
}

@end
