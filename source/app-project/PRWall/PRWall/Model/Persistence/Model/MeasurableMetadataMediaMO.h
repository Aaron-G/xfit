//
//  MeasurableMetadataMediaMO.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/10/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MeasurableMetadataMO;

@interface MeasurableMetadataMediaMO : NSManagedObject

@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) MeasurableMetadataMO *measurableMetadata;

@end
