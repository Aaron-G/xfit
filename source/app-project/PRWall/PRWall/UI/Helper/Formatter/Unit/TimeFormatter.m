//
//  TimeFormatter.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "TimeFormatter.h"
#import "TimeDuration.h"

@interface TimeFormatter () {
  
}
@property TimeDuration* timeDuration;

@end

@implementation TimeFormatter

@synthesize unit;

-(id)init {
  self = [super init];
  
  if(self) {
    self.unit = [Unit unitForUnitIdentifier:UnitIdentifierSecond];
    self.timeDuration = [[TimeDuration alloc]init];
  }
  
  return self;
}

- (NSString *)formatValue:(NSNumber*)value {
  
  //Convert from system unit to local unit - we want seconds here
  NSNumber* localUnitValue = [self.unit.unitSystemConverter convertFromSystemValue:value];
  
  self.timeDuration.value = localUnitValue.intValue;
  
  NSString* formattedValue = nil;
  
  if(self.timeDuration.hours) {
    formattedValue = [NSString stringWithFormat:@"%dh", self.timeDuration.hours];
  }
  
  if (self.timeDuration.minutes) {
    formattedValue = [NSString stringWithFormat:@"%@%dm", formattedValue, self.timeDuration.minutes];
  }
  
  if (self.timeDuration.minutes) {
    formattedValue = [NSString stringWithFormat:@"%@%ds", formattedValue, self.timeDuration.minutes];
  }
  
  return formattedValue;
}

@end
