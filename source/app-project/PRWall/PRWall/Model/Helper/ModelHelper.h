//
//  ModelHelper.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/10/13.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"
#import "UserProfile.h"
#import "PersistenceStore.h"
#import "MeasurableDataEntryImage.h"
#import "MeasurableDataEntryVideo.h"
#import "MeasurableMetadataImage.h"
#import "MeasurableMetadataVideo.h"
#import "Tag.h"
#import "BodyMetric.h"
#import "MeasurableCategory.h"
#import "MeasurableType.h"
#import "ExerciseUnitValueDescriptor.h"
#import "BodyMetricMetadata.h"
#import "WorkoutMetadata.h"

@interface ModelHelper : NSObject

///////////////////////////////////////////////////
//User Profile
///////////////////////////////////////////////////
+ (UserProfile*) userProfile;

///////////////////////////////////////////////////
//Measurable
///////////////////////////////////////////////////
+ (MeasurableData*) newMeasurableData;
+ (MeasurableMetadata*) newMeasurableMetadata;
+ (MeasurableDataEntry*) newMeasurableDataEntry;
+ (MeasurableDataEntryVideo*) newMeasurableDataEntryVideo;
+ (MeasurableDataEntryImage*) newMeasurableDataEntryImage;
+ (MeasurableMetadataVideo*) newMeasurableMetadataVideo;
+ (MeasurableMetadataImage*) newMeasurableMetadataImage;
+ (MeasurableCategory*) newMeasurableCategory;
+ (MeasurableType*) newMeasurableType;

+ (MeasurableType*) measurableTypeWithMeasurableTypeIdentifier: (MeasurableTypeIdentifier) identifier;
+ (MeasurableCategory*) measurableCategoryWithMeasurableCategoryIdentifier: (MeasurableCategoryIdentifier) identifier;

+ (BOOL) deleteMeasurable:(Measurable*) measurable andSave:(BOOL) save;

///////////////////////////////////////////////////
//Exercise
///////////////////////////////////////////////////
+ (Exercise*) newExercise;
+ (ExerciseMetadata*) newExerciseMetadata;
+ (ExerciseUnitValueDescriptor*) newExerciseUnitValueDescriptor;

///////////////////////////////////////////////////
//Body Metric
///////////////////////////////////////////////////
+ (BodyMetric*) newBodyMetric;
+ (BodyMetricMetadata*) newBodyMetricMetadata;

+ (void) storeBodyMetricIdentifier:(BodyMetricIdentifier) identifier forBodyMetric:(Measurable*) measurable;

+ (BodyMetricIdentifier) bodyMetricIdentifierForBodyMetric:(Measurable*) measurable;

///////////////////////////////////////////////////
//Workout
///////////////////////////////////////////////////
+ (WorkoutMetadata*) newWorkoutMetadata;

///////////////////////////////////////////////////
//Tag
///////////////////////////////////////////////////
+ (Tag*) newTag;

+ (Tag *) tagForText: (NSString*) text;

+ (NSSet *) allTags;

///////////////////////////////////////////////////
//Unit
///////////////////////////////////////////////////

+ (Unit*) unitWithUnitIdentifier: (UnitIdentifier) identifier;

///////////////////////////////////////////////////
//API
///////////////////////////////////////////////////

+ (BOOL) hasUnsavedModelChanges;

+ (BOOL) saveModelChanges;

+ (void) cancelModelChanges;

+ (BOOL) deleteModelObject:(NSManagedObject*) modelObject andSave:(BOOL) save;

@end
