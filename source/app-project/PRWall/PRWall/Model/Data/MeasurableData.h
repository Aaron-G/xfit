//
//  MeasurableData.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Measurable.h"
#import "MeasurableDataEntry.h"

@class MeasurableDataEntry;

@interface MeasurableData : NSManagedObject

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////
//Relationships
@property (nonatomic, retain) NSSet *measurable;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////
@property (readonly) NSArray * values;
@property (nonatomic, retain) NSSet * valuesImpl;

/////////////////////////////////////////////////////////
//Computed Properties
/////////////////////////////////////////////////////////

//These refer to the first value entry
@property (readonly) NSNumber* value;
@property (readonly) NSDate* date;
@property (readonly) NSString* comment;
@property (readonly) MeasurableValueTrend valueTrend;

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////
- (void) addValue:(MeasurableDataEntry*) value;
- (void) removeValue:(MeasurableDataEntry*) value;
- (void) dataChanged;
- (void) metadataChanged;

@end
