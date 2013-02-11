//
//  MeasurableMO.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/10/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MeasurableDataMO, MeasurableMetadataMO, UserProfileMO;

@interface MeasurableMO : NSManagedObject

@property (nonatomic, retain) MeasurableDataMO *data;
@property (nonatomic, retain) MeasurableMetadataMO *metadata;
@property (nonatomic, retain) UserProfileMO *userProfile;

@end
