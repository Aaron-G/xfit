//
//  KilometerFormatter.m
//  CrossFitter
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "KilometerFormatter.h"

@implementation KilometerFormatter

-(id)init {
  self = [super init];
  
  if(self) {
    self.suffixString = NSLocalizedString(@"kilometer-suffix", @"km");
    self.unit = [Unit unitForUnitIdentifier:UnitIdentifierKilometer];
  }
  
  return self;
}
@end
