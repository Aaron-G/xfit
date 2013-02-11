//
//  MeasurableDataValueMO.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/10/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MeasurableDataEntryMediaMO, MeasurableDataMO;

@interface MeasurableDataValueMO : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDecimalNumber * value;
@property (nonatomic, retain) NSOrderedSet *images;
@property (nonatomic, retain) MeasurableDataMO *measurableData;
@property (nonatomic, retain) NSOrderedSet *videos;
@end

@interface MeasurableDataValueMO (CoreDataGeneratedAccessors)

- (void)insertObject:(MeasurableDataEntryMediaMO *)value inImagesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromImagesAtIndex:(NSUInteger)idx;
- (void)insertImages:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeImagesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInImagesAtIndex:(NSUInteger)idx withObject:(MeasurableDataEntryMediaMO *)value;
- (void)replaceImagesAtIndexes:(NSIndexSet *)indexes withImages:(NSArray *)values;
- (void)addImagesObject:(MeasurableDataEntryMediaMO *)value;
- (void)removeImagesObject:(MeasurableDataEntryMediaMO *)value;
- (void)addImages:(NSOrderedSet *)values;
- (void)removeImages:(NSOrderedSet *)values;
- (void)insertObject:(MeasurableDataEntryMediaMO *)value inVideosAtIndex:(NSUInteger)idx;
- (void)removeObjectFromVideosAtIndex:(NSUInteger)idx;
- (void)insertVideos:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeVideosAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInVideosAtIndex:(NSUInteger)idx withObject:(MeasurableDataEntryMediaMO *)value;
- (void)replaceVideosAtIndexes:(NSIndexSet *)indexes withVideos:(NSArray *)values;
- (void)addVideosObject:(MeasurableDataEntryMediaMO *)value;
- (void)removeVideosObject:(MeasurableDataEntryMediaMO *)value;
- (void)addVideos:(NSOrderedSet *)values;
- (void)removeVideos:(NSOrderedSet *)values;
@end
