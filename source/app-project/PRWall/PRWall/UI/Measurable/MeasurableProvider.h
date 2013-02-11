//
//  MeasurableProvider.h
//  PR Wall
//
//  Created by Cleo Barretto on 10/15/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"

@protocol MeasurableProvider <NSObject>

@property Measurable* measurable;

@end
