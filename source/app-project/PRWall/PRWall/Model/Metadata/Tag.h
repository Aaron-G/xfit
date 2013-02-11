//
//  Tag.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/25/13.
//
//

#import <CoreData/CoreData.h>
#import "MeasurableMetadata.h"

typedef enum {
  TagSourceApp,
  TagSourceUser
} TagSource;

@interface Tag : NSManagedObject

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////
//Attributes
@property (nonatomic, retain) NSString * text;

//Relationships
@property (nonatomic, retain) MeasurableMetadata * measurableMetadata;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////
@property TagSource source;
@property (nonatomic, retain) NSNumber * sourceImpl;

@end
