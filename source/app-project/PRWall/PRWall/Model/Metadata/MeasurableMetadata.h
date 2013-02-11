//
//  MeasurableMetadata.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Measurable.h"
#import "MeasurableType.h"
#import "MeasurableCategory.h"
#import "MeasurableMetadataVideo.h"
#import "MeasurableMetadataImage.h"
#import "Tag.h"

@class Unit;
@class MeasurableType;
@class Tag;
@class MeasurableMetadataVideo;
@class MeasurableMetadataImage;

@interface MeasurableMetadata : NSManagedObject <NSCopying>

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////
//Attributes
@property (nonatomic, retain) NSString * definition;
@property (nonatomic, retain) NSString * name;

//Relationships
@property (nonatomic, retain) MeasurableCategory *category;
@property (nonatomic, retain) MeasurableType *type;
@property (nonatomic, retain) Unit *unit;
@property (nonatomic, retain) NSSet *measurables;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////
@property BOOL copyable;
@property (nonatomic, retain) NSNumber * copyableImpl;

@property MeasurableValueGoal valueGoal;
@property (nonatomic, retain) NSNumber * valueGoalImpl;

@property MeasurableValueType valueType;
@property (nonatomic, retain) NSNumber * valueTypeImpl;

@property NSNumber * valueSample;
@property (nonatomic, retain) NSDecimalNumber * valueSampleImpl;

@property MeasurableSource source;
@property (nonatomic, retain) NSNumber * sourceImpl;

@property (readonly) NSArray * images;
@property (nonatomic, retain) NSSet * imagesImpl;

@property (readonly) NSArray * videos;
@property (nonatomic, retain) NSSet * videosImpl;

@property (readonly) NSArray * tags;
@property (nonatomic, retain) NSSet * tagsImpl;

/////////////////////////////////////////////////////////
//Computed Properties
/////////////////////////////////////////////////////////
@property (readonly) NSString* metadataShort;
@property (readonly) NSString* metadataFull;

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////

- (void) addVideo:(MeasurableMetadataVideo*) video;
- (void) addImage:(MeasurableMetadataImage*) image;
- (void) addTag:(Tag*) tag;

- (void) removeVideo:(MeasurableMetadataVideo*) video;
- (void) removeImage:(MeasurableMetadataImage*) image;
- (void) removeTag:(Tag*) tag;

- (void) imageIndexUpdated;
- (void) videoIndexUpdated;

/////////////////////////////////////////////////////////
//Subclass
/////////////////////////////////////////////////////////
- (MeasurableMetadata*) newInstance;

@property BOOL needSetup;
@property BOOL needCleanup;

- (void) setup;
- (void) cleanup;

@end
