//
//  UserProfile.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import "UserProfile.h"

#import "Exercise.h"
#import "BodyMetric.h"
#import "Workout.h"
#import "MeasurableHelper.h"
#import "ModelHelper.h"

@interface UserProfile () {
}

@property BOOL needExercisesUpdate;
@property BOOL needBodyMetricsUpdate;
@property BOOL needWorkoutsUpdate;
@property BOOL needAgeUpdate;

@property BOOL needSetup;
@property BOOL needCleanup;

@end

@implementation UserProfile

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////
//Attributes
@dynamic box;
@dynamic dateOfBirth;
@dynamic image;
@dynamic name;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////

////////////////////////////////
//sex
////////////////////////////////
@dynamic sexImpl;

- (UserProfileSex)sex {
  [self willAccessValueForKey:@"sex"];
  NSNumber *tmpValue = [self sexImpl];
  [self didAccessValueForKey:@"sex"];
  return (tmpValue!=nil) ? [tmpValue intValue] : UserProfileSexNone;
}

- (void)setSex:(UserProfileSex)newSex {
  NSNumber* tmpValue = [[NSNumber alloc] initWithInt:newSex];
  [self willChangeValueForKey:@"sex"];
  [self setSexImpl:tmpValue];
  [self didChangeValueForKey:@"sex"];
}

////////////////////////////////
//primary
////////////////////////////////
@dynamic primaryImpl;

- (BOOL)primary {
  [self willAccessValueForKey:@"primary"];
  NSNumber *tmpValue = [self primaryImpl];
  [self didAccessValueForKey:@"primary"];
  return (tmpValue!=nil) ? [tmpValue boolValue] : YES;
}

- (void)setPrimary:(BOOL)primary {
  NSNumber* tmpValue = [[NSNumber alloc] initWithBool:primary];
  [self willChangeValueForKey:@"primary"];
  [self setPrimaryImpl:tmpValue];
  [self didChangeValueForKey:@"primary"];  
}

////////////////////////////////
//exercises
////////////////////////////////
@dynamic exercisesImpl;
@synthesize exercises = _exercises;
@synthesize needExercisesUpdate;

- (NSArray *)exercises {
  [self willAccessValueForKey:@"exercises"];
  
  if(self.needExercisesUpdate) {
    _exercises = [MeasurableHelper arrayUnsorted:self.exercisesImpl];
    self.needExercisesUpdate = NO;
  }
  
  NSArray* tmpValue = _exercises;
  
  [self didAccessValueForKey:@"exercises"];
  return tmpValue;
}

////////////////////////////////
//workouts
////////////////////////////////
@dynamic workoutsImpl;
@synthesize workouts = _workouts;
@synthesize needWorkoutsUpdate;

- (NSArray *)workouts {
  [self willAccessValueForKey:@"workouts"];
  
  if(self.needWorkoutsUpdate) {
    _workouts = [MeasurableHelper arrayUnsorted:self.workoutsImpl];
    self.needWorkoutsUpdate = NO;
  }
  
  NSArray* tmpValue = _workouts;
  
  [self didAccessValueForKey:@"workouts"];
  return tmpValue;
}

////////////////////////////////
//bodyMetrics
////////////////////////////////
@dynamic bodyMetricsImpl;
@synthesize bodyMetrics = _bodyMetrics;
@synthesize needBodyMetricsUpdate;

- (NSArray *)bodyMetrics {
  [self willAccessValueForKey:@"bodyMetrics"];
  
  if(self.needBodyMetricsUpdate) {
    _bodyMetrics = [MeasurableHelper arrayUnsorted:self.bodyMetricsImpl];
    self.needBodyMetricsUpdate = NO;
  }
  
  NSArray* tmpValue = _bodyMetrics;
  
  [self didAccessValueForKey:@"bodyMetrics"];
  return tmpValue;
}

/////////////////////////////////////////////////////////
//Computed Properties
/////////////////////////////////////////////////////////
@synthesize age = _age;
@synthesize needAgeUpdate;

