//
//  InchConverter.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "InchConverter.h"

@implementation InchConverter
- (id)init
{
  self = [super init];
  if (self) {
    self.convertionFactor = 2.54;
  }
  return self;
}
@end
