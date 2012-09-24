//
//  FootInchFormatter.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/21/12.
//
//

#import "FootInchFormatter.h"
#import "FootFormatter.h"
#import "InchFormatter.h"

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

- (NSString *)formatValue:(NSNumber*)value {
  
  NSInteger intValue = value.integerValue;
  
  NSInteger feet = intValue / 12;
  NSInteger inches = intValue % 12;
  
  if(inches == 0) {
    return [self.footFormatter formatValue: [NSNumber numberWithInt: feet]];
  } else if (feet == 0) {
    return [self.inchFormatter formatValue: [NSNumber numberWithInt: inches]];
  } else {
    return [NSString stringWithFormat: NSLocalizedString(@"foot-and-inch-format", "%@ %@"),
            [self.footFormatter formatValue: [NSNumber numberWithInt: feet]],
            [self.inchFormatter formatValue: [NSNumber numberWithInt: inches]]];
  }
}

@end
