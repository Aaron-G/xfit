//
//  MeasurableActivityMetadataMO.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/10/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MeasurableMetadataMO.h"

@class TagMO;

@interface MeasurableActivityMetadataMO : MeasurableMetadataMO

@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) NSNumber * prWall;
@property (nonatomic, retain) NSSet *tags;
@end

@interface MeasurableActivityMetadataMO (CoreDataGeneratedAccessors)

- (void)addTagsObject:(TagMO *)value;
- (void)removeTagsObject:(TagMO *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;

@end
