//
//  KilogramFormatter.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "KilogramFormatter.h"

@implementation KilogramFormatter
-(id)init {
  self = [super init];
  
  if(self) {
    self.suffixString = NSLocalizedString(@"kilogram-suffix", @"kg");
  }
  
  return self;
}
- (Unit *)createUnit {
  return [Unit unitForUnitIdentifier:UnitIdentifierKilogram];
}

@end
