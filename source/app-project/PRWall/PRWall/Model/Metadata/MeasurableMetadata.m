//
//  MeasurableMetadata.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import "MeasurableMetadata.h"
#import "MeasurableHelper.h"
#import "ModelHelper.h"

@interface MeasurableMetadata () {
}

@property BOOL needVideosUpdate;
@property BOOL needImagesUpdate;
@property BOOL needTagsUpdate;

@end

@implementation MeasurableMetadata

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////

//Attributes
@dynamic definition;
@dynamic name;

//Relationships
@dynamic category;
@dynamic type;
@dynamic unit;
@dynamic measurables;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////

////////////////////////////////
//copyable
////////////////////////////////
@dynamic copyableImpl;

- (BOOL)copyable {
  [self willAccessValueForKey:@"copyable"];
  NSNumber *tmpValue = [self copyableImpl];
  [self didAccessValueForKey:@"copyable"];
  return (tmpValue!=nil) ? [tmpValue boolValue] : NO;
}

- (void)setCopyable:(BOOL)copyable {
  NSNumber* tmpValue = [[NSNumber alloc] initWithBool:copyable];
  [self willChangeValueForKey:@"copyable"];
  [self setCopyableImpl:tmpValue];
  [self didChangeValueForKey:@"copyable"];
}

////////////////////////////////
//valueGoal
////////////////////////////////
@dynamic valueGoalImpl;

-(MeasurableValueGoal)valueGoal {
  [self willAccessValueForKey:@"valueGoal"];
  NSNumber *tmpValue = [self valueGoalImpl];
  [self didAccessValueForKey:@"valueGoal"];
  return (tmpValue!=nil) ? [tmpValue intValue] : MeasurableValueGoalNone;
}

-(void)setValueGoal:(MeasurableValueGoal)valueGoal {
  NSNumber* tmpValue = [[NSNumber alloc] initWithInt:valueGoal];
  [self willChangeValueForKey:@"valueGoal"];
  [self setValueGoalImpl:tmpValue];
  [self didChangeValueForKey:@"valueGoal"];
}

////////////////////////////////
//valueType
////////////////////////////////
@dynamic valueTypeImpl;

- (MeasurableValueType)valueType {
  [self willAccessValueForKey:@"valueType"];
  NSNumber *tmpValue = [self valueTypeImpl];
  [self didAccessValueForKey:@"valueType"];
  return (tmpValue!=nil) ? [tmpValue intValue] : MeasurableValueTypeNumber;
}

- (void)setValueType:(MeasurableValueType)valueType {
  NSNumber* tmpValue = [[NSNumber alloc] initWithInt:valueType];
  [self willChangeValueForKey:@"valueType"];
  [self setValueTypeImpl:tmpValue];
  [self didChangeValueForKey:@"valueType"];
}

////////////////////////////////
//valueSample
////////////////////////////////
@dynamic valueSampleImpl;

- (NSNumber *)valueSample {
  [self willAccessValueForKey:@"valueSample"];
  NSNumber *tmpValue = [self valueSampleImpl];
  [self didAccessValueForKey:@"valueSample"];
  return tmpValue;
}
- (void)setValueSample:(NSNumber *)valueSample {
  NSDecimalNumber* tmpValue = [NSDecimalNumber decimalNumberWithDecimal:[valueSample decimalValue]];
  [self willChangeValueForKey:@"valueSample"];
  [self setValueSampleImpl:tmpValue];
  [self didChangeValueForKey:@"valueSample"];
}

////////////////////////////////
//source
////////////////////////////////
@dynamic sourceImpl;

- (MeasurableSource)source {
  [self willAccessValueForKey:@"source"];
  NSNumber *tmpValue = [self sourceImpl];
  [self didAccessValueForKey:@"source"];
  return (tmpValue!=nil) ? [tmpValue intValue] : MeasurableSourceUser;
}

