//
//  ActivityMetadata.m
//  PR Wall
//
//  Created by Cleo Barretto on 1/4/13.
//
//

#import "ActivityMetadata.h"

@implementation ActivityMetadata

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////

////////////////////////////////
//favorite
////////////////////////////////
@dynamic favoriteImpl;

- (BOOL)favorite {
  [self willAccessValueForKey:@"favorite"];
  NSNumber *tmpValue = [self favoriteImpl];
  [self didAccessValueForKey:@"favorite"];
  return (tmpValue!=nil) ? [tmpValue boolValue] : NO;
}

- (void)setFavorite:(BOOL)favorite {
  NSNumber* tmpValue = [[NSNumber alloc] initWithBool:favorite];
  [self willChangeValueForKey:@"favorite"];
  [self setFavoriteImpl:tmpValue];
  [self didChangeValueForKey:@"favorite"];
}

////////////////////////////////
//prWall
////////////////////////////////
@dynamic prWallImpl;

- (BOOL)prWall {
  [self willAccessValueForKey:@"prWall"];
  NSNumber *tmpValue = [self prWallImpl];
  [self didAccessValueForKey:@"prWall"];
  return (tmpValue!=nil) ? [tmpValue boolValue] : NO;
}

- (void)setPrWall:(BOOL)prWall {
  NSNumber* tmpValue = [[NSNumber alloc] initWithBool:prWall];
  [self willChangeValueForKey:@"prWall"];
  [self setPrWallImpl:tmpValue];
  [self didChangeValueForKey:@"prWall"];
}

- (id)copyWithZone:(NSZone *)zone {
  
  ActivityMetadata* metadata = (ActivityMetadata*)[super copyWithZone:zone];
  
  if(metadata) {
    
    metadata.prWall = self.prWall;
    metadata.favorite = self.favorite;
  }  
  return metadata;
}

@end
