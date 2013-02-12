//
//  ModelFactory.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import "ModelFactory.h"
#import "AppConstants.h"
#import "BodyMetric.h"
#import "Exercise.h"
#import "ModelHelper.h"
#import "PersistenceStore.h"
#import "MeasurableDataEntryImage.h"
#import "MeasurableDataEntryVideo.h"
#import "MeasurableMetadataImage.h"
#import "MeasurableMetadataVideo.h"
#import "Tag.h"
#import "MeasurableCategory.h"
#import "MeasurableType.h"
#import "BodyMetric.h"
#import "MediaHelper.h"
#import "MeasurableHelper.h"

@interface ModelFactory () {
}

@end

@implementation ModelFactory

static NSInteger ONE_WEEK = 7*24*60*60;

//////////////////////////////////////////////////////////////////////////
//USER PROFILE
//////////////////////////////////////////////////////////////////////////

+ (UserProfile*) createAppDefaultUserProfile {
  
  PersistenceStore* persistenceStore = [PersistenceStore sharedInstance];
  
  UserProfile* userProfile = [persistenceStore newUserProfile];

  userProfile.name = @"John Smith";
  userProfile.sex = UserProfileSexMale;
  userProfile.box = @"CrossFit Box";
  userProfile.image = [NSString stringWithFormat:@"%@/%@", [NSBundle mainBundle].resourcePath, UserProfileDefaultImageName];
  userProfile.primary = YES;
  
  NSDateComponents *comps = [[NSDateComponents alloc] init];
  [comps setDay:1];
  [comps setMonth:1];
  [comps setYear:1990];
  userProfile.dateOfBirth = [[NSCalendar currentCalendar] dateFromComponents:comps];
  
  return userProfile;
}

//////////////////////////////////////////////////////////////////////////
//UNITS
//////////////////////////////////////////////////////////////////////////

+ (BOOL) createAppUnits {
  
  PersistenceStore* persistenceStore = [PersistenceStore sharedInstance];
  
  NSArray* unitIdentifiers = [NSArray arrayWithObjects:
                              UnitIdentifierKilometer,
                              UnitIdentifierMeter,
                              UnitIdentifierMile,
                              UnitIdentifierYard,
                              UnitIdentifierFoot,
                              UnitIdentifierInch,
                              UnitIdentifierKilogram,
                              UnitIdentifierPound,
                              UnitIdentifierPood,
                              UnitIdentifierSecond,
                              UnitIdentifierNone,
                              UnitIdentifierPercent,
                              nil];
  
  NSArray* unitTypes = [NSArray arrayWithObjects:
                        [NSNumber numberWithInt: UnitTypeLength],
                        [NSNumber numberWithInt: UnitTypeLength],
                        [NSNumber numberWithInt: UnitTypeLength],
                        [NSNumber numberWithInt: UnitTypeLength],
                        [NSNumber numberWithInt: UnitTypeLength],
                        [NSNumber numberWithInt: UnitTypeLength],
                        
                        [NSNumber numberWithInt: UnitTypeMass],
                        [NSNumber numberWithInt: UnitTypeMass],
                        [NSNumber numberWithInt: UnitTypeMass],
                        
                        [NSNumber numberWithInt: UnitTypeTime],
                        
                        [NSNumber numberWithInt: UnitTypeGeneral],
                        [NSNumber numberWithInt: UnitTypeGeneral],
                        nil];
  
  
  for (int i = 0; i < unitIdentifiers.count; i++) {
  
    UnitIdentifier identifier = [unitIdentifiers objectAtIndex:i];

    Unit* unit = [persistenceStore newUnit];
    unit.identifier = identifier;
    unit.type = [((NSNumber*)[unitTypes objectAtIndex:i]) intValue];
  }

  return [persistenceStore save];
}

