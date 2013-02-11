//
//  PoodFormatter.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "PoodFormatter.h"

@implementation PoodFormatter
-(id)init {
  self = [super init];
  
  if(self) {
    self.suffixString = NSLocalizedString(@"pood-suffix", @"pu");
  }
  
  return self;
}
- (Unit *)createUnit {
  return [Unit unitForUnitIdentifier:UnitIdentifierPood];
}

@end
