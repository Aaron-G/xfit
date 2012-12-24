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

static NSMutableDictionary* _measurableTypes;

+ (MeasurableType*) measurableTypeWithMeasurableTypeIdentifier: (MeasurableTypeIdentifier) identifier {
  
  NSMutableDictionary* measurableTypes = [MeasurableType measurableTypes];
  NSString* identifierKey = [MeasurableType keyForMeasurableTypeIdentifier:identifier];
  
  MeasurableType* measurableType = [measurableTypes objectForKey:identifierKey];
  
  if(!measurableType) {

    //Create it
    measurableType = [[MeasurableType alloc] init];
    
    NSString* displayName = nil;
    
    if(identifier == MeasurableTypeIdentifierBodyMetric) {
      displayName = NSLocalizedString(@"body-metric-display-name", @"Body Metric");
    } else if(identifier == MeasurableTypeIdentifierMove) {
      displayName = NSLocalizedString(@"move-display-name", @"Move");
    } else if(identifier == MeasurableTypeIdentifierWOD) {
      displayName = NSLocalizedString(@"wod-display-name", @"WOD");
    } else if(identifier == MeasurableTypeIdentifierWorkout) {
      displayName = NSLocalizedString(@"workout-display-name", @"Workout");
    }
    
    measurableType.displayName = displayName;
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
