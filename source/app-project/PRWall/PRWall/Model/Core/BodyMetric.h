//
//  BodyMetric.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/31/13.
//
//

#import "Measurable.h"

@class Measurable;

typedef NSString* BodyMetricIdentifier;

extern BodyMetricIdentifier BodyMetricIdentifierHeight;
extern BodyMetricIdentifier BodyMetricIdentifierWeight;
extern BodyMetricIdentifier BodyMetricIdentifierChest;
extern BodyMetricIdentifier BodyMetricIdentifierBicepsLeft;
extern BodyMetricIdentifier BodyMetricIdentifierBicepsRight;
extern BodyMetricIdentifier BodyMetricIdentifierWaist;
extern BodyMetricIdentifier BodyMetricIdentifierHip;
extern BodyMetricIdentifier BodyMetricIdentifierThighLeft;
extern BodyMetricIdentifier BodyMetricIdentifierThighRight;
extern BodyMetricIdentifier BodyMetricIdentifierCalfLeft;
extern BodyMetricIdentifier BodyMetricIdentifierCalfRight;
extern BodyMetricIdentifier BodyMetricIdentifierBodyMassIndex;
extern BodyMetricIdentifier BodyMetricIdentifierBodyFat;
extern BodyMetricIdentifier BodyMetricIdentifierInvalid;

@interface BodyMetric : Measurable

+ (BodyMetricIdentifier) bodyMetricIdentifierForMeasurable: (Measurable*) measurable;

@end
