//
//  PRWallViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 8/7/12.
//
//
#import "AppScreenSwitchDelegate.h"

@interface PRWallViewController : UIViewController <UIActionSheetDelegate>

@property AppScreenSwitchDelegate* appScreenSwitchDelegate;
@property IBOutlet UIButton* screenFullButton;
@property IBOutlet UIButton* screenRestoreButton;
@property IBOutlet UIBarButtonItem* barButtonItemShare;

@end
