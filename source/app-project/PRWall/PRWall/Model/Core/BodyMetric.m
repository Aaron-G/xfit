//
//  BodyMetric.m
//  PR Wall
//
//  Created by Cleo Barretto on 1/31/13.
//
//

#import "BodyMetric.h"
#import "ModelHelper.h"

BodyMetricIdentifier BodyMetricIdentifierHeight = @"BodyMetricIdentifierHeight";
BodyMetricIdentifier BodyMetricIdentifierWeight = @"BodyMetricIdentifierWeight";
BodyMetricIdentifier BodyMetricIdentifierChest = @"BodyMetricIdentifierChest";
BodyMetricIdentifier BodyMetricIdentifierBicepsLeft = @"BodyMetricIdentifierBicepsLeft";
BodyMetricIdentifier BodyMetricIdentifierBicepsRight = @"BodyMetricIdentifierBicepsRight";
BodyMetricIdentifier BodyMetricIdentifierWaist = @"BodyMetricIdentifierWaist";
BodyMetricIdentifier BodyMetricIdentifierHip = @"BodyMetricIdentifierHip";
BodyMetricIdentifier BodyMetricIdentifierThighLeft = @"BodyMetricIdentifierThighLeft";
BodyMetricIdentifier BodyMetricIdentifierThighRight = @"BodyMetricIdentifierThighRight";
BodyMetricIdentifier BodyMetricIdentifierCalfLeft = @"BodyMetricIdentifierCalfLeft";
BodyMetricIdentifier BodyMetricIdentifierCalfRight = @"BodyMetricIdentifierCalfRight";
BodyMetricIdentifier BodyMetricIdentifierBodyMassIndex = @"BodyMetricIdentifierBodyMassIndex";
BodyMetricIdentifier BodyMetricIdentifierBodyFat = @"BodyMetricIdentifierBodyFat";
BodyMetricIdentifier BodyMetricIdentifierInvalid = @"BodyMetricIdentifierInvalid";

@implementation BodyMetric

+ (BodyMetricIdentifier) bodyMetricIdentifierForMeasurable: (Measurable*) measurable {
  return [ModelHelper bodyMetricIdentifierForBodyMetric:measurable];
}

@end
