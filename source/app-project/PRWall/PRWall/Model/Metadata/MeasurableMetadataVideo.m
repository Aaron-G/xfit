//
//  MeasurableMetadataVideo.m
//  PR Wall
//
//  Created by Cleo Barretto on 1/25/13.
//
//

#import "MeasurableMetadataVideo.h"
#import "ModelHelper.h"

@implementation MeasurableMetadataVideo

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////

//Relationships
@dynamic measurableMetadata;

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////

- (void)indexUpdated {
  [self.measurableMetadata videoIndexUpdated];
}

/////////////////////////////////////////////////////////
//Subclass
/////////////////////////////////////////////////////////

- (Media*) newInstance {
  return [ModelHelper newMeasurableMetadataVideo];
}

@end