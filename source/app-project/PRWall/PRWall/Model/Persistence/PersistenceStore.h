//
//  PersistenceStore.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/10/13.
//
//

#import <Foundation/Foundation.h>
#import "UserProfile.h"
#import "Measurable.h"
#import "MeasurableDataEntryImage.h"
#import "MeasurableDataEntryVideo.h"
#import "MeasurableMetadataImage.h"
#import "MeasurableMetadataVideo.h"
#import "MeasurableCategory.h"
#import "MeasurableType.h"
#import "Tag.h"
#import "BodyMetricMetadata.h"
#import "ExerciseMetadata.h"
#import "ExerciseUnitValueDescriptor.h"
#import "WorkoutMetadata.h"

@class Measurable;

@interface PersistenceStore : NSObject

///////////////////////////////////////////////////
//Static
///////////////////////////////////////////////////
+ (PersistenceStore*) sharedInstance;

///////////////////////////////////////////////////
//Class
///////////////////////////////////////////////////
- (BOOL) save;

- (BOOL) needsSave;

- (void) discardUnsavedChanges;

- (BOOL) createAppDefaultData;

- (void) deleteModelObject:(NSManagedObject*) modelObject;

///////////////////////////////////////////////////
//User Profile
///////////////////////////////////////////////////
- (UserProfile*) newUserProfile;
- (UserProfile*) userProfile;

///////////////////////////////////////////////////
//Measurable
///////////////////////////////////////////////////
- (Measurable*)newMeasurableOfCategory:(MeasurableCategoryIdentifier) identifier;
- (MeasurableData*) newMeasurableData;
- (MeasurableMetadata*) newMeasurableMetadata;
- (MeasurableDataEntry *)newMeasurableDataEntry;

- (MeasurableDataEntryImage *) newMeasurableDataEntryImage;
- (MeasurableDataEntryVideo *) newMeasurableDataEntryVideo;
- (MeasurableMetadataImage*) newMeasurableMetadataImage;
- (MeasurableMetadataVideo*) newMeasurableMetadataVideo;
  
- (MeasurableCategory*) newMeasurableCategory;
- (MeasurableType*) newMeasurableType;

- (MeasurableType*) measurableTypeWithMeasurableTypeIdentifier: (MeasurableTypeIdentifier) identifier;
- (MeasurableCategory*) measurableCategoryWithMeasurableCategoryIdentifier: (MeasurableCategoryIdentifier) identifier;

///////////////////////////////////////////////////
//Body Metric
///////////////////////////////////////////////////
- (BodyMetricMetadata*) newBodyMetricMetadata;

///////////////////////////////////////////////////
//Exercise
///////////////////////////////////////////////////
- (ExerciseMetadata*) newExerciseMetadata;
- (ExerciseUnitValueDescriptor*) newExerciseUnitValueDescriptor;

///////////////////////////////////////////////////
//workout
///////////////////////////////////////////////////
- (WorkoutMetadata*) newWorkoutMetadata;

///////////////////////////////////////////////////
//Unit
///////////////////////////////////////////////////
- (Unit*) newUnit;
- (Unit*) unitWithUnitIdentifier: (UnitIdentifier) identifier;

///////////////////////////////////////////////////
//Tag
///////////////////////////////////////////////////
- (Tag*) newTag;
- (Tag *) tagWithText:(NSString *)text;
- (NSSet *) allTags;

@end
