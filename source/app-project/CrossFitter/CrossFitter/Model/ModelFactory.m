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
  NSArray* values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:70], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Weight
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierWeight];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:175], [NSNumber numberWithFloat:170], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Chest
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierChest];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:36.5], [NSNumber numberWithFloat:37], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Body Mass Index
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierBodyMassIndex];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:22.5], [NSNumber numberWithFloat:23.5], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Body Fat
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierBodyFat];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:0.2335], [NSNumber numberWithFloat:0.254], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Biceps Right
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierBiceptsRight];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:12.8], [NSNumber numberWithFloat:12.8], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Biceps Left
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierBiceptsLeft];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:12.5], [NSNumber numberWithFloat:12.5], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Waist
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierWaist];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:35.6], [NSNumber numberWithFloat:35.7], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Hip
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierHip];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:39.9], [NSNumber numberWithFloat:37.7], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Thigh Right
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierThighRight];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:24.5], [NSNumber numberWithFloat:23], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Thigh Left
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierThighLeft];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:24.1], [NSNumber numberWithFloat:24.1], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Calf Right
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierCalfRight];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:11.7], [NSNumber numberWithFloat:12.1], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Calf Left
  metric = [[BodyMetric alloc]initWithIdentifier: kBodyMetricIdentifierCalfLeft];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:11.3], [NSNumber numberWithFloat:11.1], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  return metrics;
}


+ (NSArray*) sampleMeasurableDataEntryForMeasurableId: (NSString*) measurableId withValues: (NSArray*) values {

  NSMutableArray* dataEntries = [NSMutableArray arrayWithCapacity:values.count];
  
  for (NSNumber* value in values) {
    MeasurableDataEntry* dataEntry = [[MeasurableDataEntry alloc] init];
    dataEntry.value = value;
    [dataEntries addObject:dataEntry];
  }

  return dataEntries;
}

@end
