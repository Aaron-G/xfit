//
//  BodyMetric.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import "BodyMetric.h"
#import "BodyMetricHelper.h"
#import "BodyMetricMetadataProvider.h"

@implementation BodyMetric

NSString* BodyMetricIdentifierHeight = @"BodyMetricIdentifierHeight";
NSString* BodyMetricIdentifierWeight = @"BodyMetricIdentifierWeight";
NSString* BodyMetricIdentifierChest = @"BodyMetricIdentifierChest";
NSString* BodyMetricIdentifierBiceptsLeft = @"BodyMetricIdentifierBiceptsLeft";
NSString* BodyMetricIdentifierBiceptsRight = @"BodyMetricIdentifierBiceptsRight";
NSString* BodyMetricIdentifierWaist = @"BodyMetricIdentifierWaist";
NSString* BodyMetricIdentifierHip = @"BodyMetricIdentifierHip";
NSString* BodyMetricIdentifierThighLeft = @"BodyMetricIdentifierThighLeft";
NSString* BodyMetricIdentifierThighRight = @"BodyMetricIdentifierThighRight";
NSString* BodyMetricIdentifierCalfLeft = @"BodyMetricIdentifierCalfLeft";
NSString* BodyMetricIdentifierCalfRight = @"BodyMetricIdentifierCalfRight";
NSString* BodyMetricIdentifierBodyMassIndex = @"BodyMetricIdentifierBodyMassIndex";
NSString* BodyMetricIdentifierBodyFat = @"BodyMetricIdentifierBodyFat";
NSString* BodyMetricIdentifierInvalid = @"BodyMetricIdentifierInvalid";

- (id)initWithIdentifier:(NSString *)identifier {
  self = [super initWithIdentifier:identifier];
  
  if(self) {
    self.valueFormatter = [BodyMetricHelper formatterForBodyMetric:self];
  }
  return self;
  
}
- (MeasurableDataProvider*) createDataProviderWithIdentifier:(NSString*) identifier {
  return [[MeasurableDataProvider alloc] initWithMeasurableIdentifier: identifier];
}

- (MeasurableMetadataProvider*) createMetadataProviderWithIdentifier:(NSString*) identifier {
  return [[BodyMetricMetadataProvider alloc] initWithMeasurableIdentifier:identifier];
}

@end
