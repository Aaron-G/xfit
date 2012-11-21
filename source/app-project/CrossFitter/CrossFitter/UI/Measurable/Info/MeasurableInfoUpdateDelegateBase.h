//
//  MeasurableInfoUpdateDelegateBase.h
//  CrossFitter
//
//  Created by Cleo Barretto on 11/2/12.
//
//

#import <Foundation/Foundation.h>
#import "MeasurableViewUpdateDelegate.h"
#import "MeasurableInfoViewController.h"

@interface MeasurableInfoUpdateDelegateBase : NSObject <MeasurableViewUpdateDelegate>

//Subclasses
- (void) updateContentWithMeasurable: (id<Measurable>)measurable inMeasurableInfoViewController: (MeasurableInfoViewController *)measurableInfoViewController;
- (void) updateLayoutWithMeasurable: (id<Measurable>) measurable inMeasurableInfoViewController:(MeasurableInfoViewController*) measurableInfoViewController startAtPosition:(CGPoint) startPosition;

@end
