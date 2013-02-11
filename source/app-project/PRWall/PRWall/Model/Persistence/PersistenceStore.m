//
//  PersistenceStore.m
//  PR Wall
//
//  Created by Cleo Barretto on 1/10/13.
//
//

#import "PersistenceStore.h"
#import <CoreData/CoreData.h>
#import "ModelFactory.h"

@interface PersistenceStore ()

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation PersistenceStore

static PersistenceStore* _sharedInstance;

//Searches for the default user profile
static NSString* USER_PROFILE_FETCH_REQUEST = @"User_DefaultUserFetchRequest";

//Searches for a tag with a specific text
static NSString* TAG_FETCH_REQUEST = @"Tag_TagWithTextFetchRequest";

//Searches for all tags
static NSString* ALL_TAGS_FETCH_REQUEST = @"Tag_AllTagsFetchRequest";

//Searches for a measurable type with a specific identifier
static NSString* MEASURABLE_TYPE_FETCH_REQUEST = @"MeasurableType_MeasurableTypeWithIdentifierFetchRequest";

//Searches for a measurable category with a specific identifier
static NSString* MEASURABLE_CATEGORY_FETCH_REQUEST = @"MeasurableCategory_MeasurableCategoryWithIdentifierFetchRequest";

//Searches for a unit with a specific identifier
static NSString* UNIT_FETCH_REQUEST = @"Unit_UnitWithIdentifierFetchRequest";

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

////////////////////////////////////////////////////////////////////////////////
//API
////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////
//Static
///////////////////////////////////////////////////

+ (PersistenceStore *)sharedInstance {
  if(!_sharedInstance) {
    _sharedInstance = [[PersistenceStore alloc] init];
  }
  return _sharedInstance;
}

///////////////////////////////////////////////////
//Instance
///////////////////////////////////////////////////
- (BOOL) createAppDefaultData {

  BOOL success = YES;
  
  //User Profile
  UserProfile* userProfile = [ModelFactory createAppDefaultUserProfile];
  
  if(success && ![self save]) {
    NSLog(@"Could not create App default user profile");
    success = NO;
  }
  
  //Units
  if(success && ![ModelFactory createAppUnits]) {
    NSLog(@"Could not create App units");
    success = NO;
  }
  
  //Measurable Categories
  if(success && ![ModelFactory createAppMeasurableCategories]) {
    NSLog(@"Could not create App measurable categories");
    success = NO;
  }

  //Body Metrics
  if(success && ![ModelFactory createAppBodyMetricsForUserProfile: userProfile]) {
    NSLog(@"Could not create App body metrics");
    success = NO;
  }

  //Exercises
  if(success && ![ModelFactory createAppExercisesForUserProfile: userProfile]) {
    NSLog(@"Could not create App exercises");
    success = NO;
  }

  if(!success) {
    //CXB TODO
    //Clear DB and properties used by data model
  }
  
  return success;
}

- (BOOL)save {
  
  NSError *error = nil;
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
      
      return NO;
    }
  }

  return YES;
}

- (BOOL)needsSave {
  return [self.managedObjectContext hasChanges];
}

- (void) discardUnsavedChanges {
  [self.managedObjectContext rollback];
}

- (NSManagedObject*) managedObjectForManagedObjectIDURI: (NSURL*) managedObjectIDURI {
  
  NSManagedObjectID* objectID = [[self persistentStoreCoordinator] managedObjectIDForURIRepresentation:managedObjectIDURI];
  
  if (!objectID) {
    return nil;
  }
  
  NSManagedObject* objectForID = [self.managedObjectContext objectWithID:objectID];
  
  if (![objectForID isFault]) {
    return objectForID;
  }
  
  NSFetchRequest* request = [[NSFetchRequest alloc] init];
  
  [request setEntity:[objectID entity]];
  
  //Equivalent to predicate = [NSPredicate predicateWithFormat:@"SELF = %@", objectForID];
  NSPredicate *predicate = [NSComparisonPredicate
                            predicateWithLeftExpression:[NSExpression expressionForEvaluatedObject]
                            rightExpression: [NSExpression expressionForConstantValue:objectForID]
                            modifier: NSDirectPredicateModifier
                            type: NSEqualToPredicateOperatorType
                            options: 0];
  
  [request setPredicate:predicate];
  
  NSArray* results = [self.managedObjectContext executeFetchRequest:request error:nil];
  
  if ([results count] > 0) {
    return [results objectAtIndex:0];
  }
  
  return nil;
}

