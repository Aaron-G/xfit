//
//  ActivityMetadata.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/4/13.
//
//

#import "MeasurableMetadata.h"

@interface ActivityMetadata : MeasurableMetadata

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////
@property BOOL favorite;
@property (nonatomic, retain) NSNumber * favoriteImpl;

@property BOOL prWall;
@property (nonatomic, retain) NSNumber * prWallImpl;

@end
