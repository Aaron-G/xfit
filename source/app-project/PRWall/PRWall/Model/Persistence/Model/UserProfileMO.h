//
//  UserProfileMO.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/10/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MeasurableMO;

@interface UserProfileMO : NSManagedObject

@property (nonatomic, retain) NSString * box;
@property (nonatomic, retain) NSDate * dateOfBirth;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * primary;
@property (nonatomic, retain) NSNumber * sex;
@property (nonatomic, retain) NSSet *bodyMetrics;
@property (nonatomic, retain) NSSet *exercises;
@property (nonatomic, retain) NSSet *workouts;
@end

@interface UserProfileMO (CoreDataGeneratedAccessors)

- (void)addBodyMetricsObject:(MeasurableMO *)value;
- (void)removeBodyMetricsObject:(MeasurableMO *)value;
- (void)addBodyMetrics:(NSSet *)values;
- (void)removeBodyMetrics:(NSSet *)values;

- (void)addExercisesObject:(MeasurableMO *)value;
- (void)removeExercisesObject:(MeasurableMO *)value;
- (void)addExercises:(NSSet *)values;
- (void)removeExercises:(NSSet *)values;

- (void)addWorkoutsObject:(MeasurableMO *)value;
- (void)removeWorkoutsObject:(MeasurableMO *)value;
- (void)addWorkouts:(NSSet *)values;
- (void)removeWorkouts:(NSSet *)values;

@end