//////////////////////////////////////////////////////////////////////////
//MEASURABLE CATEGORIES
//////////////////////////////////////////////////////////////////////////
+ (BOOL) createAppMeasurableCategories {
  
  PersistenceStore* persistenceStore = [PersistenceStore sharedInstance];

  ////////////////////////////////////
  //Category - Body Metric
  MeasurableCategory* measurableCategory = [ModelHelper newMeasurableCategory];
  measurableCategory.identifier = MeasurableCategoryIdentifierBodyMetric;
  measurableCategory.name = NSLocalizedString(@"body-metric-display-name", @"Body Metric");
  measurableCategory.namePlural = NSLocalizedString(@"body-metric-display-name-plural", @"Body Metrics");

  //Types for this category
  NSArray* measurableTypeIdentifiers = [NSArray arrayWithObjects:
                                        BodyMetricTypeIdentifierBody,
                                        BodyMetricTypeIdentifierLowerBody,
                                        BodyMetricTypeIdentifierTorso,
                                        BodyMetricTypeIdentifierUpperBody,
                                        nil];
  
  NSArray* measurableTypeNames = [NSArray arrayWithObjects:
                                  @"Body",
                                  @"Lower",
                                  @"Torso",
                                  @"Upper",
                                  nil];
  NSArray* measurableTypeInfo = [NSArray arrayWithObjects:
                                  @"General body metrics",
                                  @"Lower body metrics",
                                  @"Torso and mid body metrics",
                                  @"Upper body metrics",
                                  nil];
  
  for (NSInteger i = 0; i < measurableTypeIdentifiers.count; i++) {
    
    MeasurableType* measurableType = [ModelHelper newMeasurableType];
    measurableType.identifier = [measurableTypeIdentifiers objectAtIndex: i];
    measurableType.name = [measurableTypeNames objectAtIndex:i];
    measurableType.info = [measurableTypeInfo objectAtIndex:i];
    measurableType.measurableCategory = measurableCategory;    
  }

  ////////////////////////////////////
  //Category - Exercise
  measurableCategory = [ModelHelper newMeasurableCategory];
  measurableCategory.identifier = MeasurableCategoryIdentifierExercise;
  measurableCategory.name = NSLocalizedString(@"exercise-display-name", @"Exercise");
  measurableCategory.namePlural = NSLocalizedString(@"exercise-display-name-plural", @"Exercises");

  //Types for this category
  measurableTypeIdentifiers = [NSArray arrayWithObjects:
                               ExerciseTypeIdentifierBall,
                               ExerciseTypeIdentifierBar,
                               ExerciseTypeIdentifierBody,
                               ExerciseTypeIdentifierBox,
                               ExerciseTypeIdentifierChain,
                               ExerciseTypeIdentifierCore,
                               ExerciseTypeIdentifierGHD,
                               ExerciseTypeIdentifierKettleBell,
                               ExerciseTypeIdentifierLadder,
                               ExerciseTypeIdentifierLift,
                               ExerciseTypeIdentifierMotion,
                               ExerciseTypeIdentifierRing,
                               ExerciseTypeIdentifierRope,
                               ExerciseTypeIdentifierRow,
                               ExerciseTypeIdentifierSled,
                               ExerciseTypeIdentifierSquat,
                               ExerciseTypeIdentifierStretch,
                               ExerciseTypeIdentifierTire,
                               nil];

  measurableTypeNames = [NSArray arrayWithObjects:
                         @"Ball",
                         @"Bar",
                         @"Body",
                         @"Box",
                         @"Chain",
                         @"Core",
                         @"GHD",
                         @"Kettle Bell",
                         @"Ladder",
                         @"Lift",
                         @"Motion",
                         @"Ring",
                         @"Rope",
                         @"Row",
                         @"Sled",
                         @"Squat",
                         @"Stretch",
                         @"Tire",
                         nil];
  
  measurableTypeInfo = [NSArray arrayWithObjects:
                                     @"Wall ball, ball slam",
                                     @"Pull up, chin up",
                                     @"Push up, burpee",
                                     @"Box jump, dip",
                                     @"Battle Chain",
                                     @"Bicycle crunch, ISO abs",
                                     @"Back extension, sit up",
                                     @"Kettle bell swing, man makers",
                                     @"Ladder push up, ladder sprints",
                                     @"Clean, thurster, jerk",
                                     @"Run, liners, lunge",
                                     @"Ring dip, muscle up",
                                     @"Double under, rope climb",
                                     @"Row, row sprints",
                                     @"Sled pull",
                                     @"Front squat, back squat",
                                     @"Foam roll, rest",
                                     @"Tire flip, tire hammer",
                                     nil];
  
  for (NSInteger i = 0; i < measurableTypeIdentifiers.count; i++) {
    
    MeasurableType* measurableType = [ModelHelper newMeasurableType];
    measurableType.identifier = [measurableTypeIdentifiers objectAtIndex: i];
    measurableType.name = [measurableTypeNames objectAtIndex:i];
    measurableType.info = [measurableTypeInfo objectAtIndex:i];
    measurableType.measurableCategory = measurableCategory;
  }

  ////////////////////////////////////
  //Category - Workout
  measurableCategory = [ModelHelper newMeasurableCategory];
  measurableCategory.identifier = MeasurableCategoryIdentifierWorkout;
  measurableCategory.name = NSLocalizedString(@"workout-display-name", @"Workout");
  measurableCategory.namePlural = NSLocalizedString(@"workout-display-name-plural", @"Workouts");

  return [persistenceStore save];
}

//////////////////////////////////////////////////////////////////////////
//MEASURABLE
//////////////////////////////////////////////////////////////////////////

+ (BOOL) populateMeasurable:(Measurable*)measurable withValues:(NSArray*) values withValueComments:(NSArray*) valuesComments withValueImages:(NSArray*) valuesImages withValueVideos:(NSArray*) valuesVideos {
  
  //CXB TODO IMPL VIDEOS
  
  id<UnitSystemConverter> unitSystemConverter = measurable.metadata.unit.unitSystemConverter;
  MeasurableData* measurableData = measurable.data;
  MediaHelperPurpose mediaHelperPurpose = [MeasurableHelper mediaHelperPurposeForMeasurable:measurable];
  
  for (int i = 0; i < values.count; i++) {
    
    //Create data entry
    MeasurableDataEntry* dataEntry = [ModelHelper newMeasurableDataEntry];
    dataEntry.date = [NSDate dateWithTimeInterval: (i * -ONE_WEEK) sinceDate:[NSDate date]];
    dataEntry.value = [unitSystemConverter convertToSystemValue: [values objectAtIndex:i]];
    dataEntry.comment = [valuesComments objectAtIndex:i];
    
    //Add images
    NSArray* imageNames = [valuesImages objectAtIndex:i];
    
    for (NSInteger i=0; i < imageNames.count; i++) {
      
      //Create media object
      MeasurableDataEntryImage* dataEntryImage = [ModelHelper newMeasurableDataEntryImage];
      
      dataEntryImage.index = [NSNumber numberWithInt: i];
      
      NSURL* imageURL = [MediaHelper saveImage:[UIImage imageNamed:imageNames[i]] forPurpose:mediaHelperPurpose];
      dataEntryImage.path = imageURL.path;
      
      [dataEntry addImage:dataEntryImage];
    }
    
    [measurableData addValue: dataEntry];
  }

  //Need to save to get the permanent object identifier
  if(![[PersistenceStore sharedInstance] save]) {
    return NO;
  }
  
  return YES;
}

