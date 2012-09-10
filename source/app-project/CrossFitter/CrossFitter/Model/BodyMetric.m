//
//  BodyMetric.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import "BodyMetric.h"

@implementation BodyMetric

@synthesize identifier = _identifier;
@synthesize name = _name;

@synthesize valueTrend;
@synthesize valueTrendBetterDirection;
@synthesize unit;
@synthesize value;

- (void)setIdentifier:(BodyMetricIdentifier)identifier {
  _identifier = identifier;
  
  //Update name
  _name = [BodyMetric nameForBodyMetricIdentifier:identifier];
}

- (BodyMetricIdentifier)identifier {
  return _identifier;
}

+ (NSString *) nameForBodyMetricIdentifier: (BodyMetricIdentifier) bodyMetricIdentifier {
  
  NSString* name = nil;
  
  if(bodyMetricIdentifier == kBodyMetricIdentifierHeight) {
    name = NSLocalizedString(@"height-metric-label", @"Height");
  } else if(bodyMetricIdentifier == kBodyMetricIdentifierWeight) {
    name = NSLocalizedString(@"weight-metric-label", @"Weight");
  } else if(bodyMetricIdentifier == kBodyMetricIdentifierChest) {
    name = NSLocalizedString(@"chest-metric-label", @"Chest");
  } else if(bodyMetricIdentifier == kBodyMetricIdentifierWaist) {
    name = NSLocalizedString(@"waist-metric-label", @"Waist");
  } else if(bodyMetricIdentifier == kBodyMetricIdentifierHip) {
    name = NSLocalizedString(@"hip-metric-label", @"Hip");
  } else if(bodyMetricIdentifier == kBodyMetricIdentifierBiceptsLeft) {
    name = NSLocalizedString(@"biceps-left-metric-label", @"Biceps - Left");
  } else if(bodyMetricIdentifier == kBodyMetricIdentifierBiceptsRight) {
    name = NSLocalizedString(@"biceps-right-metric-label", @"Biceps - Right");
  } else if(bodyMetricIdentifier == kBodyMetricIdentifierThighLeft) {
    name = NSLocalizedString(@"thigh-left-metric-label", @"Thigh - Left");
  } else if(bodyMetricIdentifier == kBodyMetricIdentifierThighRight) {
    name = NSLocalizedString(@"thigh-right-metric-label", @"Thigh - Right");
  } else if(bodyMetricIdentifier == kBodyMetricIdentifierCalfLeft) {
    name = NSLocalizedString(@"calf-left-metric-label", @"Calf - Left");
  } else if(bodyMetricIdentifier == kBodyMetricIdentifierCalfRight) {
    name = NSLocalizedString(@"calf-right-metric-label", @"Calf - Right");
  } else if(bodyMetricIdentifier == kBodyMetricIdentifierBodyMassIndex) {
    name = NSLocalizedString(@"body-mass-index-metric-label", @"Body Mass Index");
  } else if(bodyMetricIdentifier == kBodyMetricIdentifierBodyFat) {
    name = NSLocalizedString(@"body-fat-metric-label", @"Body Fat");
  }
  
  return name;
}

+ (BodyMetric *) bodyMetricForBodyMetricIdentifier: (BodyMetricIdentifier) bodyMetricIdentifier {
 
  BodyMetric * metric = [[BodyMetric alloc]init];
  metric.identifier = bodyMetricIdentifier;
  metric.valueTrend = kMeasurableValueTrendNone;
  
  /////////////////////////////
  //MeasurableValueTrendDirection
  
  //Arbitrary default value
  MeasurableValueTrendDirection trendBetterDirection = kMeasurableValueTrendDirectionUp;

  if(bodyMetricIdentifier == kBodyMetricIdentifierHeight ||
     bodyMetricIdentifier == kBodyMetricIdentifierChest ||
     bodyMetricIdentifier == kBodyMetricIdentifierBiceptsRight ||
     bodyMetricIdentifier == kBodyMetricIdentifierBiceptsLeft ||
     bodyMetricIdentifier == kBodyMetricIdentifierThighRight ||
     bodyMetricIdentifier == kBodyMetricIdentifierThighLeft ||
     bodyMetricIdentifier == kBodyMetricIdentifierCalfRight ||
     bodyMetricIdentifier == kBodyMetricIdentifierCalfLeft) {
    
    trendBetterDirection = kMeasurableValueTrendDirectionUp;
    
  } else if(bodyMetricIdentifier == kBodyMetricIdentifierWeight ||
            bodyMetricIdentifier == kBodyMetricIdentifierWaist ||
            bodyMetricIdentifier == kBodyMetricIdentifierHip ||
            bodyMetricIdentifier == kBodyMetricIdentifierBodyMassIndex ||
            bodyMetricIdentifier == kBodyMetricIdentifierBodyFat){
    
    trendBetterDirection = kMeasurableValueTrendDirectionDown;

  }

  metric.valueTrendBetterDirection = trendBetterDirection;
  
  return metric;
}


@end
