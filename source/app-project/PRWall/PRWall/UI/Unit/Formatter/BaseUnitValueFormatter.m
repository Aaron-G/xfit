//
//  BaseUnitValueFormatter.m
//  PR Wall
//
//  Created by Cleo Barretto on 2/9/13.
//
//

#import "BaseUnitValueFormatter.h"

@implementation BaseUnitValueFormatter

@synthesize unit = _unit;

- (Unit *)unit {
  
  //IMPL NOTE
  //We use lazily initialization of this property so that we can
  //ensure the initialization of Units is complete
  if(!_unit) {
    _unit = [self createUnit];
  }
  return _unit;
}

- (NSString *)formatValue:(NSNumber*)value {
  return nil;
}

- (Unit *)createUnit {
  return nil;
}

@end
