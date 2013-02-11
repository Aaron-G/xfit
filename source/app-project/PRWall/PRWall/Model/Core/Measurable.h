//
//  Measurable.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/9/12.
//
//

//////////////////////////////////////////////////////
//IMPL NOTE
//////////////////////////////////////////////////////
//Need to be defined prior to imports below otherwise
//compiler will complain about the dependency between
//this interface and MeasurableData and
//MeasurableMetadata.

typedef enum {
  MeasurableValueTrendUp,
  MeasurableValueTrendSame,
  MeasurableValueTrendDown,
  MeasurableValueTrendNone
} MeasurableValueTrend;

typedef enum {
  MeasurableValueGoalNone,
  MeasurableValueGoalMore,
  MeasurableValueGoalLess
} MeasurableValueGoal;

typedef enum {
  MeasurableValueTypeNumber,
  MeasurableValueTypeNumberWithDecimal,
  MeasurableValueTypePercent,
  MeasurableValueTypeTime
} MeasurableValueType;

typedef enum {
  MeasurableSourceApp,
  MeasurableSourceUser,
  MeasurableSourceFeed
} MeasurableSource;

//////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Unit.h"
#import "MeasurableData.h"
#import "MeasurableMetadata.h"
#import "UserProfile.h"

@class MeasurableData;
@class MeasurableMetadata;
@class UserProfile;

@interface Measurable : NSManagedObject <NSCopying>

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////

//Relationships
@property (nonatomic, retain) MeasurableData* data;
@property (nonatomic, retain) MeasurableMetadata* metadata;
@property (nonatomic, retain) UserProfile* userProfile;

/////////////////////////////////////////////////////////
//Subclass
/////////////////////////////////////////////////////////

- (Measurable*) newInstance;

@end
