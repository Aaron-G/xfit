//
//  ExerciseMoreInfo.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/31/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"

@interface ExerciseMoreInfo : NSObject <NSCopying>

@property MeasurableMoreInfoIdentifier identifier;
@property NSNumber* value;
@property Unit* unit;

- initWithIdentifier:(MeasurableMoreInfoIdentifier) identifier;

@end
