//
//  FootConverter.m
//  CrossFitter
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "FootConverter.h"

@implementation FootConverter
- (id)init
{
  self = [super init];
  if (self) {
    self.convertionFactor = 30.48;
  }
  return self;
}
@end
