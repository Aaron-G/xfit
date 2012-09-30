//
//  MeasurableDataProvider.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import "MeasurableDataProvider.h"
#import "MeasurableDataEntry.h"

@interface MeasurableDataProvider () {

}

@property MeasurableDataEntry* firstValue;

@end

@implementation MeasurableDataProvider

@synthesize measurableIdentifier = _measurableIdentifier;
@synthesize values =_values;
@synthesize valueTrend = _valueTrend;

@synthesize value;
@synthesize date;
@synthesize comment;

@synthesize firstValue;

- (id)initWithMeasurableIdentifier:(NSString*) measurableIdentifier {
  self = [super init];
  
  if (self) {
    _measurableIdentifier = measurableIdentifier;
    _valueTrend = kMeasurableValueTrendNone;
  }
  return self;
}

- (NSNumber *)value {
  return self.firstValue.value;
}

- (NSDate *)date {
  return self.firstValue.date;
}

- (NSString *)comment {
  return self.firstValue.comment;
}

- (NSArray *)values {
  return _values;
}

- (void)setValues:(NSArray *)values {
  _values = values;
  
  //1 - Update Trend
  [self updateFirstValue];
  
  //2 - Update 1st value
  [self updateValueTrend];
}

- (void)updateFirstValue {
  
  if(self.values && self.values.count > 0) {
    self.firstValue = [self.values objectAtIndex:0];
  } else {
    self.firstValue = nil;
  }
}

- (void)updateValueTrend {
  
  if (_values.count < 2) {
    _valueTrend = kMeasurableValueTrendNone;
  } else {
    
    MeasurableDataEntry* valueLast = [_values objectAtIndex:0];
    MeasurableDataEntry* valueBeforeLast = [_values objectAtIndex:1];
    
    if([valueLast.value floatValue] > [valueBeforeLast.value floatValue]) {
      _valueTrend = kMeasurableValueTrendUp;
    } else if([valueLast.value floatValue] < [valueBeforeLast.value floatValue]) {
      _valueTrend = kMeasurableValueTrendDown;
    } else {
      _valueTrend = kMeasurableValueTrendSame;
    }
  }
}


@end
