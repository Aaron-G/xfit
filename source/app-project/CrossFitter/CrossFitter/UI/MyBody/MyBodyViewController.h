//
//  MyBodyViewController.h
//  CrossFitter
//
//  Created by Cleo Barretto on 8/8/12.
//
//
#import "AppScreenSwitchDelegate.h"
#import "MeasurableCollectionDisplay.h"

@interface MyBodyViewController : UITableViewController <UIActionSheetDelegate, MeasurableCollectionDisplay>

@property AppScreenSwitchDelegate* appScreenSwitchDelegate;

@end