+ (void) populateMetadataForMeasurable:(Measurable*)measurable
                              withName:(NSString*) name
                        withDefinition:(NSString*) definition
                              withTags:(NSArray*) tagsText
                            withImages:(NSArray*) imagesName
                            withVideos:(NSArray*) videosName
          withMeasurableTypeIdentifier:(MeasurableTypeIdentifier) measurableTypeIdentifier
                    withUnitIdentifier:(UnitIdentifier) unitIdentifier
               withMeasurableValueType:(MeasurableValueType) measurableValueType
               withMeasurableValueGoal:(MeasurableValueGoal) measurableValueGoal
                       withValueSample:(float) valueSample
                          withCopyable:(BOOL) copyable
{
  //CXB TODO IMPL VIDEOS
  MeasurableMetadata* measurableMetadata = measurable.metadata;
  
  //Source
  measurableMetadata.source = MeasurableSourceApp;
  
  //Type
  measurableMetadata.type = [MeasurableType measurableTypeWithMeasurableTypeIdentifier: measurableTypeIdentifier];
  
  //Unit
  measurableMetadata.unit = [Unit unitForUnitIdentifier:unitIdentifier];
  
  //Value type
  measurableMetadata.valueType = measurableValueType;
  
  //Value goal
  measurableMetadata.valueGoal = measurableValueGoal;
  
  //Value sample
  id<UnitSystemConverter> unitSystemConverter = measurable.metadata.unit.unitSystemConverter;
  measurableMetadata.valueSample = [unitSystemConverter convertToSystemValue:[NSNumber numberWithFloat: valueSample]];
  
  //Copyable
  measurableMetadata.copyable = copyable;
  
  //Name
  measurableMetadata.name = name;
  
  //Comment
  measurableMetadata.definition = definition;
  
  //Tags
  for (NSString* tagText in tagsText) {
    [measurableMetadata addTag:[ModelHelper tagForText:tagText]];
  }
  
  MediaHelperPurpose mediaHelperPurpose = [MeasurableHelper mediaHelperPurposeForMeasurable:measurable];

  //Images
  for (NSInteger i=0; i < imagesName.count; i++) {
    
    //Create media object
    MeasurableMetadataImage* measurableImage = [ModelHelper newMeasurableMetadataImage];
    measurableImage.index = [NSNumber numberWithInt: i];
    
    NSURL* imageURL = [MediaHelper saveImage:[UIImage imageNamed:imagesName[i]] forPurpose:mediaHelperPurpose];
    measurableImage.path = imageURL.path;
    
    [measurableMetadata addImage:measurableImage];
  }
}

//////////////////////////////////////////////////////////////////////////
//BODY METRICS
//////////////////////////////////////////////////////////////////////////

+ (BOOL) createAppBodyMetricsForUserProfile: (UserProfile*) userProfile {
  
  //Weight
  BodyMetric* bodyMetric = [ModelHelper newBodyMetric];
  [userProfile addBodyMetric:bodyMetric];
  
  if(![self createMetadataForWeight:bodyMetric] || ![self createDataForWeight:bodyMetric]) {
    return NO;
  }

  //Height
  bodyMetric = [ModelHelper newBodyMetric];
  [userProfile addBodyMetric:bodyMetric];
  
  if(![self createMetadataForHeight:bodyMetric] || ![self createDataForHeight:bodyMetric]) {
    return NO;
  }

  //Body Mass Index
  bodyMetric = [ModelHelper newBodyMetric];
  [userProfile addBodyMetric:bodyMetric];
  
  if(![self createMetadataForBodyMassIndex:bodyMetric] || ![self createDataForBodyMassIndex:bodyMetric]) {
    return NO;
  }

  //Body Fat
  bodyMetric = [ModelHelper newBodyMetric];
  [userProfile addBodyMetric:bodyMetric];
  
  if(![self createMetadataForBodyFat:bodyMetric] || ![self createDataForBodyFat:bodyMetric]) {
    return NO;
  }

  //Chest
  bodyMetric = [ModelHelper newBodyMetric];
  [userProfile addBodyMetric:bodyMetric];
  
  if(![self createMetadataForChest:bodyMetric] || ![self createDataForChest: bodyMetric]) {
    return NO;
  }

  //Bicepts - Right
  bodyMetric = [ModelHelper newBodyMetric];
  [userProfile addBodyMetric:bodyMetric];
  
  if(![self createMetadataForBicepsRight:bodyMetric] || ![self createDataForBicepsRight: bodyMetric]) {
    return NO;
  }

  //Bicepts - Left
  bodyMetric = [ModelHelper newBodyMetric];
  [userProfile addBodyMetric:bodyMetric];
  
  if(![self createMetadataForBicepsLeft:bodyMetric] || ![self createDataForBicepsLeft: bodyMetric]) {
    return NO;
  }

  //Waist
  bodyMetric = [ModelHelper newBodyMetric];
  [userProfile addBodyMetric:bodyMetric];
  
  if(![self createMetadataForWaist:bodyMetric] || ![self createDataForWaist: bodyMetric]) {
    return NO;
  }

  //Hip
  bodyMetric = [ModelHelper newBodyMetric];
  [userProfile addBodyMetric:bodyMetric];
  
  if(![self createMetadataForHip:bodyMetric] || ![self createDataForHip: bodyMetric]) {
    return NO;
  }

  //Thigh - Right
  bodyMetric = [ModelHelper newBodyMetric];
  [userProfile addBodyMetric:bodyMetric];
  
  if(![self createMetadataForThighRight:bodyMetric] || ![self createDataForThighRight: bodyMetric]) {
    return NO;
  }

  //Thigh - Left
  bodyMetric = [ModelHelper newBodyMetric];
  [userProfile addBodyMetric:bodyMetric];
  
  if(![self createMetadataForThighLeft:bodyMetric] || ![self createDataForThighLeft: bodyMetric]) {
    return NO;
  }

  //Calf - Right
  bodyMetric = [ModelHelper newBodyMetric];
  [userProfile addBodyMetric:bodyMetric];
  
  if(![self createMetadataForCalfRight:bodyMetric] || ![self createDataForCalfRight: bodyMetric]) {
    return NO;
  }
  
  //Calf - Left
  bodyMetric = [ModelHelper newBodyMetric];
  [userProfile addBodyMetric:bodyMetric];
  
  if(![self createMetadataForCalfLeft:bodyMetric] || ![self createDataForCalfLeft: bodyMetric]) {
    return NO;
  }

  return YES;
}

