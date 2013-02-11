//
//  FootInchFormatter.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/21/12.
//
//

#import "FootInchFormatter.h"
#import "FootFormatter.h"
#import "InchFormatter.h"
#import "Unit.h"

@interface FootInchFormatter () {
  
}
@property FootFormatter* footFormatter;
@property InchFormatter* inchFormatter;

@end

@implementation FootInchFormatter

-(id)init {
  self = [super init];
  
  if(self) {
    self.footFormatter = [[FootFormatter alloc] init];
    self.inchFormatter = [[InchFormatter alloc] init];
  }
  
  return self;
}

- (Unit *)createUnit {
  return [Unit unitForUnitIdentifier:UnitIdentifierNone];
}

- (NSString *)formatValue:(NSNumber*)value {
  
  //Convert from system unit to local unit - we want inches here
  NSNumber* localUnitValue = [self.footFormatter.unit.unitSystemConverter convertFromSystemValue:value];

  NSInteger feet = localUnitValue.integerValue;
  NSInteger inches = (localUnitValue.floatValue - feet) * 12;
  
  if(inches == 0) {
    return [self.footFormatter formatValue: [self.footFormatter.unit.unitSystemConverter convertToSystemValue: [NSNumber numberWithInt:feet]]];
  } else if (feet == 0) {
    return [self.inchFormatter formatValue: [self.inchFormatter.unit.unitSystemConverter convertToSystemValue: [NSNumber numberWithInt:inches]]];
  } else {
    return [NSString stringWithFormat: NSLocalizedString(@"foot-and-inch-format", "%@ %@"),
            [self.footFormatter formatValue: [self.footFormatter.unit.unitSystemConverter convertToSystemValue: [NSNumber numberWithInt:feet]]],
            [self.inchFormatter formatValue: [self.inchFormatter.unit.unitSystemConverter convertToSystemValue: [NSNumber numberWithInt:inches]]]];
  }
}

@end
