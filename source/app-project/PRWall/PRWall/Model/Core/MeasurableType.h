//
//  MeasurableType.h
//  PR Wall
//
//  Created by Cleo Barretto on 10/5/12.
//
//

#import <Foundation/Foundation.h>

typedef enum {
  MeasurableTypeIdentifierBodyMetric,
  MeasurableTypeIdentifierExercise,
  MeasurableTypeIdentifierWorkout,
  MeasurableTypeIdentifierWOD
} MeasurableTypeIdentifier;

@interface MeasurableType : NSObject

@property NSString* displayName;
@property NSString* displayNamePlural;
@property MeasurableTypeIdentifier identifier;

+ (MeasurableType*) measurableTypeWithMeasurableTypeIdentifier: (MeasurableTypeIdentifier) identifier;

@end
