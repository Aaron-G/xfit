//
//  Exercise.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/24/12.
//
//

#import "Exercise.h"
#import "ExerciseMetadataProvider.h"

@implementation Exercise

static NSInteger EXERCISE_IDENTIFIER_COUNT = 0;

const MeasurableMoreInfoIdentifier ExerciseMoreInfoTime = @"ExerciseMoreInfoTime";
const MeasurableMoreInfoIdentifier ExerciseMoreInfoMass = @"ExerciseMoreInfoMass";
const MeasurableMoreInfoIdentifier ExerciseMoreInfoLength = @"ExerciseMoreInfoLength";
const MeasurableMoreInfoIdentifier ExerciseMoreInfoGeneral = @"ExerciseMoreInfoGeneral";

- (MeasurableMetadataProvider*) createMetadataProviderWithIdentifier:(MeasurableIdentifier) identifier {
  return [[ExerciseMetadataProvider alloc] initWithMeasurableIdentifier:identifier];
}

- (id)copyWithZone:(NSZone *)zone {

  Exercise* exercise = (Exercise*)[Exercise new];
  [self.metadataProvider copyToMeasurableMetadataProvider:exercise.metadataProvider];
  
  [Exercise assignUserPriviligesToMeasurable:exercise];
  
  return exercise;
}

+ (id)new {
  
  Exercise* exercise = [[Exercise alloc]initWithIdentifier: [NSString stringWithFormat:@"exercise-%i", EXERCISE_IDENTIFIER_COUNT++]];
  [Exercise assignUserPriviligesToMeasurable:exercise];
  
  return exercise;
}

@end
