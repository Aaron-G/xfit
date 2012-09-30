//
//  PercentFormatter.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/21/12.
//
//

#import "PercentFormatter.h"

@implementation PercentFormatter

-(id)init {
  self = [super init];
  
  if(self) {
    self.numberStyle = NSNumberFormatterPercentStyle;
    
    //Default to 2 decimal points for percentage
    [self.numberFormatter setMinimumFractionDigits:2];

  }
  
  return self;
}

@end
