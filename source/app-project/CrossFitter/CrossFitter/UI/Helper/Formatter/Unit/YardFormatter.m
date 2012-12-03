//
//  YardFormatter.m
//  CrossFitter
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
    self.unit = [Unit unitForUnitIdentifier:UnitIdentifierMile];
  }
  
  return self;
}
@end
