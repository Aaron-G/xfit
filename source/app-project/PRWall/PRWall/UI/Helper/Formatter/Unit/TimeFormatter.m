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
    formattedValue = [NSString stringWithFormat:@"%d%@", self.timeDuration.hours, NSLocalizedString(@"hour-short-label", @"hr")];
  }
  
  if (self.timeDuration.minutes) {
    if(formattedValue) {
      formattedValue = [NSString stringWithFormat:@"%@ %d%@", formattedValue, self.timeDuration.minutes, NSLocalizedString(@"minute-short-label", @"min")];
    } else {
      formattedValue = [NSString stringWithFormat:@"%d%@", self.timeDuration.minutes, NSLocalizedString(@"minute-short-label", @"min")];
    }
  }
  
  if (self.timeDuration.seconds) {
    if(formattedValue) {
      formattedValue = [NSString stringWithFormat:@"%@ %d%@", formattedValue, self.timeDuration.seconds, NSLocalizedString(@"second-short-label", @"sec")];
    } else {
      formattedValue = [NSString stringWithFormat:@"%d%@", self.timeDuration.seconds, NSLocalizedString(@"second-short-label", @"sec")];
    }
  }
  
  return formattedValue;
}

@end
