//
//  PoundFormatter.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/21/12.
//
//

#import "PoundFormatter.h"

@implementation PoundFormatter

-(id)init {
  self = [super init];
  
  if(self) {
    self.suffixString = NSLocalizedString(@"pound-suffix", @"lb");
    self.unit = [Unit unitForUnitIdentifier:UnitIdentifierPound];
  }
  
  return self;
}
@end
