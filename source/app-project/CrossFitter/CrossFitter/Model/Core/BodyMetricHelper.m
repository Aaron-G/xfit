//
//  BodyMetricHelper.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/23/12.
//
//

#import "BodyMetricHelper.h"
#import "BodyMetric.h"
#import "FootInchFormatter.h"
#import "DefaultUnitValueFormatter.h"
#import "PoundFormatter.h"
#import "PercentFormatter.h"
#import "InchFormatter.h"

@implementation BodyMetricHelper

+ (id<UnitValueFormatter>) formatterForBodyMetric: (BodyMetric*) bodyMetric {

  if(bodyMetric.metadataProvider.measurableIdentifier == kBodyMetricIdentifierHeight) {
    if(bodyMetric.metadataProvider.unit.identifier == kUnitIdentifierInch) {
      return [[FootInchFormatter alloc] init];
    }
  } else if(bodyMetric.metadataProvider.measurableIdentifier == kBodyMetricIdentifierWeight) {
    if(bodyMetric.metadataProvider.unit.identifier == kUnitIdentifierPound) {
      return [[PoundFormatter alloc] init];
    }
  } else if(bodyMetric.metadataProvider.measurableIdentifier == kBodyMetricIdentifierBodyFat) {
    if(bodyMetric.metadataProvider.unit.identifier == kUnitIdentifierPercent) {
      return [[PercentFormatter alloc] init];
    }
  } else if(bodyMetric.metadataProvider.measurableIdentifier == kBodyMetricIdentifierBodyMassIndex) {
    if(bodyMetric.metadataProvider.unit.identifier == kUnitIdentifierNone) {
      return [[DefaultUnitValueFormatter alloc] init];
    }
  }
  
  //CXB TODO
  //Add the other precise else if statments
  else {
      return [[InchFormatter alloc] init];
  }

  return [[DefaultUnitValueFormatter alloc] init];
}

@end
