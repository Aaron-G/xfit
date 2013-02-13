//
//  FootFormatter.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/24/12.
//
//

#import "FootFormatter.h"

@implementation FootFormatter

-(id)init {
  self = [super init];
  
  if(self) {
    self.suffixString = NSLocalizedString(@"foot-suffix", @"'");
  }
  
  return self;
}
- (Unit *)createUnit {
  return [Unit unitForUnitIdentifier:UnitIdentifierFoot];
}

@end