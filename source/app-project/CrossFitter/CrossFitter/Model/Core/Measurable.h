//
//  Measurable.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/9/12.
//
//

//////////////////////////////////////////////////////
//IMPL NOTE
//////////////////////////////////////////////////////
//Need to be defined prior to imports below otherwise
//compiler will complain about the dependency between
//this interface and MeasurableDataProvider and
//MeasurableMetadataProvider.

typedef enum {
  MeasurableValueTrendUp,
  MeasurableValueTrendSame,
  MeasurableValueTrendDown,
  MeasurableValueTrendNone
} MeasurableValueTrend;

typedef enum {
  MeasurableValueTrendBetterDirectionNone,
  MeasurableValueTrendBetterDirectionUp,
  MeasurableValueTrendBetterDirectionDown
} MeasurableValueTrendBetterDirection;

typedef enum {
  MeasurableValueTypeNumber,
  MeasurableValueTypeNumberWithDecimal,
  MeasurableValueTypePercent,
  MeasurableValueTypeTime
} MeasurableValueType;

typedef enum {
  MeasurableSourceApp,
  MeasurableSourceUser,
  MeasurableSourceFeed
} MeasurableSource;


typedef NSString* MeasurableIdentifier;

//////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import "Unit.h"
#import "MeasurableDataProvider.h"
#import "MeasurableMetadataProvider.h"

@class MeasurableDataProvider;
@class MeasurableMetadataProvider;

@protocol Measurable <NSObject>

@property MeasurableDataProvider* dataProvider;
@property MeasurableMetadataProvider* metadataProvider;
@end
