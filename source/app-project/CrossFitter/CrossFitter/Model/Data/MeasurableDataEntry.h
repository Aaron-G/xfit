//
//  MeasurableDataEntry.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/26/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"

typedef NSString* MeasurableDataEntryIdentifier;

@interface MeasurableDataEntry : NSObject

//Data Provider Properties
@property MeasurableDataEntryIdentifier identifier;
@property NSNumber* value;
@property MeasurableValueTrend valueTrend;

@property NSDate* date;
@property NSString* comment;

@property NSArray* images;
@property NSArray* videos;

@property (readonly) BOOL hasAdditionalInfo;
@end
