//
//  Media.m
//  PR Wall
//
//  Created by Cleo Barretto on 1/28/13.
//
//

#import "Media.h"

@interface Media () {
}

@property BOOL needSetup;
@property BOOL needCleanup;

@end

@implementation Media

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////
//Attributes
@dynamic index;
@dynamic path;

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////

- (void)indexUpdated {
  //no action. this is intended for subclasses
}

/////////////////////////////////////////////////////////
//Subclass
/////////////////////////////////////////////////////////

- (Media*) newInstance {
  return nil;
}

- (id)copyWithZone:(NSZone *)zone {
  
  Media* media = [self newInstance];
  
  if(media) {
    
    media.path = self.path;
    media.index = self.index;
  }
  
  return media;
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
    
    //NSLog(@"Media - addObserver - %@", [self.objectID URIRepresentation].absoluteString);
    [self addObserver:self forKeyPath:@"index" options: 0 context: NULL];
    
    self.needSetup = NO;
    self.needCleanup = YES;
  }
}

- (void) cleanup {
  
  if(self.needCleanup) {
    
    //NSLog(@"Media - cleanup - %@", [self.objectID URIRepresentation].absoluteString);
    [self removeObserver:self forKeyPath:@"index"];
    
    self.needCleanup = NO;
    self.needSetup = YES;
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  
  if([@"index" isEqualToString:keyPath]) {
    //NSLog(@"Media - observeValueForKeyPath - index");
    [self indexUpdated];
  }
}

@end
