//
//  TimeDuration.m
//  CrossFitter
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "TimeDuration.h"

@implementation TimeDuration

@synthesize value = _value;
@synthesize hours = _hours;
@synthesize minutes = _minutes;
@synthesize seconds = _seconds;

- (void)setValue:(NSInteger)value {
  _value = value;
  _hours = value/3600;
  _minutes = (value % 3600)/60;
  _seconds = (value % 60);
}

- (NSInteger)value {
  return _value;
}

@end
