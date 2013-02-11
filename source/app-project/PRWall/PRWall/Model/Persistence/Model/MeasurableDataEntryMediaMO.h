//
//  MeasurableDataEntryMediaMO.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/10/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MeasurableDataValueMO;

@interface MeasurableDataEntryMediaMO : NSManagedObject

@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) MeasurableDataValueMO *measurableDataValue;

@end
