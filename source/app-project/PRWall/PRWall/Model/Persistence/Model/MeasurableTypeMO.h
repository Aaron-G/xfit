//
//  MeasurableTypeMO.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/10/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MeasurableCategoryMO, MeasurableMetadataMO;

@interface MeasurableTypeMO : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) MeasurableCategoryMO *measurableCategory;
@property (nonatomic, retain) MeasurableMetadataMO *measurableMetadata;

@end
