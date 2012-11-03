//
//  MeasurableInfoUpdateDelegate.h
//  CrossFitter
//
//  Created by Cleo Barretto on 11/2/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"
#import "MeasurableInfoViewController.h"

@protocol MeasurableInfoUpdateDelegate <NSObject>

- (void) updateUIWithMeasurable: (id<Measurable>) measurable inMeasurableInfoViewController:(MeasurableInfoViewController*) measurableInfoViewController;

@end
