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

+ (UserProfile*) createDefaultUserProfile {
  
  UserProfile* profile = [[UserProfile alloc] init];
  profile.name = @"John Doe";
  profile.sex = @"Male";
  profile.box = @"CrossFit USA";
  
  NSDateComponents *comps = [[NSDateComponents alloc] init];
  [comps setDay:10];
  [comps setMonth:10];
  [comps setYear:1990];
  profile.dateOfBirth = [[NSCalendar currentCalendar] dateFromComponents:comps];

  return profile;
}

+ (NSDictionary*) createDefaultBodyMetrics {
  
  NSMutableDictionary* metrics =  [NSMutableDictionary dictionary];
  
  //Height
  BodyMetric * metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierHeight];
  metric.dataProvider.value = [NSNumber numberWithFloat:70];
  metric.dataProvider.valueTrend = kMeasurableValueTrendNone;
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Weight
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierWeight];
  metric.dataProvider.value = [NSNumber numberWithFloat:175];
  metric.dataProvider.valueTrend = kMeasurableValueTrendBetter;
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Chest
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierChest];
  metric.dataProvider.value = [NSNumber numberWithFloat:38.5];
  metric.dataProvider.valueTrend = kMeasurableValueTrendWorse;
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Biceps Right
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierBiceptsRight];
  metric.dataProvider.value = [NSNumber numberWithFloat:12.8];
  metric.dataProvider.valueTrend = kMeasurableValueTrendSame;
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Biceps Left
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierBiceptsLeft];
  metric.dataProvider.value = [NSNumber numberWithFloat:12.5];
  metric.dataProvider.valueTrend = kMeasurableValueTrendSame;
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Waist
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierWaist];
  metric.dataProvider.value = [NSNumber numberWithFloat:35.6];
  metric.dataProvider.valueTrend = kMeasurableValueTrendWorse;
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Hip
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierHip];
  metric.dataProvider.value = [NSNumber numberWithFloat:39.9];
  metric.dataProvider.valueTrend = kMeasurableValueTrendWorse;
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Thigh Right
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierThighRight];
  metric.dataProvider.value = [NSNumber numberWithFloat:24.5];
  metric.dataProvider.valueTrend = kMeasurableValueTrendBetter;
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Thigh Left
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierThighLeft];
  metric.dataProvider.value = [NSNumber numberWithFloat:24.1];
  metric.dataProvider.valueTrend = kMeasurableValueTrendSame;
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Calf Right
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierCalfRight];
  metric.dataProvider.value = [NSNumber numberWithFloat:11.7];
  metric.dataProvider.valueTrend = kMeasurableValueTrendWorse;
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Calf Left
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierCalfLeft];
  metric.dataProvider.value = [NSNumber numberWithFloat:11.3];
  metric.dataProvider.valueTrend = kMeasurableValueTrendBetter;
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Body Mass Index
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierBodyMassIndex];
  metric.dataProvider.value = [NSNumber numberWithFloat:22.5];
  metric.dataProvider.valueTrend = kMeasurableValueTrendBetter;
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Body Fat
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierBodyFat];
  metric.dataProvider.value = [NSNumber numberWithFloat:0.213];
  metric.dataProvider.valueTrend = kMeasurableValueTrendBetter;
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  return metrics;
}
@end
