//
//  WODViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 8/8/12.
//
//
#import "AppScreenSwitchDelegate.h"

@interface WODViewController : UIViewController

@property AppScreenSwitchDelegate* appScreenSwitchDelegate;

@property IBOutlet UIBarButtonItem* barButtonItemSettings;
@property IBOutlet UIBarButtonItem* barButtonItemLog;
@property IBOutlet UIBarButtonItem* barButtonItemNew;


@end
