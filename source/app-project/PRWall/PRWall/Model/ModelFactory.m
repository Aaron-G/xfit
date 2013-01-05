//
//  ModelFactory.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import "ModelFactory.h"
#import "BodyMetric.h"
#import "AppConstants.h"
#import "Exercise.h"
#import "ExerciseKind.h"


@interface ModelFactory () {
}

@end

@implementation ModelFactory

//////////////////////////////////////////////////////////////////////////
//USER PROFILE
//////////////////////////////////////////////////////////////////////////

+ (UserProfile*) createDefaultUserProfile {
  
  UserProfile* profile = [[UserProfile alloc] init];
  profile.name = @"John Smith";
  profile.sex = UserProfileSexMale;
  profile.box = @"CrossFit Box";
  profile.image = [NSString stringWithFormat:@"%@/%@", [NSBundle mainBundle].resourcePath, UserProfileDefaultImageName];
  
  NSDateComponents *comps = [[NSDateComponents alloc] init];
  [comps setDay:1];
  [comps setMonth:1];
  [comps setYear:1990];
  profile.dateOfBirth = [[NSCalendar currentCalendar] dateFromComponents:comps];

  return profile;
}

//////////////////////////////////////////////////////////////////////////
//BODY METRICS
//////////////////////////////////////////////////////////////////////////

+ (NSMutableDictionary*) createDefaultBodyMetrics {
  
  NSMutableDictionary* metrics =  [NSMutableDictionary dictionary];
  
  //Height
  BodyMetric * metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierHeight];
  NSArray* values = [NSArray arrayWithObjects:
                     [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 6]],
                     [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 6.5]],
                     [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 5]],
                     nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  metric.metadataProvider.valueSample = [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 6]];
  
  //Weight
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierWeight];
  values = [NSArray arrayWithObjects:
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 175.5]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 170]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 173]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 177]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 177]],
            nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  metric.metadataProvider.valueSample = [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 173]];
  
  //Body Mass Index
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierBodyMassIndex];
  values = [NSArray arrayWithObjects:
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 22.3]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 22.5]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 23.5]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 23.5]],
            nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  metric.metadataProvider.valueSample = [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 22.3]];
  
  //Body Fat
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierBodyFat];
  values = [NSArray arrayWithObjects:
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 23.01]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 24.01]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 23.35]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 25.4]],
            nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  metric.metadataProvider.valueSample = [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 25]];
  
  //Chest
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierChest];
  values = [NSArray arrayWithObjects:
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 37.2]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 36.5]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 37]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 38]],
            nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  metric.metadataProvider.valueSample = [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 35]];
  
  //Biceps Right
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierBiceptsRight];
  values = [NSArray arrayWithObjects:
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 12.8]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 12.8]],
            nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  metric.metadataProvider.valueSample = [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 12]];
  
  //Biceps Left
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierBiceptsLeft];
  values = [NSArray arrayWithObjects:
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 12.5]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 12.5]],
            nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  metric.metadataProvider.valueSample = [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 12]];
  
  //Waist
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierWaist];
  values = [NSArray arrayWithObjects:
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 35.6]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 35.7]],
            nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  metric.metadataProvider.valueSample = [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 35]];
  
  //Hip
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierHip];
  values = [NSArray arrayWithObjects:
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 39.9]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 37.7]],
            nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  metric.metadataProvider.valueSample = [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 40]];
  
  //Thigh Right
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierThighRight];
  values = [NSArray arrayWithObjects:
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 24.5]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 23]],
            nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  metric.metadataProvider.valueSample = [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 25]];
  
  //Thigh Left
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierThighLeft];
  values = [NSArray arrayWithObjects:
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 24.1]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 24.1]],
            nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  metric.metadataProvider.valueSample = [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 25]];
  
  //Calf Right
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierCalfRight];
  values = [NSArray arrayWithObjects:
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 11.7]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 12.1]],
            nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  metric.metadataProvider.valueSample = [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 12]];
  
  //Calf Left
  metric = [[BodyMetric alloc]initWithIdentifier: BodyMetricIdentifierCalfLeft];
  values = [NSArray arrayWithObjects:
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 11.3]],
            [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 11.1]],
            nil];
  metric.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: metric.metadataProvider.identifier withValues:values];
  [metrics setValue:metric forKey:metric.metadataProvider.identifier];
  metric.metadataProvider.valueSample = [metric.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 12]];
  
  return metrics;
}

