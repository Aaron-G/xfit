//
//  UnitMO.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/10/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MeasurableMetadataMO;

@interface UnitMO : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSSet *measurableMetadata;
@end

@interface UnitMO (CoreDataGeneratedAccessors)

- (void)addMeasurableMetadataObject:(MeasurableMetadataMO *)value;
- (void)removeMeasurableMetadataObject:(MeasurableMetadataMO *)value;
- (void)addMeasurableMetadata:(NSSet *)values;
- (void)removeMeasurableMetadata:(NSSet *)values;

@end
