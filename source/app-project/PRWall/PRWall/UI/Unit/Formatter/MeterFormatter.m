//
//  MeterFormatter.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "MeterFormatter.h"

@implementation MeterFormatter

-(id)init {
  self = [super init];
  
  if(self) {
    self.suffixString = NSLocalizedString(@"meter-suffix", @"m");
  }
  
  return self;
}
- (Unit *)createUnit {
  return [Unit unitForUnitIdentifier:UnitIdentifierMeter];
}

@end
