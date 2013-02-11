//
//  WorkoutMetadata.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import "WorkoutMetadata.h"
#import "ModelHelper.h"

@implementation WorkoutMetadata

@synthesize team;

- (MeasurableMetadata *)newInstance {
  return [ModelHelper newWorkoutMetadata];
}

- (id)copyWithZone:(NSZone *)zone {
  
  WorkoutMetadata* metadata = (WorkoutMetadata*)[super copyWithZone:zone];
  
  if(metadata) {
    
    metadata.team = self.team;
  }
  return metadata;
}

@end
