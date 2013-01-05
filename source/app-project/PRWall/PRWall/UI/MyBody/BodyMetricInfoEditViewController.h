//
//  BodyMetricInfoEditViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import <UIKit/UIKit.h>
#import "MeasurableInfoEditViewController.h"

@interface BodyMetricInfoEditViewController : MeasurableInfoEditViewController

- (IBAction) changeMassUnit:(id)sender;
- (IBAction) changeLengthUnit:(id)sender;
- (IBAction) changeMeasurableValueGoal:(id)sender;

@end