//
//  ModelHelper.m
//  PR Wall
//
//  Created by Cleo Barretto on 1/10/13.
//
//

#import "ModelHelper.h"
#import "Measurable.h"
#import "MeasurableHelper.h"
#import "PersistenceStore.h"
#import "Exercise.h"
#import "Workout.h"

@implementation ModelHelper

///////////////////////////////////////////////////
//User Profile
///////////////////////////////////////////////////

+ (UserProfile*) userProfile {
  
  UserProfile* userProfile = [[PersistenceStore sharedInstance] userProfile];
  
  if(!userProfile) {
    
    //The default app data has not yet been created
    BOOL success = [[PersistenceStore sharedInstance] createAppDefaultData];
    
    if(success) {
      //Now get the user profile
      userProfile = [[PersistenceStore sharedInstance] userProfile];
    } else {
      //CXB_HANDLE
      NSLog(@"Could not create default user data");
    }
  }
  
  return userProfile;
}

///////////////////////////////////////////////////
//Measurable
///////////////////////////////////////////////////
- (Measurable*)newMeasurableOfCategory:(MeasurableCategoryIdentifier) identifier {

  //Create the measurable
  Measurable* measurable =  [[PersistenceStore sharedInstance] newMeasurableOfCategory:identifier];

  //Create a new metadata
  measurable.metadata = [ModelHelper newMeasurableMetadata];

  //Create a new data
  measurable.data = [ModelHelper newMeasurableData];
  
  return measurable;
}

+ (MeasurableData*) newMeasurableData {
  return [[PersistenceStore sharedInstance] newMeasurableData];
}

+ (MeasurableMetadata*) newMeasurableMetadata {
  return [[PersistenceStore sharedInstance] newMeasurableMetadata];
}

+ (MeasurableDataEntry*) newMeasurableDataEntry {
  return [[PersistenceStore sharedInstance] newMeasurableDataEntry];
}

+ (MeasurableDataEntryImage *) newMeasurableDataEntryImage {
  return [[PersistenceStore sharedInstance] newMeasurableDataEntryImage];
}

+ (MeasurableDataEntryVideo *) newMeasurableDataEntryVideo {
  return [[PersistenceStore sharedInstance] newMeasurableDataEntryVideo];
}

+ (MeasurableMetadataImage*) newMeasurableMetadataImage {
  return [[PersistenceStore sharedInstance] newMeasurableMetadataImage];
}

+ (MeasurableMetadataVideo*) newMeasurableMetadataVideo {
  return [[PersistenceStore sharedInstance] newMeasurableMetadataVideo];
}

+ (MeasurableCategory*) newMeasurableCategory {
  return [[PersistenceStore sharedInstance] newMeasurableCategory];
}

+ (MeasurableType*) newMeasurableType {
  return [[PersistenceStore sharedInstance] newMeasurableType];
}

+ (MeasurableType*) measurableTypeWithMeasurableTypeIdentifier: (MeasurableTypeIdentifier) identifier {
  return [[PersistenceStore sharedInstance] measurableTypeWithMeasurableTypeIdentifier:identifier];
}

+ (MeasurableCategory*) measurableCategoryWithMeasurableCategoryIdentifier: (MeasurableCategoryIdentifier) identifier {
  return [[PersistenceStore sharedInstance] measurableCategoryWithMeasurableCategoryIdentifier:identifier];
}

+ (BOOL) deleteMeasurable:(Measurable*) measurable andSave:(BOOL) save {
  
  UserProfile* userProfile = [ModelHelper userProfile];
  
  if([measurable.class isSubclassOfClass:[Exercise class]]) {
    [userProfile removeExercise:(Exercise*)measurable];
  } else if([measurable.class isSubclassOfClass:[Workout class]]) {
    [userProfile removeWorkout:(Workout*)measurable];
  } else {
    return NO;
  }
  
  if(save) {
    return [ModelHelper saveModelChanges];
  } else {
    return YES;
  }
}

///////////////////////////////////////////////////
//Exercise
///////////////////////////////////////////////////
+ (Exercise*) newExercise {
  
  //Create the measurable
  Measurable* measurable =  [[PersistenceStore sharedInstance] newMeasurableOfCategory:MeasurableCategoryIdentifierExercise];
  
  //Create a new metadata
  measurable.metadata = [ModelHelper newExerciseMetadata];
  
  //Create a new data
  measurable.data = [ModelHelper newMeasurableData];
  
  return (Exercise*)measurable;
}

+ (ExerciseMetadata*) newExerciseMetadata {

  ExerciseMetadata* metadata = [[PersistenceStore sharedInstance] newExerciseMetadata];
  
  metadata.category = [MeasurableCategory measurableCategoryWithMeasurableCategoryIdentifier: MeasurableCategoryIdentifierExercise];

  [ModelHelper applyDefaultValuesToMeasurableMetadata: metadata];

  return metadata;
}

