//
//  MeasurablePickerDelegate.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/2/13.
//
//

#import <Foundation/Foundation.h>

@protocol MeasurablePickerDelegate <NSObject>

- (void) didPickMeasurable:(id<Measurable>) measurable;

@end
