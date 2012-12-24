//
//  MeterConverter.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "MeterConverter.h"

@implementation MeterConverter
- (id)init
{
  self = [super init];
  if (self) {
    self.convertionFactor = 100;
  }
  return self;
}
@end
