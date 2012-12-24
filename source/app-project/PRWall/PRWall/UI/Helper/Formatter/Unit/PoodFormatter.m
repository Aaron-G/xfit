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
    self.unit = [Unit unitForUnitIdentifier:UnitIdentifierPood];
  }
  
  return self;
}
@end
