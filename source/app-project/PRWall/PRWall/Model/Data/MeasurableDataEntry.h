//
//  MeasurableDataEntry.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/26/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Measurable.h"
#import "MeasurableData.h"
#import "MeasurableDataEntryImage.h"
#import "MeasurableDataEntryVideo.h"

@class MeasurableData;
@class MeasurableDataEntryImage;
@class MeasurableDataEntryVideo;

@interface MeasurableDataEntry : NSManagedObject

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////
//Attributes
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * comment;

//Relationships
@property (nonatomic, retain) MeasurableData * measurableData;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////
@property NSNumber * value;
@property (nonatomic, retain) NSDecimalNumber * valueImpl;

@property (readonly) NSArray * images;
@property (nonatomic, retain) NSSet * imagesImpl;

@property (readonly) NSArray * videos;
@property (nonatomic, retain) NSSet * videosImpl;

/////////////////////////////////////////////////////////
//Computed Properties
/////////////////////////////////////////////////////////
@property MeasurableValueTrend valueTrend;

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////
- (BOOL) hasAdditionalInfo;

- (void) addVideo:(MeasurableDataEntryVideo*) video;
- (void) addImage:(MeasurableDataEntryImage*) image;
- (void) imageIndexUpdated;

- (void) removeVideo:(MeasurableDataEntryVideo*) video;
- (void) removeImage:(MeasurableDataEntryImage*) image;
- (void) videoIndexUpdated;

@end
