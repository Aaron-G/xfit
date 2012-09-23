//
//  PercentFormatter.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/21/12.
//
//

#import "PercentFormatter.h"

@implementation PercentFormatter

//CXB TODO
//The percentage is getting round, it needs to show the decimal part for precision
-(id)init {
  self = [super init];
  
  if(self) {
    self.numberStyle = NSNumberFormatterPercentStyle;
  }
  
  return self;
}

@end
