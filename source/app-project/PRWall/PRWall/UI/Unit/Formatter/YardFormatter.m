//
//  YardFormatter.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "YardFormatter.h"

@implementation YardFormatter
-(id)init {
  self = [super init];
  
  if(self) {
    self.suffixString = NSLocalizedString(@"yard-suffix", @"yd");
  }
  
  return self;
}
- (Unit *)createUnit {
  return [Unit unitForUnitIdentifier:UnitIdentifierYard];
}

@end
