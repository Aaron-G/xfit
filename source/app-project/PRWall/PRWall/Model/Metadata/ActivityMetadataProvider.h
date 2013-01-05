//
//  ActivityMetadataProvider.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/4/13.
//
//

#import "MeasurableMetadataProvider.h"

@interface ActivityMetadataProvider : MeasurableMetadataProvider

@property BOOL favorite;
@property BOOL prWall;
@property NSArray* tags;

@end
