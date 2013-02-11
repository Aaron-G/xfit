//
//  MeasurableMetadataImage.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/30/13.
//
//

#import <CoreData/CoreData.h>
#import "MeasurableMetadata.h"
#import "Media.h"

@interface MeasurableMetadataImage :  Media

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////

//Relationships
@property (nonatomic, retain) MeasurableMetadata * measurableMetadata;

@end
