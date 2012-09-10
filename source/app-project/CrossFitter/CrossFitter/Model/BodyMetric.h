//
//  BodyMetric.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"

typedef enum {
  kBodyMetricIdentifierHeight,
  kBodyMetricIdentifierWeight,
  kBodyMetricIdentifierChest,
  kBodyMetricIdentifierBiceptsLeft,
  kBodyMetricIdentifierBiceptsRight,
  kBodyMetricIdentifierWaist,
  kBodyMetricIdentifierHip,
  kBodyMetricIdentifierThighLeft,
  kBodyMetricIdentifierThighRight,
  kBodyMetricIdentifierCalfLeft,
  kBodyMetricIdentifierCalfRight,
  kBodyMetricIdentifierBodyMassIndex,
  kBodyMetricIdentifierBodyFat,
  kBodyMetricIdentifierInvalid
} BodyMetricIdentifier;

@interface BodyMetric : NSObject <Measurable>

@property BodyMetricIdentifier identifier;

@property NSString* name;

+ (NSString *) nameForBodyMetricIdentifier: (BodyMetricIdentifier) bodyMetricIdentifier;

//Creates a Metric instance that is configured with the proper:
//- identifier
//- name
//- valueTrendBetterDirection
//- valueTrend  //default none
+ (BodyMetric *) bodyMetricForBodyMetricIdentifier: (BodyMetricIdentifier) bodyMetricIdentifier;

@end
