//
//  MeasurableCategory.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/19/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MeasurableCategory : NSManagedObject

typedef NSString* MeasurableCategoryIdentifier;
extern MeasurableCategoryIdentifier MeasurableCategoryIdentifierBodyMetric;
extern MeasurableCategoryIdentifier MeasurableCategoryIdentifierExercise;
extern MeasurableCategoryIdentifier MeasurableCategoryIdentifierWorkout;
extern MeasurableCategoryIdentifier MeasurableCategoryIdentifierWOD;

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////
//Attributes
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * namePlural;

//Relationships
@property (nonatomic, retain) NSSet * measurableMetadatas;
@property (nonatomic, retain) NSSet * measurableTypes;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////

//Attributes
@property MeasurableCategoryIdentifier identifier;
@property (nonatomic, retain) NSString * identifierImpl;

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////
+ (MeasurableCategory*) measurableCategoryWithMeasurableCategoryIdentifier: (MeasurableCategoryIdentifier) identifier;

@end
