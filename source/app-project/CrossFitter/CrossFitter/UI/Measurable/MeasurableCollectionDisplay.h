//
//  MeasurableCollectionDisplay.h
//  CrossFitter
//
//  Created by Cleo Barretto on 11/3/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"

@protocol MeasurableCollectionDisplay <NSObject>

- (void) updateMeasurable:(MeasurableIdentifier) measurableIdenfitier;

@end