+ (BOOL) createMetadataForHeight:(Measurable*)measurable {  
  return [ModelFactory populateMetadataForBodyMetric:measurable
                                            withName:NSLocalizedString(@"height-metric-label", @"Height")
                                      withDefinition:NSLocalizedString(@"height-metric-description", @"")
                                            withTags:nil
                                          withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                          withVideos:nil
                        withMeasurableTypeIdentifier:BodyMetricTypeIdentifierBody
                                  withUnitIdentifier:UnitIdentifierFoot
                             withMeasurableValueType:MeasurableValueTypeNumberWithDecimal
                             withMeasurableValueGoal:MeasurableValueGoalMore
                                     withValueSample:6.0
                                        withCopyable:NO
                            withBodyMetricIdentifier:BodyMetricIdentifierHeight];
}

+ (BOOL) createDataForHeight:(Measurable*)measurable {

  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat:6.0],
                     [NSNumber numberWithFloat:5.5],
                     nil];
  NSArray* valuesComments = [NSArray arrayWithObjects:
                       @"Comment 1",
                       @"Comment 2",
                       nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                         [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                         [NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil],
                         nil];

  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (BOOL) createMetadataForWeight:(Measurable*)measurable {
  return [ModelFactory populateMetadataForBodyMetric:measurable
                                            withName:NSLocalizedString(@"weight-metric-label", @"Weight")
                                      withDefinition:NSLocalizedString(@"weight-metric-description", @"")
                                            withTags:nil
                                          withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                          withVideos:nil
                        withMeasurableTypeIdentifier:BodyMetricTypeIdentifierBody
                                  withUnitIdentifier:UnitIdentifierPound
                             withMeasurableValueType:MeasurableValueTypeNumberWithDecimal
                             withMeasurableValueGoal:MeasurableValueGoalLess
                                     withValueSample:173
                                        withCopyable:NO
                            withBodyMetricIdentifier:BodyMetricIdentifierWeight];
}

+ (BOOL) createDataForWeight:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 175.5],
                     [NSNumber numberWithFloat: 170],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             @"Comment 2",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                           [NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (BOOL) createMetadataForBodyMassIndex:(Measurable*)measurable {
  return [ModelFactory populateMetadataForBodyMetric:measurable
                                            withName:NSLocalizedString(@"body-mass-index-metric-label", @"Body Mass Index")
                                      withDefinition:NSLocalizedString(@"body-mass-index-metric-description", @"")
                                            withTags:nil
                                          withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                          withVideos:nil
                        withMeasurableTypeIdentifier:BodyMetricTypeIdentifierBody
                                  withUnitIdentifier:UnitIdentifierNone
                             withMeasurableValueType:MeasurableValueTypePercent
                             withMeasurableValueGoal:MeasurableValueGoalLess
                                     withValueSample:30
                                        withCopyable:NO
                            withBodyMetricIdentifier:BodyMetricIdentifierBodyMassIndex];
}

+ (BOOL) createDataForBodyMassIndex:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 21],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray array],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (BOOL) createMetadataForBodyFat:(Measurable*)measurable {
  return [ModelFactory populateMetadataForBodyMetric:measurable
                                            withName:NSLocalizedString(@"body-fat-metric-label", @"Body Fat")
                                      withDefinition:NSLocalizedString(@"body-fat-metric-description", @"")
                                            withTags:nil
                                          withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                          withVideos:nil
                        withMeasurableTypeIdentifier:BodyMetricTypeIdentifierBody
                                  withUnitIdentifier:UnitIdentifierPercent
                             withMeasurableValueType:MeasurableValueTypePercent
                             withMeasurableValueGoal:MeasurableValueGoalLess
                                     withValueSample:30
                                        withCopyable:NO
                            withBodyMetricIdentifier:BodyMetricIdentifierBodyFat];
}

+ (BOOL) createDataForBodyFat:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 23.3],
                     [NSNumber numberWithFloat: 25.2],
                     [NSNumber numberWithFloat: 26],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             @"Comment 2",
                             @"",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                           [NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil],
                           [NSArray array],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (BOOL) createMetadataForChest:(Measurable*)measurable {
  return [ModelFactory populateMetadataForBodyMetric:measurable
                                            withName:NSLocalizedString(@"chest-metric-label", @"Chest")
                                      withDefinition:NSLocalizedString(@"chest-metric-description", @"")
                                            withTags:nil
                                          withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                          withVideos:nil
                        withMeasurableTypeIdentifier:BodyMetricTypeIdentifierBody
                                  withUnitIdentifier:UnitIdentifierInch
                             withMeasurableValueType:MeasurableValueTypeNumberWithDecimal
                             withMeasurableValueGoal:MeasurableValueGoalMore
                                     withValueSample:35
                                        withCopyable:NO
                            withBodyMetricIdentifier:BodyMetricIdentifierChest];
}

+ (BOOL) createDataForChest:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 37.2],
                     [NSNumber numberWithFloat: 36.5],
                     [NSNumber numberWithFloat: 37],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             @"Comment 2",
                             @"",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                           [NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil],
                           [NSArray array],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (BOOL) createMetadataForBicepsRight:(Measurable*)measurable {
  return [ModelFactory populateMetadataForBodyMetric:measurable
                                            withName:NSLocalizedString(@"biceps-right-metric-label", @"Biceps")
                                      withDefinition:NSLocalizedString(@"biceps-right-metric-description", @"")
                                            withTags:[NSArray arrayWithObjects:@"Right", nil]
                                          withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                          withVideos:nil
                        withMeasurableTypeIdentifier:BodyMetricTypeIdentifierBody
                                  withUnitIdentifier:UnitIdentifierInch
                             withMeasurableValueType:MeasurableValueTypeNumberWithDecimal
                             withMeasurableValueGoal:MeasurableValueGoalMore
                                     withValueSample:12
                                        withCopyable:NO
                            withBodyMetricIdentifier:BodyMetricIdentifierBicepsRight];
}

