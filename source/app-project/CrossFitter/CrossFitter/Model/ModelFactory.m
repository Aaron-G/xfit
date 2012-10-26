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
  profile.name = @"John Smith";
  profile.sex = UserProfileSexMale;
  profile.box = @"CrossFit Box";
  
  NSDateComponents *comps = [[NSDateComponents alloc] init];
  [comps setDay:1];
  [comps setMonth:1];
  [comps setYear:1990];
  profile.dateOfBirth = [[NSCalendar currentCalendar] dateFromComponents:comps];

  return profile;
}

+ (NSDictionary*) createDefaultBodyMetrics {
  
  NSMutableDictionary* metrics =  [NSMutableDictionary dictionary];
  
  //Height
  BodyMetric * metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierHeight];
  NSArray* values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:70], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Weight
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierWeight];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:175], [NSNumber numberWithFloat:170],  [NSNumber numberWithFloat:173], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Chest
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierChest];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:36.5], [NSNumber numberWithFloat:37], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Body Mass Index
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierBodyMassIndex];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:22.5], [NSNumber numberWithFloat:23.5], [NSNumber numberWithFloat:23.5], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Body Fat
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierBodyFat];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:0.2335], [NSNumber numberWithFloat:0.254], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Biceps Right
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierBiceptsRight];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:12.8], [NSNumber numberWithFloat:12.8], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Biceps Left
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierBiceptsLeft];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:12.5], [NSNumber numberWithFloat:12.5], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Waist
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierWaist];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:35.6], [NSNumber numberWithFloat:35.7], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Hip
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierHip];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:39.9], [NSNumber numberWithFloat:37.7], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Thigh Right
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierThighRight];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:24.5], [NSNumber numberWithFloat:23], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Thigh Left
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierThighLeft];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:24.1], [NSNumber numberWithFloat:24.1], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Calf Right
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierCalfRight];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:11.7], [NSNumber numberWithFloat:12.1], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.measurableIdentifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.measurableIdentifier];
  
  //Calf Left
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierCalfLeft];
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
    dataEntry.date = [NSDate date];
    [dataEntries addObject:dataEntry];
  }

  return dataEntries;
}

@end
