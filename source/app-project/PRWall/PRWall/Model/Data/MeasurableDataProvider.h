//
//  MeasurableDataProvider.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"
#import "MeasurableDataEntry.h"

@interface MeasurableDataProvider : NSObject

//Data Provider Properties
@property (readonly) MeasurableIdentifier identifier;
@property NSArray* values;

//Data Entry Provider Convinience Properties
//These refer to the 1st entry on the values[]
@property (readonly) NSNumber* value;
@property (readonly) NSDate* date;
@property (readonly) NSString* comment;
@property (readonly) MeasurableValueTrend valueTrend;


- (id)initWithMeasurableIdentifier:(MeasurableIdentifier) identifier;

@end