+ (BOOL) createDataForBicepsRight:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 12.8],
                     [NSNumber numberWithFloat: 12.2],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             @"",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                           [NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (BOOL) createMetadataForBicepsLeft:(Measurable*)measurable {
  return [ModelFactory populateMetadataForBodyMetric:measurable
                                            withName:NSLocalizedString(@"biceps-left-metric-label", @"Biceps")
                                      withDefinition:NSLocalizedString(@"biceps-left-metric-description", @"")
                                            withTags:[NSArray arrayWithObjects:@"Left", nil]
                                          withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                          withVideos:nil
                        withMeasurableTypeIdentifier:BodyMetricTypeIdentifierBody
                                  withUnitIdentifier:UnitIdentifierInch
                             withMeasurableValueType:MeasurableValueTypeNumberWithDecimal
                             withMeasurableValueGoal:MeasurableValueGoalMore
                                     withValueSample:12
                                        withCopyable:NO
                            withBodyMetricIdentifier:BodyMetricIdentifierBicepsLeft];
}

+ (BOOL) createDataForBicepsLeft:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 13],
                     [NSNumber numberWithFloat: 12.5],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             @"",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                           [NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (BOOL) createMetadataForWaist:(Measurable*)measurable {
  return [ModelFactory populateMetadataForBodyMetric:measurable
                                            withName:NSLocalizedString(@"waist-metric-label", @"Waist")
                                      withDefinition:NSLocalizedString(@"waist-metric-description", @"")
                                            withTags:nil
                                          withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                          withVideos:nil
                        withMeasurableTypeIdentifier:BodyMetricTypeIdentifierBody
                                  withUnitIdentifier:UnitIdentifierInch
                             withMeasurableValueType:MeasurableValueTypeNumberWithDecimal
                             withMeasurableValueGoal:MeasurableValueGoalLess
                                     withValueSample:35
                                        withCopyable:NO
                            withBodyMetricIdentifier:BodyMetricIdentifierWaist];
}

+ (BOOL) createDataForWaist:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 35.6],
                     [NSNumber numberWithFloat: 34.7],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             @"",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                           [NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (BOOL) createMetadataForHip:(Measurable*)measurable {
  return [ModelFactory populateMetadataForBodyMetric:measurable
                                            withName:NSLocalizedString(@"hip-metric-label", @"Hip")
                                      withDefinition:NSLocalizedString(@"hip-metric-description", @"")
                                            withTags:nil
                                          withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                          withVideos:nil
                        withMeasurableTypeIdentifier:BodyMetricTypeIdentifierBody
                                  withUnitIdentifier:UnitIdentifierInch
                             withMeasurableValueType:MeasurableValueTypeNumberWithDecimal
                             withMeasurableValueGoal:MeasurableValueGoalLess
                                     withValueSample:40
                                        withCopyable:NO
                            withBodyMetricIdentifier:BodyMetricIdentifierHip];
}

+ (BOOL) createDataForHip:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 38.1],
                     [NSNumber numberWithFloat: 38.1],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             @"",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                           [NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (BOOL) createMetadataForThighRight:(Measurable*)measurable {
  return [ModelFactory populateMetadataForBodyMetric:measurable
                                            withName:NSLocalizedString(@"thigh-right-metric-label", @"Thigh")
                                      withDefinition:NSLocalizedString(@"thigh-right-metric-description", @"")
                                            withTags:[NSArray arrayWithObjects:@"Right", nil]
                                          withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                          withVideos:nil
                        withMeasurableTypeIdentifier:BodyMetricTypeIdentifierBody
                                  withUnitIdentifier:UnitIdentifierInch
                             withMeasurableValueType:MeasurableValueTypeNumberWithDecimal
                             withMeasurableValueGoal:MeasurableValueGoalMore
                                     withValueSample:25
                                        withCopyable:NO
                            withBodyMetricIdentifier:BodyMetricIdentifierThighRight];
}

+ (BOOL) createDataForThighRight:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 25.8],
                     [NSNumber numberWithFloat: 24.5],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             @"",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                           [NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (BOOL) createMetadataForThighLeft:(Measurable*)measurable {
  return [ModelFactory populateMetadataForBodyMetric:measurable
                                            withName:NSLocalizedString(@"thigh-left-metric-label", @"Thigh")
                                      withDefinition:NSLocalizedString(@"thigh-left-metric-description", @"")
                                            withTags:[NSArray arrayWithObjects:@"Left", nil]
                                          withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                          withVideos:nil
                        withMeasurableTypeIdentifier:BodyMetricTypeIdentifierBody
                                  withUnitIdentifier:UnitIdentifierInch
                             withMeasurableValueType:MeasurableValueTypeNumberWithDecimal
                             withMeasurableValueGoal:MeasurableValueGoalMore
                                     withValueSample:25
                                        withCopyable:NO
                            withBodyMetricIdentifier:BodyMetricIdentifierThighLeft];
}

+ (BOOL) createDataForThighLeft:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 26.1],
                     [NSNumber numberWithFloat: 24.7],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             @"",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                           [NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (BOOL) createMetadataForCalfRight:(Measurable*)measurable {
  return [ModelFactory populateMetadataForBodyMetric:measurable
                                            withName:NSLocalizedString(@"calf-right-metric-label", @"Calf")
                                      withDefinition:NSLocalizedString(@"calf-right-metric-description", @"")
                                            withTags:[NSArray arrayWithObjects:@"Right", nil]
                                          withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                          withVideos:nil
                        withMeasurableTypeIdentifier:BodyMetricTypeIdentifierBody
                                  withUnitIdentifier:UnitIdentifierInch
                             withMeasurableValueType:MeasurableValueTypeNumberWithDecimal
                             withMeasurableValueGoal:MeasurableValueGoalMore
                                     withValueSample:12
                                        withCopyable:NO
                            withBodyMetricIdentifier:BodyMetricIdentifierCalfRight];
}

+ (BOOL) createDataForCalfRight:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 11.5],
                     [NSNumber numberWithFloat: 13.8],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             @"",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                           [NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (BOOL) createMetadataForCalfLeft:(Measurable*)measurable {
  return [ModelFactory populateMetadataForBodyMetric:measurable
                                            withName:NSLocalizedString(@"calf-left-metric-label", @"Calf")
                                      withDefinition:NSLocalizedString(@"calf-left-metric-description", @"")
                                            withTags:[NSArray arrayWithObjects:@"Left", nil]
                                          withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                          withVideos:nil
                        withMeasurableTypeIdentifier:BodyMetricTypeIdentifierBody
                                  withUnitIdentifier:UnitIdentifierInch
                             withMeasurableValueType:MeasurableValueTypeNumberWithDecimal
                             withMeasurableValueGoal:MeasurableValueGoalMore
                                     withValueSample:12
                                        withCopyable:NO
                            withBodyMetricIdentifier:BodyMetricIdentifierCalfLeft];
}

+ (BOOL) createDataForCalfLeft:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 12.2],
                     [NSNumber numberWithFloat: 13.9],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             @"",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                           [NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (BOOL) populateMetadataForBodyMetric:(Measurable*)measurable
                              withName:(NSString*) name
                        withDefinition:(NSString*) definition
                              withTags:(NSArray*) tagsText
                            withImages:(NSArray*) imagesName
                            withVideos:(NSArray*) videosName
          withMeasurableTypeIdentifier:(MeasurableTypeIdentifier) measurableTypeIdentifier
                    withUnitIdentifier:(UnitIdentifier) unitIdentifier
               withMeasurableValueType:(MeasurableValueType) measurableValueType
               withMeasurableValueGoal:(MeasurableValueGoal) measurableValueGoal
                       withValueSample:(float) valueSample
                          withCopyable:(BOOL) copyable
              withBodyMetricIdentifier: (BodyMetricIdentifier) bodyMetricIdentifier
{

  [ModelFactory populateMetadataForMeasurable:measurable
                                     withName:name
                               withDefinition:definition
                                     withTags:tagsText
                                   withImages:imagesName
                                   withVideos:videosName
                 withMeasurableTypeIdentifier:measurableTypeIdentifier
                           withUnitIdentifier:unitIdentifier
                      withMeasurableValueType:measurableValueType
                      withMeasurableValueGoal:measurableValueGoal
                              withValueSample:valueSample
                                 withCopyable:copyable];

  //Need to save to get the permanent object identifier
  if(![[PersistenceStore sharedInstance] save]) {
    return NO;
  }
  
  //Save reference
  [ModelHelper storeBodyMetricIdentifier:bodyMetricIdentifier forBodyMetric:measurable];
  
  return YES;
}
  

//////////////////////////////////////////////////////////////////////////
//EXERCISES
//////////////////////////////////////////////////////////////////////////
+ (BOOL) createAppExercisesForUserProfile: (UserProfile*) userProfile {
  
  //Run 200m
  Exercise* exercise = [ModelHelper newExercise];
  [userProfile addExercise:exercise];
  
  [self createMetadataForExercise1:exercise];
  [self createDataForExercise1:exercise];

  //Row 2000m
  exercise = [ModelHelper newExercise];
  [userProfile addExercise:exercise];
  
  [self createMetadataForExercise2:exercise];
  [self createDataForExercise2:exercise];

  //Deadlift - Max
  exercise = [ModelHelper newExercise];
  [userProfile addExercise:exercise];
  
  [self createMetadataForExercise3:exercise];
  [self createDataForExercise3:exercise];

  //Burpee - AMRAP
  exercise = [ModelHelper newExercise];
  [userProfile addExercise:exercise];
  
  [self createMetadataForExercise4:exercise];
  [self createDataForExercise4:exercise];

  //Thruster - Heavy
  exercise = [ModelHelper newExercise];
  [userProfile addExercise:exercise];
  
  [self createMetadataForExercise5:exercise];
  [self createDataForExercise5:exercise];

  //Pullup - Unbroken
  exercise = [ModelHelper newExercise];
  [userProfile addExercise:exercise];
  
  [self createMetadataForExercise6:exercise];
  [self createDataForExercise6:exercise];

  //Double Under - Unbroken
  exercise = [ModelHelper newExercise];
  [userProfile addExercise:exercise];
  
  [self createMetadataForExercise7:exercise];
  [self createDataForExercise7:exercise];

  //Save
  if(![[PersistenceStore sharedInstance] save]) {
    return NO;
  }
  
  return YES;
}

+ (void) createMetadataForExercise1:(Measurable*)measurable {
  
  ExerciseUnitValueDescriptor* unitValueDescriptor = [ModelHelper newExerciseUnitValueDescriptor];
  unitValueDescriptor.unit = [Unit unitForUnitIdentifier:UnitIdentifierMeter];
  unitValueDescriptor.value = [NSNumber numberWithInt:200];

  [ModelFactory populateMetadataForExercise:measurable
                                   withName:@"Run"
                             withDefinition:@"Move at a speed faster than a walk, never having both or all the feet on the ground at the same time."
                                   withTags:nil
                                 withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                 withVideos:nil
           withMeasurableCategoryIdentifier:MeasurableCategoryIdentifierExercise
               withMeasurableTypeIdentifier:ExerciseTypeIdentifierMotion
                         withUnitIdentifier:UnitIdentifierSecond
                    withMeasurableValueType:MeasurableValueTypeTime
                    withMeasurableValueGoal:MeasurableValueGoalLess
                            withValueSample:50
                               withCopyable:YES
                               withFavorite:YES
                                 withPRWall:NO
                   withUnitValueDescriptors:[NSArray arrayWithObjects:unitValueDescriptor, nil]];
}

+ (BOOL) createDataForExercise1:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 25],
                     [NSNumber numberWithFloat: 25],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             @"Comment 2",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                           [NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (void) createMetadataForExercise2:(Measurable*)measurable {
  
  ExerciseUnitValueDescriptor* unitValueDescriptor = [ModelHelper newExerciseUnitValueDescriptor];
  unitValueDescriptor.unit = [Unit unitForUnitIdentifier:UnitIdentifierMeter];
  unitValueDescriptor.value = [NSNumber numberWithInt:500];
  
  [ModelFactory populateMetadataForExercise:measurable
                                   withName:@"Row"
                             withDefinition:@"Rowing is an exercise whose purpose is to strengthen the muscles that draw the rower's arms toward the body."
                                   withTags:nil
                                 withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                 withVideos:nil
           withMeasurableCategoryIdentifier:MeasurableCategoryIdentifierExercise
               withMeasurableTypeIdentifier:ExerciseTypeIdentifierRow
                         withUnitIdentifier:UnitIdentifierSecond
                    withMeasurableValueType:MeasurableValueTypeTime
                    withMeasurableValueGoal:MeasurableValueGoalLess
                            withValueSample:480
                               withCopyable:YES
                               withFavorite:NO
                                 withPRWall:NO
                   withUnitValueDescriptors:[NSArray arrayWithObjects:unitValueDescriptor, nil]];
}

+ (BOOL) createDataForExercise2:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 500],
                     [NSNumber numberWithFloat: 450],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             @"Comment 2",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                           [NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (void) createMetadataForExercise3:(Measurable*)measurable {
  
  [ModelFactory populateMetadataForExercise:measurable
                                   withName:@"Deadlift"
                             withDefinition:@"The deadlift is an exercise where a loaded barbell is lifted off the ground bent over position."
                                   withTags:[NSArray arrayWithObject:@"Max"]
                                 withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                 withVideos:nil
           withMeasurableCategoryIdentifier:MeasurableCategoryIdentifierExercise
               withMeasurableTypeIdentifier:ExerciseTypeIdentifierLift
                         withUnitIdentifier:UnitIdentifierPound
                    withMeasurableValueType:MeasurableValueTypeNumberWithDecimal
                    withMeasurableValueGoal:MeasurableValueGoalMore
                            withValueSample:250
                               withCopyable:YES
                               withFavorite:NO
                                 withPRWall:YES
                   withUnitValueDescriptors:nil];
}

+ (BOOL) createDataForExercise3:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 300],
                     [NSNumber numberWithFloat: 295],
                     [NSNumber numberWithFloat: 275],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             @"Comment 2",
                             @"Comment 3",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                           [NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil],
                           [NSArray array],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (void) createMetadataForExercise4:(Measurable*)measurable {
  
  ExerciseUnitValueDescriptor* unitValueDescriptor = [ModelHelper newExerciseUnitValueDescriptor];
  unitValueDescriptor.unit = [Unit unitForUnitIdentifier:UnitIdentifierSecond];
  unitValueDescriptor.value = [NSNumber numberWithInt:60];

  [ModelFactory populateMetadataForExercise:measurable
                                   withName:@"Burpee"
                             withDefinition:@"Start standing, bend down, plant your hands, kick back into a plank position, do a push-up and jump up again."
                                   withTags:[NSArray arrayWithObject:@"AMRAP"]
                                 withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                 withVideos:nil
           withMeasurableCategoryIdentifier:MeasurableCategoryIdentifierExercise
               withMeasurableTypeIdentifier:ExerciseTypeIdentifierBody
                         withUnitIdentifier:UnitIdentifierNone
                    withMeasurableValueType:MeasurableValueTypeNumber
                    withMeasurableValueGoal:MeasurableValueGoalMore
                            withValueSample:20
                               withCopyable:YES
                               withFavorite:NO
                                 withPRWall:YES
                   withUnitValueDescriptors:[NSArray arrayWithObjects:unitValueDescriptor, nil]];
}

