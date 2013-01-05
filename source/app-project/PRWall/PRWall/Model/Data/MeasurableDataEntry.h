//
//  MeasurableDataEntry.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/26/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"

typedef NSString* MeasurableDataEntryIdentifier;

@interface MeasurableDataEntry : NSObject

@property MeasurableDataEntryIdentifier identifier;

@property NSNumber* value;
@property NSDate* date;
@property NSString* comment;

@property NSArray* images;
@property NSArray* videos;

//Computed properties
@property MeasurableValueTrend valueTrend;
@property (readonly) BOOL hasAdditionalInfo;

@end
