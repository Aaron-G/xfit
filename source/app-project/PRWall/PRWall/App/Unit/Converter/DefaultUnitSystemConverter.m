//
//  DefaultUnitSystemConverter.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "DefaultUnitSystemConverter.h"

@implementation DefaultUnitSystemConverter

- (id)init
{
  self = [super init];
  if (self) {
    self.convertionFactor = 1.0;
  }
  return self;
}
- (NSNumber*) convertToSystemValue:(NSNumber*) value {
  return [NSNumber numberWithFloat:(value.floatValue * self.convertionFactor)];
}

- (NSNumber*) convertFromSystemValue:(NSNumber*) value {
  return [NSNumber numberWithFloat:(value.floatValue / self.convertionFactor)];
}

@end
