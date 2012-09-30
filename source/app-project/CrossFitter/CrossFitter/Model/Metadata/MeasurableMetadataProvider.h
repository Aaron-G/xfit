//
//  MeasurableMetadataProvider.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"

@class Unit;

@interface MeasurableMetadataProvider : NSObject

@property NSString* measurableIdentifier;
@property NSString* name;
@property NSString* description;

@property Unit* unit;
@property MeasurableValueTrendBetterDirection valueTrendBetterDirection;

@property NSArray* images;
@property NSArray* videos;

@property MeasurableSource source;

- (id)initWithMeasurableIdentifier:(NSString*) measurableIdentifier;


@end
