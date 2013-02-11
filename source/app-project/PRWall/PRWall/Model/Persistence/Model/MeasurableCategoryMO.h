//
//  MeasurableCategoryMO.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/10/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MeasurableMetadataMO, MeasurableTypeMO;

@interface MeasurableCategoryMO : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * namePlural;
@property (nonatomic, retain) NSSet *measurableMetadata;
@property (nonatomic, retain) NSSet *measurableType;
@end

@interface MeasurableCategoryMO (CoreDataGeneratedAccessors)

- (void)addMeasurableMetadataObject:(MeasurableMetadataMO *)value;
- (void)removeMeasurableMetadataObject:(MeasurableMetadataMO *)value;
- (void)addMeasurableMetadata:(NSSet *)values;
- (void)removeMeasurableMetadata:(NSSet *)values;

- (void)addMeasurableTypeObject:(MeasurableTypeMO *)value;
- (void)removeMeasurableTypeObject:(MeasurableTypeMO *)value;
- (void)addMeasurableType:(NSSet *)values;
- (void)removeMeasurableType:(NSSet *)values;

@end
