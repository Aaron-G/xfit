//
//  ExerciseMetadataProvider.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import "MeasurableMetadataProvider.h"

@interface ExerciseMetadataProvider : MeasurableMetadataProvider

//Workout, WOD, Move
@property BOOL favorite;
@property NSArray* tags;

//Workout, Move
@property BOOL prwall;

@end
