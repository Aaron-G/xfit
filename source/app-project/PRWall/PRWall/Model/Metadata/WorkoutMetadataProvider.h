//
//  WorkoutMetadataProvider.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import "MeasurableMetadataProvider.h"

@interface WorkoutMetadataProvider : MeasurableMetadataProvider

/////////////////////////////////
//CXB - REVIEW - SAME AS EXERCISE, TRY TO REUSE
/////////////////////////////////
@property BOOL favorite;
@property NSArray* tags;
@property BOOL prwall;
/////////////////////////////////

@property BOOL team;

@end
