//
//  MeasurableViewControllerDelegate.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/1/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"

@class  Measurable;

@protocol MeasurableViewControllerDelegate <NSObject>

- (void) didChangeMeasurable:(id<Measurable>)measurable;
- (void) didDeleteMeasurable:(id<Measurable>)measurable;
- (void) didCreateMeasurable:(id<Measurable>)measurable;

@end
