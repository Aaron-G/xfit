//
//  MeasurableChartViewController.h
//  CrossFitter
//
//  Created by Cleo Barretto on 12/14/12.
//
//

#import <UIKit/UIKit.h>
#import "Measurable.h"
#import "CorePlot-CocoaTouch.h"
#import "MeasurableProvider.h"

@interface MeasurableChartViewController : UIViewController <CPTPlotDataSource, MeasurableProvider>

- (void) displayChartForMeasurable:(id<Measurable>) measurable;
- (UIImage*) createChartImageForMeasurable:(id<Measurable>) measurable;

@end
