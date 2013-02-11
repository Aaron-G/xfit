//
//  MeasurableMetadataMO.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/10/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MeasurableCategoryMO, MeasurableMO, MeasurableMetadataMediaMO, MeasurableTypeMO, UnitMO;

@interface MeasurableMetadataMO : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSNumber * copyable;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * source;
@property (nonatomic, retain) NSNumber * valueGoal;
@property (nonatomic, retain) NSDecimalNumber * valueSample;
@property (nonatomic, retain) NSNumber * valueType;
@property (nonatomic, retain) MeasurableCategoryMO *category;
@property (nonatomic, retain) NSSet *images;
@property (nonatomic, retain) NSSet *measurable;
@property (nonatomic, retain) MeasurableTypeMO *type;
@property (nonatomic, retain) UnitMO *unit;
@property (nonatomic, retain) NSSet *videos;
@end

@interface MeasurableMetadataMO (CoreDataGeneratedAccessors)

- (void)addImagesObject:(MeasurableMetadataMediaMO *)value;
- (void)removeImagesObject:(MeasurableMetadataMediaMO *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

- (void)addMeasurableObject:(MeasurableMO *)value;
- (void)removeMeasurableObject:(MeasurableMO *)value;
- (void)addMeasurable:(NSSet *)values;
- (void)removeMeasurable:(NSSet *)values;

- (void)addVideosObject:(MeasurableMetadataMediaMO *)value;
- (void)removeVideosObject:(MeasurableMetadataMediaMO *)value;
- (void)addVideos:(NSSet *)values;
- (void)removeVideos:(NSSet *)values;

@end
