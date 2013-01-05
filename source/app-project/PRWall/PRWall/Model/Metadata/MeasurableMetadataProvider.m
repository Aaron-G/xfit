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

- (void)copyToMeasurableMetadataProvider:(MeasurableMetadataProvider *)metadataProvider {

  metadataProvider.name = [NSString stringWithFormat: NSLocalizedString(@"measurable-name-copy-format", @"%@ Copy"), self.name];
  metadataProvider.type = self.type;
  metadataProvider.unit = self.unit;
  metadataProvider.valueGoal = self.valueGoal;
  metadataProvider.valueType = self.valueType;
  metadataProvider.description = [self.description copy];
  metadataProvider.images = [self.images copy];
  metadataProvider.videos = [self.videos copy];
  
  metadataProvider.moreInfo = [self.moreInfo copy];
}

@end
