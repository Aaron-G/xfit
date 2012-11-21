//
//  MeasurableViewUpdateDelegate.h
//  CrossFitter
//
//  Created by Cleo Barretto on 11/2/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"

@protocol MeasurableViewUpdateDelegate <NSObject>

- (void) updateViewInViewController:(UIViewController*) viewController withMeasurable: (id<Measurable>) measurable withLayoutPosition:(CGPoint) startPosition;

@end