+ (BOOL) createDataForExercise4:(Measurable*)measurable {
  
  NSArray* values = nil;
  
  NSArray* valuesComments = nil;
  
  NSArray* valuesImages = nil;
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (void) createMetadataForExercise5:(Measurable*)measurable {
  
  [ModelFactory populateMetadataForExercise:measurable
                                   withName:@"Thruster"
                             withDefinition:@"One of CrossFit’s most deceptively tiring movements, a thruster is a front squat straight into a push press."
                                   withTags:[NSArray arrayWithObject:@"Heavy"]
                                 withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                 withVideos:nil
           withMeasurableCategoryIdentifier:MeasurableCategoryIdentifierExercise
               withMeasurableTypeIdentifier:ExerciseTypeIdentifierLift
                         withUnitIdentifier:UnitIdentifierPound
                    withMeasurableValueType:MeasurableValueTypeNumberWithDecimal
                    withMeasurableValueGoal:MeasurableValueGoalMore
                            withValueSample:115
                               withCopyable:YES
                               withFavorite:NO
                                 withPRWall:YES
                   withUnitValueDescriptors:nil];
}

+ (BOOL) createDataForExercise5:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 185],
                     [NSNumber numberWithFloat: 170],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             @"Comment 2",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                           [NSArray array],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (void) createMetadataForExercise6:(Measurable*)measurable {
  
  [ModelFactory populateMetadataForExercise:measurable
                                   withName:@"Pullup"
                             withDefinition:@"A pull-up is an exercise where the body is suspended by extended arms, gripping a fixed bar, then pulled up."
                                   withTags:[NSArray arrayWithObject:@"Unbroken"]
                                 withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                 withVideos:nil
           withMeasurableCategoryIdentifier:MeasurableCategoryIdentifierExercise
               withMeasurableTypeIdentifier:ExerciseTypeIdentifierBar
                         withUnitIdentifier:UnitIdentifierNone
                    withMeasurableValueType:MeasurableValueTypeNumber
                    withMeasurableValueGoal:MeasurableValueGoalMore
                            withValueSample:10
                               withCopyable:YES
                               withFavorite:NO
                                 withPRWall:YES
                   withUnitValueDescriptors:nil];
}

