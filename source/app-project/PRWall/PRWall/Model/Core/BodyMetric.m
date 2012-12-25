//
//  BodyMetric.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import "BodyMetric.h"
#import "BodyMetricHelper.h"
#import "BodyMetricMetadataProvider.h"

@implementation BodyMetric

MeasurableIdentifier BodyMetricIdentifierHeight = @"BodyMetricIdentifierHeight";
MeasurableIdentifier BodyMetricIdentifierWeight = @"BodyMetricIdentifierWeight";
MeasurableIdentifier BodyMetricIdentifierChest = @"BodyMetricIdentifierChest";
MeasurableIdentifier BodyMetricIdentifierBiceptsLeft = @"BodyMetricIdentifierBiceptsLeft";
MeasurableIdentifier BodyMetricIdentifierBiceptsRight = @"BodyMetricIdentifierBiceptsRight";
MeasurableIdentifier BodyMetricIdentifierWaist = @"BodyMetricIdentifierWaist";
MeasurableIdentifier BodyMetricIdentifierHip = @"BodyMetricIdentifierHip";
MeasurableIdentifier BodyMetricIdentifierThighLeft = @"BodyMetricIdentifierThighLeft";
MeasurableIdentifier BodyMetricIdentifierThighRight = @"BodyMetricIdentifierThighRight";
MeasurableIdentifier BodyMetricIdentifierCalfLeft = @"BodyMetricIdentifierCalfLeft";
MeasurableIdentifier BodyMetricIdentifierCalfRight = @"BodyMetricIdentifierCalfRight";
MeasurableIdentifier BodyMetricIdentifierBodyMassIndex = @"BodyMetricIdentifierBodyMassIndex";
MeasurableIdentifier BodyMetricIdentifierBodyFat = @"BodyMetricIdentifierBodyFat";
MeasurableIdentifier BodyMetricIdentifierInvalid = @"BodyMetricIdentifierInvalid";

- (MeasurableMetadataProvider*) createMetadataProviderWithIdentifier:(MeasurableIdentifier) identifier {
  return [[BodyMetricMetadataProvider alloc] initWithMeasurableIdentifier:identifier];
}

@end
