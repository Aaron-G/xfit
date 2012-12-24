//
//  MeasurableInfoLayoutDelegateBase.h
//  PR Wall
//
//  Created by Cleo Barretto on 11/2/12.
//
//

#import <Foundation/Foundation.h>
#import "MeasurableViewLayoutDelegate.h"
#import "MeasurableInfoViewController.h"

@interface MeasurableInfoLayoutDelegateBase : NSObject <MeasurableViewLayoutDelegate>

//Subclasses
- (void) updateContentWithMeasurable: (id<Measurable>)measurable inMeasurableInfoViewController: (MeasurableInfoViewController *)measurableInfoViewController;
- (void) updateLayoutWithMeasurable: (id<Measurable>) measurable inMeasurableInfoViewController:(MeasurableInfoViewController*) measurableInfoViewController startAtPosition:(CGPoint) startPosition;

@end
