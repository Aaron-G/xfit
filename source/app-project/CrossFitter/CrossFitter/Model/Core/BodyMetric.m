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

NSString* kBodyMetricIdentifierHeight = @"kBodyMetricIdentifierHeight";

NSString* kBodyMetricIdentifierWeight = @"kBodyMetricIdentifierWeight";
NSString* kBodyMetricIdentifierChest = @"kBodyMetricIdentifierChest";
NSString* kBodyMetricIdentifierBiceptsLeft = @"kBodyMetricIdentifierBiceptsLeft";
NSString* kBodyMetricIdentifierBiceptsRight = @"kBodyMetricIdentifierBiceptsRight";
NSString* kBodyMetricIdentifierWaist = @"kBodyMetricIdentifierWaist";
NSString* kBodyMetricIdentifierHip = @"kBodyMetricIdentifierHip";
NSString* kBodyMetricIdentifierThighLeft = @"kBodyMetricIdentifierThighLeft";
NSString* kBodyMetricIdentifierThighRight = @"kBodyMetricIdentifierThighRight";
NSString* kBodyMetricIdentifierCalfLeft = @"kBodyMetricIdentifierCalfLeft";
NSString* kBodyMetricIdentifierCalfRight = @"kBodyMetricIdentifierCalfRight";
NSString* kBodyMetricIdentifierBodyMassIndex = @"kBodyMetricIdentifierBodyMassIndex";
NSString* kBodyMetricIdentifierBodyFat = @"kBodyMetricIdentifierBodyFat";
NSString* kBodyMetricIdentifierInvalid = @"kBodyMetricIdentifierInvalid";

- (id)initWithIdentifier:(NSString *)identifier {
  self = [super initWithIdentifier:identifier];
  
  if(self) {
    self.valueFormatter = [BodyMetricHelper formatterForBodyMetric:self];
  }
  return self;
  
}
- (MeasurableDataProvider*) createDataProviderWithIdentifier:(NSString*) identifier {
  return [[MeasurableDataProvider alloc] initWithIdentifier: identifier];
}

- (MeasurableMetadataProvider*) createMetadataProviderWithIdentifier:(NSString*) identifier {
  return [[BodyMetricMetadataProvider alloc] initWithIdentifier:identifier];
}

@end
