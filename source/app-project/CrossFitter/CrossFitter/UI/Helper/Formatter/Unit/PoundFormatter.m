//
//  PoundFormatter.m
//  CrossFitter
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
  }
  
  return self;
}

@end
