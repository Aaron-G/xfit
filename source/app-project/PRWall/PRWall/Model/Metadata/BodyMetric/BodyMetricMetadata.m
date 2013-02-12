//
//  BodyMetricMetadata.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import "BodyMetricMetadata.h"
#import "MeasurableHelper.h"
#import "Tag.h"
#import "ModelHelper.h"

@implementation BodyMetricMetadata

@synthesize metadataShort = _metadataShort;

- (NSString *) metadataShort {

  //We can cache it like this because the tags for Body Metrics don't change
  if(!_metadataShort) {
    _metadataShort = [MeasurableHelper tagsStringForMeasurableMetadata:self];
  }
  
  return _metadataShort;
}

- (NSString *) metadataFull {
  return self.metadataShort;
}

- (MeasurableMetadata*) newInstance {
  return [ModelHelper newBodyMetricMetadata];
}

@end