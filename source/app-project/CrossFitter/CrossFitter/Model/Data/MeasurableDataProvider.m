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
@synthesize valueTrend;

@synthesize value;
@synthesize date;
@synthesize comment;

@synthesize firstValue;

- (id)initWithMeasurableIdentifier:(NSString*) measurableIdentifier {
  self = [super init];
  
  if (self) {
    _measurableIdentifier = measurableIdentifier;
  }
  return self;
}

- (MeasurableValueTrend)valueTrend {
  return self.firstValue.valueTrend;
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
  [self updateValueTrends];
}

- (void)updateFirstValue {
  
  if(self.values && self.values.count > 0) {
    self.firstValue = [self.values objectAtIndex:0];
  } else {
    self.firstValue = nil;
  }
}

- (void)updateValueTrends {
  
  CGFloat curValue;
  CGFloat previousValue;

  MeasurableDataEntry* previousDataEntry = nil;
  
  for (NSInteger i = self.values.count-1; i>=0 ; i--) {
    
    MeasurableDataEntry* curDataEntry = [_values objectAtIndex:i];
    
    curValue = [curDataEntry.value floatValue];
    
    if(previousDataEntry) {
      
      previousValue = [previousDataEntry.value floatValue];
      
      if (curValue > previousValue) {
        curDataEntry.valueTrend = MeasurableValueTrendUp;
      } else if (curValue < previousValue) {
        curDataEntry.valueTrend = MeasurableValueTrendDown;
      } else {
        curDataEntry.valueTrend = MeasurableValueTrendSame;
      }
    } else {
      curDataEntry.valueTrend = MeasurableValueTrendNone;
    }
    
    previousDataEntry = curDataEntry;    
  }
}


@end
