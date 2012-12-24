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
  MeasurableTypeIdentifierMove,
  MeasurableTypeIdentifierWorkout,
  MeasurableTypeIdentifierWOD
} MeasurableTypeIdentifier;

@interface MeasurableType : NSObject

@property NSString* displayName;
@property MeasurableTypeIdentifier identifier;

+ (MeasurableType*) measurableTypeWithMeasurableTypeIdentifier: (MeasurableTypeIdentifier) identifier;

@end