+ (void) applyDefaultValuesToMeasurableMetadata:(MeasurableMetadata*) metadata {
  
  metadata.name = [NSString stringWithFormat: NSLocalizedString(@"measurable-name-new-format", @"New %@"), metadata.category.name];
  metadata.unit = [Unit unitForUnitIdentifier:UnitIdentifierNone];
  metadata.valueType = MeasurableValueTypeNumber;
  metadata.valueGoal = MeasurableValueGoalMore;
  metadata.valueSample = [NSNumber numberWithInt:1];
}

+ (ExerciseUnitValueDescriptor*) newExerciseUnitValueDescriptor {
  return [[PersistenceStore sharedInstance] newExerciseUnitValueDescriptor];
}

+ (BOOL) deleteModelObject:(NSManagedObject*) modelObject andSave:(BOOL) save {
  
  [[PersistenceStore sharedInstance] deleteModelObject:modelObject];
  
  if(save) {
    return [[PersistenceStore sharedInstance] save];
  } else {
    return YES;
  }
}

///////////////////////////////////////////////////
//Workout
///////////////////////////////////////////////////
+ (WorkoutMetadata*) newWorkoutMetadata {
  WorkoutMetadata* metadata = [[PersistenceStore sharedInstance] newWorkoutMetadata];
  
  metadata.category = [MeasurableCategory measurableCategoryWithMeasurableCategoryIdentifier: MeasurableCategoryIdentifierWorkout];
  
  [ModelHelper applyDefaultValuesToMeasurableMetadata: metadata];
  
  return metadata;
}

///////////////////////////////////////////////////
//Tag
///////////////////////////////////////////////////
+ (Tag*) newTag {
  return [[PersistenceStore sharedInstance] newTag];
}

+ (Tag *) tagForText:(NSString *)text {
  
  Tag* tag = [[PersistenceStore sharedInstance] tagWithText:text];
  
  if(!tag) {
    tag = [ModelHelper newTag];
    tag.text = text;
  }
  
  return tag;
}

+ (NSSet *) allTags {
  return [[PersistenceStore sharedInstance] allTags];
}

///////////////////////////////////////////////////
//Body Metric
///////////////////////////////////////////////////

+ (BodyMetric*) newBodyMetric {
  
  //Create the measurable
  Measurable* measurable =  [[PersistenceStore sharedInstance] newMeasurableOfCategory:MeasurableCategoryIdentifierBodyMetric];
  
  //Create a new metadata
  measurable.metadata = [ModelHelper newBodyMetricMetadata];

  //Create a new data
  measurable.data = [ModelHelper newMeasurableData];
  
  return (BodyMetric*)measurable;
}

+ (BodyMetricMetadata*) newBodyMetricMetadata {
  
  BodyMetricMetadata* metadata = [[PersistenceStore sharedInstance] newBodyMetricMetadata];
  
  metadata.category = [MeasurableCategory measurableCategoryWithMeasurableCategoryIdentifier: MeasurableCategoryIdentifierBodyMetric];

  [ModelHelper applyDefaultValuesToMeasurableMetadata: metadata];

  return metadata;
}

+ (void) storeBodyMetricIdentifier:(BodyMetricIdentifier) identifier forBodyMetric:(Measurable*) measurable {
  NSString* identifierReferenceKey = [[measurable.objectID URIRepresentation] absoluteString];
  [[NSUserDefaults standardUserDefaults] setValue:identifier forKey:identifierReferenceKey];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BodyMetricIdentifier) bodyMetricIdentifierForBodyMetric:(Measurable*) measurable {
  NSString* identifierReferenceKey = [[measurable.objectID URIRepresentation] absoluteString];
  return [[NSUserDefaults standardUserDefaults] stringForKey:identifierReferenceKey];
}

///////////////////////////////////////////////////
//Unit
///////////////////////////////////////////////////

+ (Unit*) unitWithUnitIdentifier: (UnitIdentifier) identifier {
  return [[PersistenceStore sharedInstance] unitWithUnitIdentifier:identifier];
}

///////////////////////////////////////////////////
//API
///////////////////////////////////////////////////

+ (BOOL) hasUnsavedModelChanges {
  return [[PersistenceStore sharedInstance] needsSave];
}

+ (BOOL) saveModelChanges {
  return [[PersistenceStore sharedInstance] save];
}

+ (void) cancelModelChanges {
  [[PersistenceStore sharedInstance] discardUnsavedChanges];
}

//////////////////////////////
//Store and lookup model object
//by integer identifier
//////////////////////////////
+ (void) storeModelObjectIdentifier:(NSInteger) identifier forModelObject:(NSManagedObject*) modelObject {
  NSString* identifierReferenceKey = [[modelObject.objectID URIRepresentation] absoluteString];
  [[NSUserDefaults standardUserDefaults] setInteger:identifier forKey:identifierReferenceKey];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger) modelObjectIdentifierForModelObject:(NSManagedObject*) modelObject {
  NSString* identifierReferenceKey = [[modelObject.objectID URIRepresentation] absoluteString];
  return [[NSUserDefaults standardUserDefaults] integerForKey:identifierReferenceKey];
}



@end