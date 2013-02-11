//
//  MeasurableDataEntryVideo.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/24/13.
//
//

#import <CoreData/CoreData.h>
#import "MeasurableDataEntry.h"
#import "Media.h"

@class MeasurableDataEntry;

@interface MeasurableDataEntryVideo : Media

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////

//Relationships
@property (nonatomic, retain) MeasurableDataEntry * measurableDataEntry;

@end