- (void) deleteModelObject:(NSManagedObject*) modelObject {
  [self.managedObjectContext deleteObject:modelObject];
}

///////////////////////////////////////////////////
//User Profile
///////////////////////////////////////////////////

- (UserProfile *)newUserProfile {
  return [self newInstanceForEntityName:@"UserProfile"];
}

- (UserProfile *)userProfile {
  return [self searchForObjectWithFetchRequest: [self fetchRequestForName:USER_PROFILE_FETCH_REQUEST]];
}

///////////////////////////////////////////////////
//Measurable
///////////////////////////////////////////////////

- (Measurable*)newMeasurableOfCategory:(MeasurableCategoryIdentifier) identifier {
  
  if(MeasurableCategoryIdentifierBodyMetric == identifier) {
    return [self newInstanceForEntityName:@"BodyMetric"];
  } else if(MeasurableCategoryIdentifierExercise == identifier) {
    return [self newInstanceForEntityName:@"Exercise"];
  }
  
  return nil;
}

- (MeasurableData*) newMeasurableData {
  return [self newInstanceForEntityName:@"MeasurableData"];
}

- (MeasurableMetadata*) newMeasurableMetadata {
  return [self newInstanceForEntityName:@"MeasurableMetadata"];
}
- (MeasurableDataEntry*) newMeasurableDataEntry {
  return [self newInstanceForEntityName:@"MeasurableDataEntry"];
}

- (MeasurableDataEntryImage *) newMeasurableDataEntryImage {
  return [self newInstanceForEntityName:@"MeasurableDataEntryImage"];
}

- (MeasurableDataEntryVideo *) newMeasurableDataEntryVideo {
  return [self newInstanceForEntityName:@"MeasurableDataEntryVideo"];
}

- (MeasurableMetadataImage*) newMeasurableMetadataImage {
  return [self newInstanceForEntityName:@"MeasurableMetadataImage"];
}

- (MeasurableMetadataVideo*) newMeasurableMetadataVideo {
  return [self newInstanceForEntityName:@"MeasurableMetadataVideo"];
}
- (MeasurableCategory*) newMeasurableCategory {
  return [self newInstanceForEntityName:@"MeasurableCategory"];
}
- (MeasurableType*) newMeasurableType {
  return [self newInstanceForEntityName:@"MeasurableType"];
}

- (MeasurableType*) measurableTypeWithMeasurableTypeIdentifier: (MeasurableTypeIdentifier) identifier {

  NSDictionary* substitutionVariables = [NSDictionary dictionaryWithObject:identifier forKey:@"IDENTIFIER"];
  NSFetchRequest* fetchRequest = [self.managedObjectModel fetchRequestFromTemplateWithName:MEASURABLE_TYPE_FETCH_REQUEST substitutionVariables:substitutionVariables];
  
  return [self searchForObjectWithFetchRequest:fetchRequest];
}

- (MeasurableCategory*) measurableCategoryWithMeasurableCategoryIdentifier: (MeasurableCategoryIdentifier) identifier {
  
  NSDictionary* substitutionVariables = [NSDictionary dictionaryWithObject:identifier forKey:@"IDENTIFIER"];
  NSFetchRequest* fetchRequest = [self.managedObjectModel fetchRequestFromTemplateWithName:MEASURABLE_CATEGORY_FETCH_REQUEST substitutionVariables:substitutionVariables];
  
  return [self searchForObjectWithFetchRequest:fetchRequest];
}

///////////////////////////////////////////////////
//Body Metric
///////////////////////////////////////////////////
- (BodyMetricMetadata*) newBodyMetricMetadata {
  return [self newInstanceForEntityName:@"BodyMetricMetadata"];
}

///////////////////////////////////////////////////
//Exercise
///////////////////////////////////////////////////
- (ExerciseMetadata*) newExerciseMetadata {
  return [self newInstanceForEntityName:@"ExerciseMetadata"];
}

- (ExerciseUnitValueDescriptor*) newExerciseUnitValueDescriptor {
  return [self newInstanceForEntityName:@"ExerciseUnitValueDescriptor"];
}

