//
//  MeasurableInfoEditViewControllerDelegate.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/1/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"

@protocol MeasurableInfoEditViewControllerDelegate <NSObject>

- (void) didEditMeasurableInfoForMeasurable:(Measurable*) measurable;
- (void) didCreateMeasurableInfoForMeasurable:(Measurable*) measurable;
- (void) didDeleteMeasurableInfoForMeasurable:(Measurable*) measurable;

@end
