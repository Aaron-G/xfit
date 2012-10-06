//
//  MeasurableType.h
//  CrossFitter
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

+ (MeasurableType*) measurableTypeWithMeasurableTypeIdentifier: (MeasurableTypeIdentifier) identifier;

@end
