//
//  ExerciseMetadataProvider.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import "MeasurableMetadataProvider.h"

@interface ExerciseMetadataProvider : MeasurableMetadataProvider

//Workout, WOD, Exercise
@property BOOL favorite;
@property NSArray* tags;

//Workout, Exercise
@property BOOL prwall;

@end