//////////////////////////////////////////////////////////////////////////
//MOVES
//////////////////////////////////////////////////////////////////////////
+ (NSMutableDictionary*) createDefaultExercises {
  
  NSMutableDictionary* exercises =  [NSMutableDictionary dictionary];
  
  //Run 200 meters
  Exercise* exercise = [[Exercise alloc]initWithIdentifier: @"run-200"];
  NSArray* values = [NSArray arrayWithObjects:
                     [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 25]],
                     [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 29]],
                     nil];
  exercise.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: exercise.metadataProvider.identifier withValues:values];
  [exercises setValue:exercise forKey:exercise.metadataProvider.identifier];
  exercise.metadataProvider.valueSample = [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 50]];

  //Deadlift - Max
  exercise = [[Exercise alloc]initWithIdentifier: @"deadlift-max"];
  values = [NSArray arrayWithObjects:
            [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 350]],
            [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 300]],
            nil];
  exercise.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: exercise.metadataProvider.identifier withValues:values];
  [exercises setValue:exercise forKey:exercise.metadataProvider.identifier];
  exercise.metadataProvider.valueSample = [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 250]];

  //Thurster - Heavy
  exercise = [[Exercise alloc]initWithIdentifier: @"thruster-heavy"];
  values = [NSArray arrayWithObjects:
            [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 185]],
            [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 170]],
            nil];
  exercise.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: exercise.metadataProvider.identifier withValues:values];
  [exercises setValue:exercise forKey:exercise.metadataProvider.identifier];
  exercise.metadataProvider.valueSample = [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 115]];

  //Kipping Pull Up - Unbroken
  exercise = [[Exercise alloc]initWithIdentifier: @"pullup-unbroken"];
  values = [NSArray arrayWithObjects:
            [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 45]],
            [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 65]],
            nil];
  exercise.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: exercise.metadataProvider.identifier withValues:values];
  [exercises setValue:exercise forKey:exercise.metadataProvider.identifier];
  exercise.metadataProvider.valueSample = [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 35]];

  //Double Under - Unbroken
  exercise = [[Exercise alloc]initWithIdentifier: @"double-under-unbroken"];
  values = [NSArray arrayWithObjects:
            [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 99]],
            [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 83]],
            nil];
  exercise.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: exercise.metadataProvider.identifier withValues:values];
  [exercises setValue:exercise forKey:exercise.metadataProvider.identifier];
  exercise.metadataProvider.valueSample = [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat:20]];

  //Row 2000 meters
  exercise = [[Exercise alloc]initWithIdentifier: @"row-2000"];
  values = [NSArray arrayWithObjects:
            [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 480]],
            [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 480]],
            nil];
  exercise.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: exercise.metadataProvider.identifier withValues:values];
  [exercises setValue:exercise forKey:exercise.metadataProvider.identifier];
  exercise.metadataProvider.valueSample = [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat:500]];

  //Burpee - AMRAP - 1 minute
  exercise = [[Exercise alloc]initWithIdentifier: @"burpee-amrap"];
  values = [NSArray arrayWithObjects:
            [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 85]],
            [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: 102]],
            nil];
  exercise.dataProvider.values = [ModelFactory sampleMeasurableDataEntryForMeasurableId: exercise.metadataProvider.identifier withValues:values];
  [exercises setValue:exercise forKey:exercise.metadataProvider.identifier];
  exercise.metadataProvider.valueSample = [exercise.metadataProvider.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat:80]];

  return exercises;
}

//////////////////////////////////////////////////////////////////////////
//SHARED
//////////////////////////////////////////////////////////////////////////
+ (NSArray*) sampleMeasurableDataEntryForMeasurableId: (NSString*) measurableId withValues: (NSArray*) values {

  NSMutableArray* dataEntries = [NSMutableArray arrayWithCapacity:values.count];
  
  NSInteger count = 0;
  
  for (NSNumber* value in values) {
    
    MeasurableDataEntry* dataEntry = [[MeasurableDataEntry alloc] init];
    dataEntry.value = value;
    dataEntry.date = [NSDate dateWithTimeInterval:((-count-3)*7*24*60*60) sinceDate:[NSDate date]];
    
    if(count == 1) {
      dataEntry.comment = @"This was a sweet workout! But I would like a shorter break in between sets";
    }
  
    [dataEntries addObject:dataEntry];
    count++;
  }

  return dataEntries;
}


@end
