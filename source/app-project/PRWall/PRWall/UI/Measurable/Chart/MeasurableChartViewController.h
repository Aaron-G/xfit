//
//  MeasurableChartViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/14/12.
//
//

#import <UIKit/UIKit.h>
#import "Measurable.h"
#import "CorePlot-CocoaTouch.h"
#import "MeasurableProvider.h"

@interface MeasurableChartViewController : UIViewController <CPTPlotDataSource, MeasurableProvider>

- (void) displayChartForMeasurable:(Measurable*) measurable;
- (UIImage*) createChartImageForMeasurable:(Measurable*) measurable;

@end
