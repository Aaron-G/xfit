//
//  Exercise.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/24/12.
//
//

#import "Exercise.h"
#import "ExerciseMetadata.h"
#import "ModelHelper.h"

@implementation Exercise

- (Measurable *)newInstance {
  return [ModelHelper newExercise];
}


@end
