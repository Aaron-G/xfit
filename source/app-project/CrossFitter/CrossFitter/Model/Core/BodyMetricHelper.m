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

  if(bodyMetric.metadataProvider.identifier == BodyMetricIdentifierHeight) {
    if(bodyMetric.metadataProvider.unit.identifier == UnitIdentifierInch) {
      return [[FootInchFormatter alloc] init];
    }
  } else if(bodyMetric.metadataProvider.identifier == BodyMetricIdentifierWeight) {
    if(bodyMetric.metadataProvider.unit.identifier == UnitIdentifierPound) {
      return [[PoundFormatter alloc] init];
    }
  } else if(bodyMetric.metadataProvider.identifier == BodyMetricIdentifierBodyFat) {
    if(bodyMetric.metadataProvider.unit.identifier == UnitIdentifierPercent) {
      return [[PercentFormatter alloc] init];
    }
  } else if(bodyMetric.metadataProvider.identifier == BodyMetricIdentifierBodyMassIndex) {
    if(bodyMetric.metadataProvider.unit.identifier == UnitIdentifierNone) {
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
