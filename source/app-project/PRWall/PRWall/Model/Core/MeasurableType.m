//
//  MeasurableType.m
//  PR Wall
//
//  Created by Cleo Barretto on 10/5/12.
//
//

#import "MeasurableType.h"

@implementation MeasurableType

@synthesize displayName;
@synthesize displayNamePlural;

static NSMutableDictionary* _measurableTypes;

+ (MeasurableType*) measurableTypeWithMeasurableTypeIdentifier: (MeasurableTypeIdentifier) identifier {
  
  NSMutableDictionary* measurableTypes = [MeasurableType measurableTypes];
  NSString* identifierKey = [MeasurableType keyForMeasurableTypeIdentifier:identifier];
  
  MeasurableType* measurableType = [measurableTypes objectForKey:identifierKey];
  
  if(!measurableType) {

    //Create it
    measurableType = [[MeasurableType alloc] init];
    
    NSString* displayName = nil;
    NSString* displayNamePlural = nil;
    
    if(identifier == MeasurableTypeIdentifierBodyMetric) {
      displayName = NSLocalizedString(@"body-metric-display-name", @"Body Metric");
      displayNamePlural = NSLocalizedString(@"body-metric-display-name-plural", @"Body Metrics");
    } else if(identifier == MeasurableTypeIdentifierExercise) {
      displayName = NSLocalizedString(@"exercise-display-name", @"Exercise");
      displayNamePlural = NSLocalizedString(@"exercise-display-name-plural", @"Exercises");
    } else if(identifier == MeasurableTypeIdentifierWOD) {
      displayName = NSLocalizedString(@"wod-display-name", @"WOD");
      displayNamePlural = NSLocalizedString(@"wod-display-name-plural", @"WODs");
    } else if(identifier == MeasurableTypeIdentifierWorkout) {
      displayName = NSLocalizedString(@"workout-display-name", @"Workout");
      displayNamePlural = NSLocalizedString(@"workout-display-name-plural", @"Workouts");
    }
    
    measurableType.displayName = displayName;
    measurableType.displayNamePlural = displayNamePlural;
    measurableType.identifier = identifier;
    
    //Save it
    [measurableTypes setObject:measurableType forKey: identifierKey];
  }
  
  //Return it
  return measurableType;
}

+ (NSString*) keyForMeasurableTypeIdentifier:(MeasurableTypeIdentifier) identifier {
  return [NSString stringWithFormat:@"%d", identifier];
}

+ (NSMutableDictionary*) measurableTypes {
  
  if(!_measurableTypes) {
    _measurableTypes = [NSMutableDictionary dictionary];
  }
  return _measurableTypes;
}

@end
