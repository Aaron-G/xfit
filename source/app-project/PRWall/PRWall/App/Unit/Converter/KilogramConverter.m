//
//  KilogramConverter.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "KilogramConverter.h"

@implementation KilogramConverter
- (id)init
{
  self = [super init];
  if (self) {
    self.convertionFactor = 1000;
  }
  return self;
}
@end
