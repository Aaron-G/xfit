//
//  WorkoutMetadataProvider.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import "WorkoutMetadataProvider.h"

@implementation WorkoutMetadataProvider

- (id)initWithMeasurableIdentifier:(MeasurableIdentifier) identifier {
  self = [super initWithMeasurableIdentifier: identifier];
  
  if (self) {
    self.type = [MeasurableType measurableTypeWithMeasurableTypeIdentifier:MeasurableTypeIdentifierExercise];
    self.valueGoal = -1;
    self.valueType = -1;
  }
  return self;
}

- (void)copyToMeasurableMetadataProvider:(MeasurableMetadataProvider *)metadataProvider {
  
  [super copyToMeasurableMetadataProvider:metadataProvider];
  
  WorkoutMetadataProvider* workoutMetadataProvider = (WorkoutMetadataProvider*)metadataProvider;
  
  workoutMetadataProvider.team = self.team;
}

@end
