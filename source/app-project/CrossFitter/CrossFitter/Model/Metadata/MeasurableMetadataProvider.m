//
//  MeasurableMetadataProvider.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import "MeasurableMetadataProvider.h"

@implementation MeasurableMetadataProvider

- (id)initWithMeasurableIdentifier:(NSString*) measurableIdentifier {
  self = [super init];
  
  if (self) {
    self.measurableIdentifier = measurableIdentifier;
    
  }
  return self;
}

@end