- (void)setSource:(MeasurableSource)source {
  NSNumber* tmpValue = [[NSNumber alloc] initWithInt:source];
  [self willChangeValueForKey:@"source"];
  [self setSourceImpl:tmpValue];
  [self didChangeValueForKey:@"source"];
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

////////////////////////////////
//tags
////////////////////////////////
@dynamic tagsImpl;
@synthesize tags = _tags;
@synthesize needTagsUpdate;

- (NSArray *)tags {
  [self willAccessValueForKey:@"tags"];
  
  if(self.needTagsUpdate) {
    _tags = [MeasurableHelper arraySortedByText:self.tagsImpl ascending:YES];
    self.needTagsUpdate = NO;
  }
  
  NSArray* tmpValue = _tags;
  
  [self didAccessValueForKey:@"tags"];
  return tmpValue;
}

/////////////////////////////////////////////////////////
//Computed Properties
/////////////////////////////////////////////////////////
- (NSString *)metadataFull {
  return nil;
}
- (NSString *)metadataShort {
  return nil;
}

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////

- (void) addVideo:(MeasurableMetadataVideo*) video {
  video.measurableMetadata = self;
}
- (void) addImage:(MeasurableMetadataImage*) image {
  image.measurableMetadata = self;
}
- (void) addTag:(Tag*) tag {    
  [[self mutableSetValueForKey:@"tagsImpl"] addObject:tag];
}

- (void) removeVideo:(MeasurableMetadataVideo*) video {
  if([video.measurableMetadata isEqual: self]) {
    video.measurableMetadata = nil;
    [ModelHelper deleteModelObject:video andSave:NO];

    //CXB TODO
    //Probably remove the image from disk
  }
}
- (void) removeImage:(MeasurableMetadataImage*) image {

  if([image.measurableMetadata isEqual: self]) {

    image.measurableMetadata = nil;
    [ModelHelper deleteModelObject:image andSave:NO];

    //CXB TODO
    //Probably remove the image from disk
  }
}
- (void) removeTag:(Tag*) tag {
  
  //We do not want to delete the tag from persistent
  //storage just remove the relationship
  [[self mutableSetValueForKey:@"tagsImpl"] removeObject:tag];
}

- (void)imageIndexUpdated {
  self.needImagesUpdate = YES;
}

- (void)videoIndexUpdated {
  self.needVideosUpdate = YES;
}

/////////////////////////////////////////////////////////
//Subclass
/////////////////////////////////////////////////////////

- (MeasurableMetadata*) newInstance {
  return nil;
}

- (id)copyWithZone:(NSZone *)zone {

  MeasurableMetadata* metadata = [self newInstance];

  if(metadata) {
    
    metadata.name = [NSString stringWithFormat: NSLocalizedString(@"measurable-name-copy-format", @"%@ Copy"), self.name];
    metadata.type = self.type;
    metadata.category = self.category;
    metadata.unit = self.unit;
    metadata.valueGoal = self.valueGoal;
    metadata.valueType = self.valueType;
    metadata.valueSample = self.valueSample;
    metadata.definition = self.definition;
    metadata.copyable = self.copyable;
    
    for (MeasurableMetadataImage* image in self.images) {
      [metadata addImage: [image copy]];
    }
    
    for (MeasurableMetadataVideo* video in self.videos) {
      [metadata addVideo: [video copy]];
    }
    
    for (Tag* tag in self.tags) {
      [metadata addTag:tag];
    }
  }
  
  return metadata;
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
    
    //NSLog(@"MeasurableMetadata - addObserver - %@", [self.objectID URIRepresentation].absoluteString);
    [self addObserver:self forKeyPath:@"imagesImpl" options: 0 context: NULL];
    [self addObserver:self forKeyPath:@"videosImpl" options: 0 context: NULL];
    [self addObserver:self forKeyPath:@"tagsImpl" options: 0 context: NULL];
    self.needImagesUpdate = YES;
    self.needVideosUpdate = YES;
    self.needTagsUpdate = YES;
    
    [self addObserver:self forKeyPath:@"unit" options: 0 context: NULL];
    [self addObserver:self forKeyPath:@"valueGoalImpl" options: 0 context: NULL];
    
    self.needSetup = NO;
    self.needCleanup = YES;
  }  
}

- (void) cleanup {
  
  if(self.needCleanup) {
    
    //NSLog(@"MeasurableMetadata - cleanup - %@", [self.objectID URIRepresentation].absoluteString);
    [self removeObserver:self forKeyPath:@"imagesImpl"];
    [self removeObserver:self forKeyPath:@"videosImpl"];
    [self removeObserver:self forKeyPath:@"tagsImpl"];
    
    [self removeObserver:self forKeyPath:@"unit"];
    [self removeObserver:self forKeyPath:@"valueGoalImpl"];
    
    self.needCleanup = NO;
    self.needSetup = YES;
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  
  if([@"imagesImpl" isEqualToString:keyPath]) {
//    NSLog(@"MeasurableMetadata - observeValueForKeyPath - images");
    self.needImagesUpdate = YES;
  } else if([@"videosImpl" isEqualToString:keyPath]) {
//    NSLog(@"MeasurableMetadata - observeValueForKeyPath - videos");
    self.needVideosUpdate = YES;
  } else if([@"tagsImpl" isEqualToString:keyPath]) {
//    NSLog(@"MeasurableMetadata - observeValueForKeyPath - tags");
    self.needTagsUpdate = YES;
  } else if([@"valueGoalImpl" isEqualToString:keyPath] || [@"unit" isEqualToString:keyPath]) {
    //    NSLog(@"MeasurableMetadata - observeValueForKeyPath - valueGoalImpl or unit");
    
    //CXB HANDLE THIS BETTER
    if(self.measurables.count > 0) {
      MeasurableData* measurableData = ((Measurable*)[[self.measurables sortedArrayUsingDescriptors:nil] objectAtIndex:0]).data;
      [measurableData metadataChanged];
    }
  }
}

@end
