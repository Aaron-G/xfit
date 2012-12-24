//
//  InchFormatter.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/21/12.
//
//

#import "InchFormatter.h"

@implementation InchFormatter

-(id)init {
  self = [super init];
  
  if(self) {
    self.suffixString = NSLocalizedString(@"inch-suffix", @"\"");
    self.unit = [Unit unitForUnitIdentifier:UnitIdentifierInch];
  }
  
  return self;
}
@end
