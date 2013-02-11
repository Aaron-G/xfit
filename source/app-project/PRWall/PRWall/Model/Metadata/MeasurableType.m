//
//  MeasurableType.m
//  PR Wall
//
//  Created by Cleo Barretto on 10/5/12.
//
//

#import "MeasurableType.h"
#import "ModelHelper.h"

ExerciseTypeIdentifier ExerciseTypeIdentifierBall = @"ExerciseTypeIdentifierBall";
ExerciseTypeIdentifier ExerciseTypeIdentifierBar = @"ExerciseTypeIdentifierBar";
ExerciseTypeIdentifier ExerciseTypeIdentifierBody = @"ExerciseTypeIdentifierBody";
ExerciseTypeIdentifier ExerciseTypeIdentifierBox = @"ExerciseTypeIdentifierBox";
ExerciseTypeIdentifier ExerciseTypeIdentifierChain = @"ExerciseTypeIdentifierChain";
ExerciseTypeIdentifier ExerciseTypeIdentifierCore = @"ExerciseTypeIdentifierCore";
ExerciseTypeIdentifier ExerciseTypeIdentifierGHD = @"ExerciseTypeIdentifierGHD";
ExerciseTypeIdentifier ExerciseTypeIdentifierKettleBell = @"ExerciseTypeIdentifierKettleBell";
ExerciseTypeIdentifier ExerciseTypeIdentifierLadder = @"ExerciseTypeIdentifierLadder";
ExerciseTypeIdentifier ExerciseTypeIdentifierLift = @"ExerciseTypeIdentifierLift";
ExerciseTypeIdentifier ExerciseTypeIdentifierMotion = @"ExerciseTypeIdentifierMotion";
ExerciseTypeIdentifier ExerciseTypeIdentifierRing = @"ExerciseTypeIdentifierRing";
ExerciseTypeIdentifier ExerciseTypeIdentifierRope = @"ExerciseTypeIdentifierRope";
ExerciseTypeIdentifier ExerciseTypeIdentifierRow = @"ExerciseTypeIdentifierRow";
ExerciseTypeIdentifier ExerciseTypeIdentifierSled = @"ExerciseTypeIdentifierSled";
ExerciseTypeIdentifier ExerciseTypeIdentifierSquat = @"ExerciseTypeIdentifierSquat";
ExerciseTypeIdentifier ExerciseTypeIdentifierStretch = @"ExerciseTypeIdentifierStretch";
ExerciseTypeIdentifier ExerciseTypeIdentifierTire = @"ExerciseTypeIdentifierTire";

BodyMetricTypeIdentifier BodyMetricTypeIdentifierBody = @"BodyMetricTypeIdentifierBody";
BodyMetricTypeIdentifier BodyMetricTypeIdentifierLowerBody = @"BodyMetricTypeIdentifierLowerBody";
BodyMetricTypeIdentifier BodyMetricTypeIdentifierTorso = @"BodyMetricTypeIdentifierTorso";
BodyMetricTypeIdentifier BodyMetricTypeIdentifierUpperBody = @"BodyMetricTypeIdentifierUpperBody";

@interface MeasurableType ()

@end

@implementation MeasurableType

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////
//Attributes
@dynamic name;
@dynamic info;

//Relationships
@dynamic measurableCategory;
@dynamic measurableMetadata;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////

////////////////////////////////
//identifier
////////////////////////////////
@dynamic identifierImpl;

-(MeasurableTypeIdentifier)identifier {
  [self willAccessValueForKey:@"identifier"];
  NSString *tmpValue = [self identifierImpl];
  [self didAccessValueForKey:@"identifier"];
  return tmpValue;
}

- (void)setIdentifier:(MeasurableTypeIdentifier)identifier {
  NSString* tmpValue = identifier;
  [self willChangeValueForKey:@"identifier"];
  [self setIdentifierImpl:tmpValue];
  [self didChangeValueForKey:@"identifier"];
}

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////

+ (MeasurableType*) measurableTypeWithMeasurableTypeIdentifier: (MeasurableTypeIdentifier) identifier {
  return [ModelHelper measurableTypeWithMeasurableTypeIdentifier: identifier];
}

@end