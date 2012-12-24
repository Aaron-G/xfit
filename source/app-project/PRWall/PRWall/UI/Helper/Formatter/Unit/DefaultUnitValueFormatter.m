//
//  DefaultUnitValueFormatter.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/21/12.
//
//

#import "DefaultUnitValueFormatter.h"

@interface DefaultUnitValueFormatter () {
  
}
@end

@implementation DefaultUnitValueFormatter

@synthesize suffixString;
@synthesize numberStyle;
@synthesize unit;

-(id)init {
  self = [super init];
  
  if(self) {
    self.numberFormatter = [[NSNumberFormatter alloc] init];
    [self.numberFormatter setMaximumFractionDigits:2];
    self.numberStyle = NSNumberFormatterDecimalStyle;
    self.unit = [Unit unitForUnitIdentifier:UnitIdentifierNone];
    self.suffixString = nil;
  }
  
  return self;
}
- (NSString *)formatValue:(NSNumber*)value {

  //Convert from system unit to local unit
  NSNumber* localUnitValue = [self.unit.unitSystemConverter convertFromSystemValue:value];
  
  //Set the number style
  self.numberFormatter.numberStyle = self.numberStyle;

  //Append suffix if needed
  if(self.suffixString) {
    self.numberFormatter.positiveSuffix = self.suffixString;
  }

  return [self.numberFormatter stringFromNumber:localUnitValue];
}


@end
