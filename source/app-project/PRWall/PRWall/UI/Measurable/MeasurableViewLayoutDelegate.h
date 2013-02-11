//
//  MeasurableViewLayoutDelegate.h
//  PR Wall
//
//  Created by Cleo Barretto on 11/2/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"

@protocol MeasurableViewLayoutDelegate <NSObject>

- (void) layoutViewInViewController:(UIViewController*) viewController withMeasurable: (Measurable*) measurable withLayoutPosition:(CGPoint) layoutPosition;

@end
