//
//  Exercise.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/24/12.
//
//

#import "MeasurableImpl.h"

@interface Exercise : MeasurableImpl <NSCopying>

extern const MeasurableMoreInfoIdentifier ExerciseMoreInfoTime;
extern const MeasurableMoreInfoIdentifier ExerciseMoreInfoMass;
extern const MeasurableMoreInfoIdentifier ExerciseMoreInfoLength;
extern const MeasurableMoreInfoIdentifier ExerciseMoreInfoGeneral;

@end
