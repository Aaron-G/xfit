//
//  KilometerConverter.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "KilometerConverter.h"

@implementation KilometerConverter
- (id)init
{
  self = [super init];
  if (self) {
    self.convertionFactor = 100000;
  }
  return self;
}
@end