- (NSString *)age {

  if(self.needAgeUpdate) {
    
    NSDateComponents* dataOfBirhtComponents =
    [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self.dateOfBirth];
    
    NSDateComponents *nowComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    
    _age = [NSString stringWithFormat:@"%d", nowComponents.year-dataOfBirhtComponents.year];
    
    self.needAgeUpdate = NO;
  }
  
  return _age;
}

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////

- (void) addExercise:(Exercise*) exercise {
  exercise.userProfile = self;
}

- (void) addWorkout:(Workout*) workout {
  workout.userProfile = self;
}

- (void) addBodyMetric:(BodyMetric*) bodyMetric {
  bodyMetric.userProfile = self;
}

- (void) removeExercise:(Exercise*) exercise {
  if([exercise.userProfile isEqual: self]) {
    exercise.userProfile = nil;
    [ModelHelper deleteModelObject:exercise andSave:NO];
  }
}
- (void) removeWorkout:(Workout*) workout {
  if([workout.userProfile isEqual: self]) {
    workout.userProfile = nil;
    [ModelHelper deleteModelObject:workout andSave:NO];
  }
}
- (void) removeBodyMetric:(BodyMetric*) bodyMetric {
  if([bodyMetric.userProfile isEqual: self]) {
    bodyMetric.userProfile = nil;
    [ModelHelper deleteModelObject:bodyMetric andSave:NO];
  }
}

/////////////////////////////////////////////////////////
//Core Data
/////////////////////////////////////////////////////////

@synthesize needSetup;
@synthesize needCleanup;

- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context {
  self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
  
  if (self) {
    self.needSetup = YES;
    [self setup];
  }
  return self;
}

- (void)awakeFromFetch {
  [super awakeFromFetch];
  [self setup];
}

- (void)awakeFromInsert {
  [super awakeFromInsert];
  [self setup];
}

- (void)prepareForDeletion {
  [self cleanup];
  
  [super prepareForDeletion];
}

- (void)didTurnIntoFault {
  [self cleanup];
  [super didTurnIntoFault];
}

- (void) setup {
  
  if(self.needSetup) {
    
    //NSLog(@"UserProfile - addObserver - %@", [self.objectID URIRepresentation].absoluteString);
    [self addObserver:self forKeyPath:@"exercisesImpl" options: 0 context: NULL];
    [self addObserver:self forKeyPath:@"workoutsImpl" options: 0 context: NULL];
    [self addObserver:self forKeyPath:@"bodyMetricsImpl" options: 0 context: NULL];
    self.needExercisesUpdate = YES;
    self.needWorkoutsUpdate = YES;
    self.needBodyMetricsUpdate = YES;
    
    [self addObserver:self forKeyPath:@"dateOfBirth" options: 0 context: NULL];
    self.needAgeUpdate = YES;
    
    self.needSetup = NO;
    self.needCleanup = YES;
  }
}

- (void) cleanup {
  
  if(self.needCleanup) {
    
    //NSLog(@"UserProfile - cleanup - %@", [self.objectID URIRepresentation].absoluteString);
    [self removeObserver:self forKeyPath:@"exercisesImpl"];
    [self removeObserver:self forKeyPath:@"workoutsImpl"];
    [self removeObserver:self forKeyPath:@"bodyMetricsImpl"];
    [self removeObserver:self forKeyPath:@"dateOfbirth"];
    
    self.needCleanup = NO;
    self.needSetup = YES;
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  
  if([@"exercisesImpl" isEqualToString:keyPath]) {
//    NSLog(@"UserProfile - observeValueForKeyPath - exercises");
    self.needExercisesUpdate = YES;
  } else if([@"workoutsImpl" isEqualToString:keyPath]) {
//    NSLog(@"UserProfile - observeValueForKeyPath - workouts");
    self.needWorkoutsUpdate = YES;
  } else if([@"bodyMetricsImpl" isEqualToString:keyPath]) {
//    NSLog(@"UserProfile - observeValueForKeyPath - bodyMetrics");
    self.needBodyMetricsUpdate = YES;
  } else if([@"dateOfBirth" isEqualToString:keyPath]) {
//    NSLog(@"UserProfile - observeValueForKeyPath - dateOfBirth");
    self.needAgeUpdate = YES;
  }
}

@end
