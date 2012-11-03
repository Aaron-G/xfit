//
//  MeasurableInfoUpdateDelegateBase.h
//  CrossFitter
//
//  Created by Cleo Barretto on 11/2/12.
//
//

#import <Foundation/Foundation.h>
#import "MeasurableInfoUpdateDelegate.h"

@interface MeasurableInfoUpdateDelegateBase : NSObject <MeasurableInfoUpdateDelegate>

//Subclasses
- (void) layoutUIForMeasurable: (id<Measurable>) measurable inMeasurableInfoViewController:(MeasurableInfoViewController*) measurableInfoViewController;
- (void) updateUIContentWithMeasurable: (id<Measurable>)measurable inMeasurableInfoViewController: (MeasurableInfoViewController *)measurableInfoViewController;

@end
