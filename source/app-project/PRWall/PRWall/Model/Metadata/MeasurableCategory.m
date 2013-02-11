//
//  MeasurableCategory.m
//  PR Wall
//
//  Created by Cleo Barretto on 1/19/13.
//
//

#import "MeasurableCategory.h"
#import "ModelHelper.h"

MeasurableCategoryIdentifier MeasurableCategoryIdentifierBodyMetric = @"MeasurableCategoryIdentifierBodyMetric";
MeasurableCategoryIdentifier MeasurableCategoryIdentifierExercise = @"MeasurableCategoryIdentifierExercise";
MeasurableCategoryIdentifier MeasurableCategoryIdentifierWorkout = @"MeasurableCategoryIdentifierWorkout";
MeasurableCategoryIdentifier MeasurableCategoryIdentifierWOD = @"MeasurableCategoryIdentifierWOD";

@implementation MeasurableCategory

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////
//Attributes
@dynamic name;
@dynamic namePlural;

//Relationships
@dynamic measurableMetadatas;
@dynamic measurableTypes;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////

////////////////////////////////
//identifier
////////////////////////////////
@dynamic identifierImpl;

-(MeasurableCategoryIdentifier)identifier {
  [self willAccessValueForKey:@"identifier"];
  NSString *tmpValue = [self identifierImpl];
  [self didAccessValueForKey:@"identifier"];
  return tmpValue;
}

- (void)setIdentifier:(MeasurableCategoryIdentifier)identifier {
  NSString* tmpValue = identifier;
  [self willChangeValueForKey:@"identifier"];
  [self setIdentifierImpl:tmpValue];
  [self didChangeValueForKey:@"identifier"];
}

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////
+ (MeasurableCategory*) measurableCategoryWithMeasurableCategoryIdentifier: (MeasurableCategoryIdentifier) identifier {
  return [ModelHelper measurableCategoryWithMeasurableCategoryIdentifier: identifier];
}

@end