+ (BOOL) createDataForExercise6:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 25],
                     [NSNumber numberWithFloat: 19],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"Comment 1",
                             @"",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"prwall-screen-button", nil],
                           [NSArray array],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (void) createMetadataForExercise7:(Measurable*)measurable {
  
  [ModelFactory populateMetadataForExercise:measurable
                                   withName:@"Double Under"
                             withDefinition:@"A double under is when a jump rope passes under an athlete’s feet twice with only one jump."
                                   withTags:[NSArray arrayWithObject:@"Unbroken"]
                                 withImages:[NSArray arrayWithObjects:@"prwall-screen-button", @"workout-screen-button", nil]
                                 withVideos:nil
           withMeasurableCategoryIdentifier:MeasurableCategoryIdentifierExercise
               withMeasurableTypeIdentifier:ExerciseTypeIdentifierRope
                         withUnitIdentifier:UnitIdentifierNone
                    withMeasurableValueType:MeasurableValueTypeNumber
                    withMeasurableValueGoal:MeasurableValueGoalMore
                            withValueSample:10
                               withCopyable:YES
                               withFavorite:YES
                                 withPRWall:NO
                   withUnitValueDescriptors:nil];
}

+ (BOOL) createDataForExercise7:(Measurable*)measurable {
  
  NSArray* values = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat: 25],
                     nil];
  
  NSArray* valuesComments = [NSArray arrayWithObjects:
                             @"",
                             nil];
  
  NSArray* valuesImages = [NSArray arrayWithObjects:
                           [NSArray array],
                           nil];
  
  return [ModelFactory populateMeasurable:measurable withValues: values withValueComments: valuesComments withValueImages: valuesImages withValueVideos:nil];
}

