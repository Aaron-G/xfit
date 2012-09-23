//
//  BodyMetricHelper.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/23/12.
//
//

#import <Foundation/Foundation.h>
#import "BodyMetric.h"
#import "UnitValueFormatter.h"

//Holds BodyMetric related utility methods.
@interface BodyMetricHelper : NSObject

+ (id<UnitValueFormatter>) formatterForBodyMetric: (BodyMetric*) bodyMetric;

@end
