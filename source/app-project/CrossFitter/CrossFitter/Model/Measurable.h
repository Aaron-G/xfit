//
//  Measurable.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/9/12.
//
//

#import <Foundation/Foundation.h>
#import "Unit.h"

typedef enum {
  kMeasurableValueTrendBetter,
  kMeasurableValueTrendSame,
  kMeasurableValueTrendWorse,
  kMeasurableValueTrendNone
} MeasurableValueTrend;

typedef enum {
  kMeasurableValueTrendDirectionUp,
  kMeasurableValueTrendDirectionDown
} MeasurableValueTrendDirection;

@protocol Measurable <NSObject>

@property CGFloat value;
@property MeasurableValueTrend valueTrend;
@property MeasurableValueTrendDirection valueTrendBetterDirection;
@property Unit* unit;

@end
