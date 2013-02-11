//
//  MeasurableDataEntry.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/26/12.
//
//

#import "MeasurableDataEntry.h"
#import "MeasurableHelper.h"
#import "ModelHelper.h"

@interface MeasurableDataEntry () {
}

@property BOOL needVideosUpdate;
@property BOOL needImagesUpdate;

@property BOOL needSetup;
@property BOOL needCleanup;

@end

@implementation MeasurableDataEntry

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////

//Attributes
@dynamic comment;
@dynamic date;

//Relationships
@dynamic measurableData;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////

////////////////////////////////
//value
////////////////////////////////
@dynamic valueImpl;

- (NSNumber *)value {
  [self willAccessValueForKey:@"value"];
  NSNumber *tmpValue = [self valueImpl];
  [self didAccessValueForKey:@"value"];
  return tmpValue;
}

- (void)setValue:(NSNumber *)value {
  NSDecimalNumber* tmpValue = [NSDecimalNumber decimalNumberWithDecimal:[value decimalValue]];
  [self willChangeValueForKey:@"value"];
  [self setValueImpl:tmpValue];
  [self didChangeValueForKey:@"value"];
}

////////////////////////////////
//videos
////////////////////////////////
@dynamic videosImpl;
@synthesize videos = _videos;
@synthesize needVideosUpdate;

- (NSArray *)videos {
  
  [self willAccessValueForKey:@"videos"];
  
  if(self.needVideosUpdate) {
    _videos = [MeasurableHelper arraySortedByIndex:self.videosImpl];
    self.needVideosUpdate = NO;
  }
  
  NSArray* tmpValue = _videos;
  
  [self didAccessValueForKey:@"videos"];
  return tmpValue;
}

////////////////////////////////
//images
////////////////////////////////
@dynamic imagesImpl;
@synthesize images = _images;
@synthesize needImagesUpdate;

- (NSArray *)images {
  [self willAccessValueForKey:@"images"];
  
  if(self.needImagesUpdate) {
    _images = [MeasurableHelper arraySortedByIndex:self.imagesImpl];
    self.needImagesUpdate = NO;
  }
  
  NSArray* tmpValue = _images;
  
  [self didAccessValueForKey:@"images"];
  return tmpValue;
}

/////////////////////////////////////////////////////////
//Computed Properties
/////////////////////////////////////////////////////////

//Computed by MeasurableData
@synthesize valueTrend;

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////

- (BOOL)hasAdditionalInfo {  
  return (self.comment.length || self.images.count > 0 || self.videos.count > 0);
}

- (void)addImage:(MeasurableDataEntryImage *)image {
  image.measurableDataEntry = self;
}

- (void)addVideo:(MeasurableDataEntryVideo *)video {
  video.measurableDataEntry = self;
}

- (void) removeImage:(MeasurableDataEntryImage *)image {
  if([image.measurableDataEntry isEqual: self]) {
    
    image.measurableDataEntry = nil;
    [ModelHelper deleteModelObject:image andSave:NO];
    
    //CXB TODO
    //Probably remove the image from disk
  }
}

- (void) removeVideo:(MeasurableDataEntryVideo *)video {
  if([video.measurableDataEntry isEqual: self]) {
    
    video.measurableDataEntry = nil;
    [ModelHelper deleteModelObject:video andSave:NO];
    
    //CXB TODO
    //Probably remove the video from disk
  }
}

- (void)imageIndexUpdated {
  self.needImagesUpdate = YES;
}

- (void)videoIndexUpdated {
  self.needVideosUpdate = YES;
}

/////////////////////////////////////////////////////////
//Core Data
/////////////////////////////////////////////////////////

@synthesize needSetup;
@synthesize needCleanup;

- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context {
  self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
  
  if (self) {
    self.needSetup = YES;
    [self setup];
  }
  return self;
}

- (void)awakeFromFetch {
  [super awakeFromFetch];
  [self setup];
}

- (void)awakeFromInsert {
  [super awakeFromInsert];
  [self setup];
}

- (void)prepareForDeletion {
  [self cleanup];
  
  [super prepareForDeletion];
}

- (void)didTurnIntoFault {
  [self cleanup];
  [super didTurnIntoFault];
}

- (void) setup {

  if(self.needSetup) {
    
    //NSLog(@"MeasurableDataEntry - addObserver - %@", [self.objectID URIRepresentation].absoluteString);
    [self addObserver:self forKeyPath:@"imagesImpl" options: 0 context: NULL];
    [self addObserver:self forKeyPath:@"videosImpl" options: 0 context: NULL];
    self.needImagesUpdate = YES;
    self.needVideosUpdate = YES;

    [self addObserver:self forKeyPath:@"value" options: 0 context: NULL];
    [self addObserver:self forKeyPath:@"date" options: 0 context: NULL];

    self.needSetup = NO;
    self.needCleanup = YES;
  }
}

- (void) cleanup {
  
  if(self.needCleanup) {
    
    //NSLog(@"MeasurableDataEntry - cleanup - %@", [self.objectID URIRepresentation].absoluteString);
    [self removeObserver:self forKeyPath:@"imagesImpl"];
    [self removeObserver:self forKeyPath:@"videosImpl"];

    [self removeObserver:self forKeyPath:@"value"];
    [self removeObserver:self forKeyPath:@"date"];

    self.needCleanup = NO;
    self.needSetup = YES;
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  
  if([@"imagesImpl" isEqualToString:keyPath]) {
    //    NSLog(@"MeasurableDataEntry - observeValueForKeyPath - images");
    self.needImagesUpdate = YES;
  } else if([@"videosImpl" isEqualToString:keyPath]) {
    //    NSLog(@"MeasurableDataEntry - observeValueForKeyPath - videos");
    self.needVideosUpdate = YES;
  } else if([@"value" isEqualToString:keyPath] || [@"date" isEqualToString:keyPath]) {
    //    NSLog(@"MeasurableDataEntry - observeValueForKeyPath - value or date");
    
    //Let the MeasurableData know that the value changed
    [self.measurableData dataChanged];
  }
}


@end
