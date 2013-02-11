//
//  MeasurableMetadataVideo.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/25/13.
//
//

#import <CoreData/CoreData.h>
#import "MeasurableMetadata.h"
#import "Media.h"

@interface MeasurableMetadataVideo :  Media

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////

//Relationships
@property (nonatomic, retain) MeasurableMetadata * measurableMetadata;

@end
