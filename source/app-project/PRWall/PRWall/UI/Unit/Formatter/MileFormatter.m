//
//  MileFormatter.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "MileFormatter.h"

@implementation MileFormatter

-(id)init {
  self = [super init];
  
  if(self) {
    self.suffixString = NSLocalizedString(@"mile-suffix", @"mi");
  }
  
  return self;
}
- (Unit *)createUnit {
  return [Unit unitForUnitIdentifier:UnitIdentifierMile];
}

@end
