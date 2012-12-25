//
//  MeasurableTimeValuePickerView.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/24/12.
//
//

#import "MeasurableTimeValuePickerView.h"
#import "TimeDuration.h"

@interface MeasurableTimeValuePickerView ()

@property NSInteger secondsValue;
@property NSInteger minutesValue;
@property NSInteger hoursValue;
@property TimeDuration* timeDuration;

@property BOOL labelsInitialized;

@end

@implementation MeasurableTimeValuePickerView

static NSInteger PICKER_WIDTH = 100;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    self.labelsInitialized = NO;
    self.timeDuration = [[TimeDuration alloc]init];
  }
  return self;
}

-(void)layoutSubviews {
  [super layoutSubviews];

  if(!self.labelsInitialized) {
    
    NSArray* labels = [NSArray arrayWithObjects:NSLocalizedString(@"hours-label", @"hours"), NSLocalizedString(@"minutes-label", @"mins"), NSLocalizedString(@"seconds-label", @"secs"), nil];
    
    NSInteger horizontalOffset = 35;
    
    for (int i = 0; i < labels.count; i++) {
      [super labelForPickerWithText: [labels objectAtIndex:i]  andFrame:CGRectMake( (PICKER_WIDTH * i) + horizontalOffset + (i * 2), 94, (PICKER_WIDTH - horizontalOffset), 30)];
    }
    
    self.labelsInitialized = YES;
  }
}

- (NSNumber *)value {  
  return [self.measurableValuePickerViewDelegate.measurable.metadataProvider.unit.unitSystemConverter convertToSystemValue:
          [NSNumber numberWithInt:self.secondsValue + self.minutesValue * 60 + self.hoursValue * 3600]];
}

- (void)setValue:(NSNumber *)value {
  
  NSNumber* localValue = [self.measurableValuePickerViewDelegate.measurable.metadataProvider.unit.unitSystemConverter convertFromSystemValue:value];

  //Makes it easy to figure out the time components
  self.timeDuration.value = localValue.intValue;

  //Update local variables
  self.hoursValue = self.timeDuration.hours;
  self.minutesValue = self.timeDuration.minutes;
  self.secondsValue = self.timeDuration.seconds;
  
  //Update the display
  [self selectRow:self.hoursValue inComponent:0 animated:NO];
  [self selectRow:self.minutesValue inComponent:1 animated:NO];
  [self selectRow:self.secondsValue inComponent:2 animated:NO];
}

///////////////////////////////////////////////////////////////////////
//UIPickerViewDelegate
///////////////////////////////////////////////////////////////////////

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  
  //Update our local value
  if(component == 0) {
    self.hoursValue = row;
  } else if(component == 1) {
    self.minutesValue = row;
  } else if(component == 2) {
    self.secondsValue = row;
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
  return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  
  if(component == 0) {
    return 100;
  } else if (component == 1) {
    return 60;
  } else if (component == 2) {
    return 60;
  }
  
  return 0;
}

@end