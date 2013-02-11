//
//  MeasurableType.h
//  PR Wall
//
//  Created by Cleo Barretto on 10/5/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MeasurableCategory.h"
#import "MeasurableMetadata.h"

typedef NSString* MeasurableTypeIdentifier;
typedef MeasurableTypeIdentifier ExerciseTypeIdentifier;
typedef MeasurableTypeIdentifier BodyMetricTypeIdentifier;

//Body Metric identifiers
extern BodyMetricTypeIdentifier BodyMetricTypeIdentifierBody;
extern BodyMetricTypeIdentifier BodyMetricTypeIdentifierLowerBody;
extern BodyMetricTypeIdentifier BodyMetricTypeIdentifierTorso;
extern BodyMetricTypeIdentifier BodyMetricTypeIdentifierUpperBody;

//Exercise identifiers
extern ExerciseTypeIdentifier ExerciseTypeIdentifierBall;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierBar;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierBody;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierBox;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierChain;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierCore;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierGHD;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierKettleBell;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierLadder;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierLift;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierMotion;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierRing;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierRope;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierRow;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierSled;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierSquat;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierStretch;
extern ExerciseTypeIdentifier ExerciseTypeIdentifierTire;

@class MeasurableMetadata;

@interface MeasurableType : NSManagedObject

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////
//Attributes
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * info;

//Relationships
@property (nonatomic, retain) MeasurableCategory * measurableCategory;
@property (nonatomic, retain) MeasurableMetadata * measurableMetadata;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////

//Attributes
@property MeasurableTypeIdentifier identifier;
@property (nonatomic, retain) NSString * identifierImpl;

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////

+ (MeasurableType*) measurableTypeWithMeasurableTypeIdentifier: (MeasurableTypeIdentifier) identifier;

@end