///////////////////////////////////////////////////
//Workout
///////////////////////////////////////////////////
- (WorkoutMetadata*) newWorkoutMetadata {
  return [self newInstanceForEntityName:@"WorkoutMetadata"];
}

///////////////////////////////////////////////////
//Unit
///////////////////////////////////////////////////
- (Unit*) newUnit {
  return [self newInstanceForEntityName:@"Unit"];
}

- (Unit*) unitWithUnitIdentifier: (UnitIdentifier) identifier {
  
  NSDictionary* substitutionVariables = [NSDictionary dictionaryWithObject:identifier forKey:@"IDENTIFIER"];
  NSFetchRequest* fetchRequest = [self.managedObjectModel fetchRequestFromTemplateWithName:UNIT_FETCH_REQUEST substitutionVariables:substitutionVariables];
  
  return [self searchForObjectWithFetchRequest:fetchRequest];
}

///////////////////////////////////////////////////
//Tag
///////////////////////////////////////////////////
- (Tag*) newTag {
  return [self newInstanceForEntityName:@"Tag"];
}

- (Tag *) tagWithText:(NSString *)text {

  NSDictionary* substitutionVariables = [NSDictionary dictionaryWithObject:text forKey:@"TEXT"];
  NSFetchRequest* fetchRequest = [self.managedObjectModel fetchRequestFromTemplateWithName:TAG_FETCH_REQUEST substitutionVariables:substitutionVariables];
  
  return [self searchForObjectWithFetchRequest:fetchRequest];
}

- (NSSet *) allTags {
  NSFetchRequest* fetchRequest = [self.managedObjectModel fetchRequestFromTemplateWithName:ALL_TAGS_FETCH_REQUEST substitutionVariables:nil];
  return [NSSet setWithArray: [self searchForObjectsWithFetchRequest:fetchRequest]];
}

////////////////////////////////////////////////////////////////////////////////
//Core Data
////////////////////////////////////////////////////////////////////////////////

- (id) searchForObjectWithFetchRequest:(NSFetchRequest*)fetchRequest {
  
  if(!fetchRequest) {
    // CXB Handle the error.
    return nil;
  }
  
  NSError* error = nil;
  NSArray* results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
  
  if (results == nil || results.count != 1) {
    // CXB Handle the error.
    return nil;
  } else {
    return [results objectAtIndex:0];
  }
}

- (NSArray*) searchForObjectsWithFetchRequest:(NSFetchRequest*)fetchRequest {
  
  if(!fetchRequest) {
    // CXB Handle the error.
    return nil;
  }
  
  NSError* error = nil;
  NSArray* results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
  
  if (results == nil) {
    // CXB Handle the error.
    return nil;
  } else {
    return results;
  }
}

- (id) newInstanceForEntityName:(NSString*) entityName {
  return [NSEntityDescription
          insertNewObjectForEntityForName:entityName
          inManagedObjectContext: self.managedObjectContext];
}

- (NSFetchRequest*) fetchRequestForName:(NSString*) fetchRequestName {
  NSManagedObjectModel* objectModel = [self managedObjectModel];
  return [objectModel fetchRequestTemplateForName:fetchRequestName];
}


#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
  if (_managedObjectContext != nil) {
    return _managedObjectContext;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (coordinator != nil) {
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
  }
  
//  [self addObserver:_managedObjectContext forKeyPath:@"hasChanges" options: NSKeyValueObservingOptionNew context: NULL];

  return _managedObjectContext;
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//  
//  if([@"hasChanges" isEqualToString:keyPath]) {
//    NSLog(@"PersistenceStore - hasChanges");    
//  }
//}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  
  NSURL *storeURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"Model.sqlite"];
  
  NSError *error = nil;
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    /*
     Replace this implementation with code to handle the error appropriately.
     
     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
     
     Typical reasons for an error here include:
     * The persistent store is not accessible;
     * The schema for the persistent store is incompatible with current managed object model.
     Check the error message to determine what the actual problem was.
     
     
     If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
     
     If you encounter schema incompatibility errors during development, you can reduce their frequency by:
     * Simply deleting the existing store:
     [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
     
     * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
     @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
     
     Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
     
     */
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
  
  return _persistentStoreCoordinator;
}

@end
