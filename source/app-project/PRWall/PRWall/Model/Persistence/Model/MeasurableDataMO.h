//
//  MeasurableDataMO.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/10/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MeasurableDataValueMO, MeasurableMO;

@interface MeasurableDataMO : NSManagedObject

@property (nonatomic, retain) MeasurableMO *measurable;
@property (nonatomic, retain) NSSet *values;
@end

@interface MeasurableDataMO (CoreDataGeneratedAccessors)

- (void)addValuesObject:(MeasurableDataValueMO *)value;
- (void)removeValuesObject:(MeasurableDataValueMO *)value;
- (void)addValues:(NSSet *)values;
- (void)removeValues:(NSSet *)values;

@end
