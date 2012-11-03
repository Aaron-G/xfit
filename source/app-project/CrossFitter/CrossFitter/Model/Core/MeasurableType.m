//
//  MeasurableType.m
//  CrossFitter
//
//  Created by Cleo Barretto on 10/5/12.
//
//

#import "MeasurableType.h"

@implementation MeasurableType

@synthesize displayName;

NSMutableDictionary* measurableTypes;

+ (MeasurableType*) measurableTypeWithMeasurableTypeIdentifier: (MeasurableTypeIdentifier) identifier {
  
  //CXB TODO
  //Make this into the equivalent of a static dictionary
  MeasurableType* measurableType = [[MeasurableType alloc] init];
  
  NSString* displayName = nil;
  
  if(identifier == MeasurableTypeIdentifierBodyMetric) {
    displayName = @"Body Metric";
  } else if(identifier == MeasurableTypeIdentifierMove) {
    displayName = @"Move";
  } else if(identifier == MeasurableTypeIdentifierWOD) {
    displayName = @"WOD";
  } else if(identifier == MeasurableTypeIdentifierWorkout) {
    displayName = @"Workout";
  }
  
  measurableType.displayName = displayName;
  measurableType.identifier = identifier;
  
  return measurableType;
}

@end
