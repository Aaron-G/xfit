//
//  Tag.m
//  PR Wall
//
//  Created by Cleo Barretto on 1/25/13.
//
//

#import "Tag.h"

@implementation Tag

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////

//Attributes
@dynamic text;

//Relationships
@dynamic measurableMetadata;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////

////////////////////////////////
//source
////////////////////////////////
@dynamic sourceImpl;

- (TagSource)source {
  [self willAccessValueForKey:@"source"];
  NSNumber *tmpValue = [self sourceImpl];
  [self didAccessValueForKey:@"source"];
  return (tmpValue!=nil) ? [tmpValue intValue] : TagSourceUser;
}

- (void)setSource:(TagSource)source {
  NSNumber* tmpValue = [[NSNumber alloc] initWithInt:source];
  [self willChangeValueForKey:@"source"];
  [self setSourceImpl:tmpValue];
  [self didChangeValueForKey:@"source"];
}
@end
