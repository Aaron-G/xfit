//
//  DefaultUnitValueFormatter.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/21/12.
//
//

#import "DefaultUnitValueFormatter.h"

@interface DefaultUnitValueFormatter () {
  
}
@property NSNumberFormatter* numberFormatter;

@end

@implementation DefaultUnitValueFormatter

@synthesize suffixString;
@synthesize numberStyle;

-(id)init {
  self = [super init];
  
  if(self) {
    self.numberFormatter = [[NSNumberFormatter alloc] init];
    self.numberStyle = NSNumberFormatterDecimalStyle;
    self.suffixString = nil;
  }
  
  return self;
}
- (NSString *)formatValue:(NSNumber*)value {

  //Set the number style
  self.numberFormatter.numberStyle = self.numberStyle;

  //Append suffix if needed
  if(self.suffixString) {
    self.numberFormatter.positiveSuffix = self.suffixString;
  }

  return [self.numberFormatter stringFromNumber:value];
}


@end
