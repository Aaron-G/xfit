//
//  PoundConverter.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "PoundConverter.h"

@implementation PoundConverter
- (id)init
{
  self = [super init];
  if (self) {
    self.convertionFactor = 453.59237;
  }
  return self;
}
@end
