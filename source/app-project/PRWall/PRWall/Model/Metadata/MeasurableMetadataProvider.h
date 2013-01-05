//
//  MeasurableMetadataProvider.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"
#import "MeasurableType.h"

@class Unit;

@interface MeasurableMetadataProvider : NSObject

@property MeasurableIdentifier identifier;

@property NSString* name;
@property NSString* description;

@property BOOL copyable;

@property MeasurableValueGoal valueGoal;
@property MeasurableValueType valueType;
@property NSNumber* valueSample;

@property MeasurableType* type;

@property NSArray* images;
@property NSArray* videos;

@property MeasurableSource source;

@property Unit* unit;
@property NSDictionary* moreInfo;

//Computed properties
@property NSString* metadataShort;
@property NSString* metadataFull;

- (id)initWithMeasurableIdentifier:(MeasurableIdentifier) identifier;

- (void) copyToMeasurableMetadataProvider:(MeasurableMetadataProvider*) metadataProvider;

@end
