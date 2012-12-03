//
//  MeasurableInfoEditViewControllerDelegate.h
//  CrossFitter
//
//  Created by Cleo Barretto on 12/1/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"

@protocol MeasurableInfoEditViewControllerDelegate <NSObject>

- (void) didEditMeasurableInfoForMeasurable:(id<Measurable>) measurable;

@end
