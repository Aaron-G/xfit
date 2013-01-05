//
//  ExerciseMoreInfo.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/31/12.
//
//

#import "ExerciseMoreInfo.h"

@implementation ExerciseMoreInfo

- (id)initWithIdentifier:(MeasurableMoreInfoIdentifier)identifier {
  self = [super init];
  
  if(self) {
    self.identifier = identifier;
  }
  
  return self;
}

- (id)copyWithZone:(NSZone *)zone {
  ExerciseMoreInfo* newExerciseMoreInfo = [[ExerciseMoreInfo alloc]initWithIdentifier:self.identifier];
  newExerciseMoreInfo.unit = self.unit;
  newExerciseMoreInfo.value = [self.value copy];
  return newExerciseMoreInfo;
}
@end
