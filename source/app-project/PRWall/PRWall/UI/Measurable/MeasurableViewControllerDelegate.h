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

- (void) didChangeMeasurable:(Measurable*)measurable;
- (void) didDeleteMeasurable:(Measurable*)measurable;
- (void) didCreateMeasurable:(Measurable*)measurable;

@end
