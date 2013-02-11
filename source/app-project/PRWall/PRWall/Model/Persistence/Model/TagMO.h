//
//  TagMO.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/10/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MeasurableActivityMetadataMO;

@interface TagMO : NSManagedObject

@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSSet *measurableActivityMetadata;
@end

@interface TagMO (CoreDataGeneratedAccessors)

- (void)addMeasurableActivityMetadataObject:(MeasurableActivityMetadataMO *)value;
- (void)removeMeasurableActivityMetadataObject:(MeasurableActivityMetadataMO *)value;
- (void)addMeasurableActivityMetadata:(NSSet *)values;
- (void)removeMeasurableActivityMetadata:(NSSet *)values;

@end