+ (void) populateMetadataForActivity:(Measurable*)measurable
                              withName:(NSString*) name
                        withDefinition:(NSString*) definition
                              withTags:(NSArray*) tagsText
                            withImages:(NSArray*) imagesName
                            withVideos:(NSArray*) videosName
          withMeasurableTypeIdentifier:(MeasurableTypeIdentifier) measurableTypeIdentifier
                    withUnitIdentifier:(UnitIdentifier) unitIdentifier
               withMeasurableValueType:(MeasurableValueType) measurableValueType
               withMeasurableValueGoal:(MeasurableValueGoal) measurableValueGoal
                       withValueSample:(float) valueSample
                          withCopyable:(BOOL) copyable
                        withFavorite:(BOOL) favorite
                          withPRWall:(BOOL) prWall
{

  [ModelFactory populateMetadataForMeasurable:measurable
                                     withName:name
                               withDefinition:definition
                                     withTags:tagsText
                                   withImages:imagesName
                                   withVideos:videosName
                 withMeasurableTypeIdentifier:measurableTypeIdentifier
                           withUnitIdentifier:unitIdentifier
                      withMeasurableValueType:measurableValueType
                      withMeasurableValueGoal:measurableValueGoal
                              withValueSample:valueSample
                                 withCopyable:copyable];
  
  ActivityMetadata* activityMetadata = (ActivityMetadata*)measurable.metadata;
  activityMetadata.prWall = prWall;
  activityMetadata.favorite = favorite;
}


+ (void) populateMetadataForExercise:(Measurable*)measurable
                            withName:(NSString*) name
                      withDefinition:(NSString*) definition
                            withTags:(NSArray*) tagsText
                          withImages:(NSArray*) imagesName
                          withVideos:(NSArray*) videosName
    withMeasurableCategoryIdentifier:(MeasurableCategoryIdentifier) measurableCategoryIdentifier
        withMeasurableTypeIdentifier:(MeasurableTypeIdentifier) measurableTypeIdentifier
                  withUnitIdentifier:(UnitIdentifier) unitIdentifier
             withMeasurableValueType:(MeasurableValueType) measurableValueType
             withMeasurableValueGoal:(MeasurableValueGoal) measurableValueGoal
                     withValueSample:(float) valueSample
                        withCopyable:(BOOL) copyable
                        withFavorite:(BOOL) favorite
                          withPRWall:(BOOL) prWall
            withUnitValueDescriptors:(NSArray*) unitValueDescriptors
{
  
  [ModelFactory populateMetadataForActivity:measurable
                                     withName:name
                               withDefinition:definition
                                     withTags:tagsText
                                   withImages:imagesName
                                   withVideos:videosName
                 withMeasurableTypeIdentifier:measurableTypeIdentifier
                           withUnitIdentifier:unitIdentifier
                      withMeasurableValueType:measurableValueType
                      withMeasurableValueGoal:measurableValueGoal
                              withValueSample:valueSample
                                 withCopyable:copyable
                               withFavorite:favorite
                                 withPRWall:prWall];
  
  ExerciseMetadata* exerciseMetadata = (ExerciseMetadata*)measurable.metadata;
  
  for (ExerciseUnitValueDescriptor* unitValueDescriptor in unitValueDescriptors) {
    
    //Convert here because the unit is not setup when this method is first called
    unitValueDescriptor.value = [unitValueDescriptor.unit.unitSystemConverter convertToSystemValue:unitValueDescriptor.value];
    [exerciseMetadata addUnitValueDescriptor:unitValueDescriptor];
  }
}

@end
