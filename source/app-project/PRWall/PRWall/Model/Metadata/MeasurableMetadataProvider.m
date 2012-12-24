//
//  MeasurableMetadataProvider.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import "MeasurableMetadataProvider.h"

@implementation MeasurableMetadataProvider

- (id)initWithMeasurableIdentifier:(MeasurableIdentifier) identifier {
  self = [super init];
  
  if (self) {
    self.identifier = identifier;
    
  }
  return self;
}

@end
