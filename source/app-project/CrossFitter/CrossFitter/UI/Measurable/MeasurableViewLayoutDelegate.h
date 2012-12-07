//
//  MeasurableViewLayoutDelegate.h
//  CrossFitter
//
//  Created by Cleo Barretto on 11/2/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"

@protocol MeasurableViewLayoutDelegate <NSObject>

- (void) layoutViewInViewController:(UIViewController*) viewController withMeasurable: (id<Measurable>) measurable withLayoutPosition:(CGPoint) layoutPosition;

@end
