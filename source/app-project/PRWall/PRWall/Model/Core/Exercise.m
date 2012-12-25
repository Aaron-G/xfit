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

- (MeasurableMetadataProvider*) createMetadataProviderWithIdentifier:(MeasurableIdentifier) identifier {
  return [[ExerciseMetadataProvider alloc] initWithMeasurableIdentifier:identifier];
}

@end
