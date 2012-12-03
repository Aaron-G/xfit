//
//  MyBodyViewController.h
//  CrossFitter
//
//  Created by Cleo Barretto on 8/8/12.
//
//
#import "AppScreenSwitchDelegate.h"
#import "MeasurableViewControllerDelegate.h"

@interface MyBodyViewController : UITableViewController <UIActionSheetDelegate, MeasurableViewControllerDelegate>

@property AppScreenSwitchDelegate* appScreenSwitchDelegate;

@end