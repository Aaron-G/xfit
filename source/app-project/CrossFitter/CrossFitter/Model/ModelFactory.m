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
  
  //NSData * content = [[NSFileManager defaultManager] contentsAtPath: [NSString stringWithFormat:@"%@%@%@", NSHomeDirectory(), @"/Documents/Images/User/", @"user-profile1.png"]];
  //profile.image = [UIImage imageWithData:content];
  profile.image = [UIImage imageNamed:@"default-user-profile-image"];
  
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
  NSArray* values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:72], [NSNumber numberWithFloat:70], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Weight
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierWeight];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:175], [NSNumber numberWithFloat:170], [NSNumber numberWithFloat:173], [NSNumber numberWithFloat:177], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Body Mass Index
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierBodyMassIndex];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:22.3], [NSNumber numberWithFloat:22.5], [NSNumber numberWithFloat:23.5], [NSNumber numberWithFloat:23.5], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Body Fat
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierBodyFat];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:0.2301], [NSNumber numberWithFloat:0.2401], [NSNumber numberWithFloat:0.2335], [NSNumber numberWithFloat:0.254], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Chest
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierChest];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:37.2], [NSNumber numberWithFloat:36.5], [NSNumber numberWithFloat:37], [NSNumber numberWithFloat:38], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];

  //Biceps Right
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierBiceptsRight];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:12.8], [NSNumber numberWithFloat:12.8], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Biceps Left
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierBiceptsLeft];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:12.5], [NSNumber numberWithFloat:12.5], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Waist
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierWaist];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:35.6], [NSNumber numberWithFloat:35.7], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Hip
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierHip];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:39.9], [NSNumber numberWithFloat:37.7], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Thigh Right
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierThighRight];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:24.5], [NSNumber numberWithFloat:23], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Thigh Left
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierThighLeft];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:24.1], [NSNumber numberWithFloat:24.1], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Calf Right
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierCalfRight];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:11.7], [NSNumber numberWithFloat:12.1], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  //Calf Left
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierCalfLeft];
  values = [NSArray arrayWithObjects: [NSNumber numberWithFloat:11.3], [NSNumber numberWithFloat:11.1], nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  
  return metrics;
}


+ (NSArray*) sampleMeasurableDataEntryForMeasurableId: (NSString*) measurableId withValues: (NSArray*) values {

  NSMutableArray* dataEntries = [NSMutableArray arrayWithCapacity:values.count];
  
  NSInteger count = 0;
  
  for (NSNumber* value in values) {
    
    MeasurableDataEntry* dataEntry = [[MeasurableDataEntry alloc] init];
    dataEntry.value = value;
    dataEntry.date = [NSDate dateWithTimeInterval:((-count)*24*60*60) sinceDate:[NSDate date]];
    
    if(count == 0) {
    } else if(count == 1) {
      dataEntry.comment = @"This was a sweet workout! But I would like a shorter break in between sets";
    } else if(count == 2) {
      NSMutableArray* images = [NSMutableArray arrayWithCapacity:4];
      [images addObject: [UIImage imageNamed:@"prwall-screen-button"]];
      [images addObject: [UIImage imageNamed:@"wod-screen-button"]];
      [images addObject: [UIImage imageNamed:@"workout-screen-button"]];
      [images addObject: [UIImage imageNamed:@"move-screen-button"]];
      dataEntry.images = images;
    } else if(count == 3) {
      NSMutableArray* images = [NSMutableArray arrayWithCapacity:4];
      [images addObject: [UIImage imageNamed:@"prwall-screen-button"]];
      [images addObject: [UIImage imageNamed:@"wod-screen-button"]];
      [images addObject: [UIImage imageNamed:@"workout-screen-button"]];
      [images addObject: [UIImage imageNamed:@"move-screen-button"]];
      dataEntry.images = images;
      dataEntry.comment = @"Almost there!!";
    }
  
    [dataEntries addObject:dataEntry];
    count++;
  }

  return dataEntries;
}

@end
