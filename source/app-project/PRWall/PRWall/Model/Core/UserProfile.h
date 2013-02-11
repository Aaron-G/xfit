//
//  UserProfile.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exercise;
@class BodyMetric;
@class Workout;

@interface UserProfile : NSManagedObject

typedef enum {
  UserProfileSexNone,
  UserProfileSexMale,
  UserProfileSexFemale,
} UserProfileSex;

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////
//Attributes
@property (nonatomic, retain) NSString * box;
@property (nonatomic, retain) NSDate * dateOfBirth;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * name;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////
@property UserProfileSex sex;
@property (nonatomic, retain) NSNumber * sexImpl;

@property BOOL primary;
@property (nonatomic, retain) NSNumber * primaryImpl;

@property (readonly) NSArray * bodyMetrics;
@property (nonatomic, retain) NSSet * bodyMetricsImpl;

@property (readonly) NSArray * exercises;
@property (nonatomic, retain) NSSet * exercisesImpl;

@property (readonly) NSArray * workouts;
@property (nonatomic, retain) NSSet * workoutsImpl;

/////////////////////////////////////////////////////////
//Computed Properties
/////////////////////////////////////////////////////////
@property (readonly) NSString* age;

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////

- (void) addExercise:(Exercise*) exercise;
- (void) addWorkout:(Workout*) workout;
- (void) addBodyMetric:(BodyMetric*) bodyMetric;

- (void) removeExercise:(Exercise*) exercise;
- (void) removeWorkout:(Workout*) workout;
- (void) removeBodyMetric:(BodyMetric*) bodyMetric;

@end
