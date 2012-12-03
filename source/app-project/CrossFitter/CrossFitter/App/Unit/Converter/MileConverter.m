//
//  MileConverter.m
//  CrossFitter
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "MileConverter.h"

@implementation MileConverter
- (id)init
{
  self = [super init];
  if (self) {
    self.convertionFactor = 160934.4;
  }
  return self;
}
@end
