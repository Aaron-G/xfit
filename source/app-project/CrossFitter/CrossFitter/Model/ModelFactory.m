//
//  ModelFactory.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import "ModelFactory.h"
#import "BodyMetric.h"
@implementation ModelFactory

+ (UserProfile*) createUserProfile {
  
  UserProfile* profile = [[UserProfile alloc] init];
  profile.name = @"John Doe";
  profile.sex = @"Male";
  profile.box = @"CrossFit USA";
  
  NSDateComponents *comps = [[NSDateComponents alloc] init];
  [comps setDay:10];
  [comps setMonth:10];
  [comps setYear:1990];
  profile.dateOfBirth = [[NSCalendar currentCalendar] dateFromComponents:comps];

  NSMutableDictionary* metrics =  [NSMutableDictionary dictionary];
  profile.metrics = metrics;

  //Height
  BodyMetric * metric = [BodyMetric bodyMetricForBodyMetricIdentifier: kBodyMetricIdentifierHeight];
  //metric.value = @"5'11\'";
  metric.value = 71;
  metric.valueTrend = kMeasurableValueTrendNone;
  [metrics setValue:metric forKey:metric.name];
  
  //Weight
  metric = [BodyMetric bodyMetricForBodyMetricIdentifier: kBodyMetricIdentifierWeight];
  metric.value = 150;
  //metric.value = @"150 lbs";
  metric.valueTrend = kMeasurableValueTrendBetter;
  [metrics setValue:metric forKey:metric.name];

  //Chest
  metric = [BodyMetric bodyMetricForBodyMetricIdentifier: kBodyMetricIdentifierChest];
  metric.value = 38;
  //metric.value = @"38\"";
  metric.valueTrend = kMeasurableValueTrendWorse;
  [metrics setValue:metric forKey:metric.name];

  //Biceps Right
  metric = [BodyMetric bodyMetricForBodyMetricIdentifier: kBodyMetricIdentifierBiceptsRight];
  metric.value = 12.8;
  //metric.value = @"12.8\"";
  metric.valueTrend = kMeasurableValueTrendSame;
  [metrics setValue:metric forKey:metric.name];

  //Biceps Left
  metric = [BodyMetric bodyMetricForBodyMetricIdentifier: kBodyMetricIdentifierBiceptsLeft];
  metric.value = 12;
  //metric.value = @"12\"";
  metric.valueTrend = kMeasurableValueTrendSame;
  [metrics setValue:metric forKey:metric.name];

  //Waist
  metric = [BodyMetric bodyMetricForBodyMetricIdentifier: kBodyMetricIdentifierWaist];
  //metric.value = @"35\"";
  metric.value = 35;
  metric.valueTrend = kMeasurableValueTrendWorse;
  [metrics setValue:metric forKey:metric.name];
  
  //Hip
  metric = [BodyMetric bodyMetricForBodyMetricIdentifier: kBodyMetricIdentifierHip];
  metric.value = 39;
  //metric.value = @"39\"";
  metric.valueTrend = kMeasurableValueTrendWorse;
  [metrics setValue:metric forKey:metric.name];

  //Thigh Right
  metric = [BodyMetric bodyMetricForBodyMetricIdentifier: kBodyMetricIdentifierThighRight];
  metric.value = 24.5;
  //metric.value = @"24.5\"";
  metric.valueTrend = kMeasurableValueTrendBetter;
  [metrics setValue:metric forKey:metric.name];
  
  //Thigh Left
  metric = [BodyMetric bodyMetricForBodyMetricIdentifier: kBodyMetricIdentifierThighLeft];
  //metric.value = @"24\"";
  metric.value = 24;
  metric.valueTrend = kMeasurableValueTrendSame;
  [metrics setValue:metric forKey:metric.name];

  //Calf Right
  metric = [BodyMetric bodyMetricForBodyMetricIdentifier: kBodyMetricIdentifierCalfRight];
  metric.value = 11.7;
  //metric.value = @"11.7\"";
  metric.valueTrend = kMeasurableValueTrendWorse;
  [metrics setValue:metric forKey:metric.name];
  
  //Calf Left
  metric = [BodyMetric bodyMetricForBodyMetricIdentifier: kBodyMetricIdentifierCalfLeft];
  //metric.value = @"11.3\"";
  metric.value = 11.3;
  metric.valueTrend = kMeasurableValueTrendBetter;
  [metrics setValue:metric forKey:metric.name];

  //Body Mass Index
  metric = [BodyMetric bodyMetricForBodyMetricIdentifier: kBodyMetricIdentifierBodyMassIndex];
  //metric.value = @"22.5";
  metric.value = 22.5;
  metric.valueTrend = kMeasurableValueTrendBetter;
  [metrics setValue:metric forKey:metric.name];

  //Body Fat
  metric = [BodyMetric bodyMetricForBodyMetricIdentifier: kBodyMetricIdentifierBodyFat];
  //metric.value = @"21.3%";
  metric.value = 21.3;
  metric.valueTrend = kMeasurableValueTrendBetter;
  [metrics setValue:metric forKey:metric.name];

  return profile;
}

@end
