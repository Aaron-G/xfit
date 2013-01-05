//
//  ExerciseViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 8/8/12.
//
//
#import "AppScreenSwitchDelegate.h"
#import "MeasurableViewControllerDelegate.h"

@interface ExerciseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MeasurableViewControllerDelegate>

@property AppScreenSwitchDelegate* appScreenSwitchDelegate;

@end
