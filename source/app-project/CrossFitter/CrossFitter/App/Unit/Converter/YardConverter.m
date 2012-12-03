//
//  YardConverter.m
//  CrossFitter
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "YardConverter.h"

@implementation YardConverter
- (id)init
{
  self = [super init];
  if (self) {
    self.convertionFactor = 91.44;
  }
  return self;
}
@end
