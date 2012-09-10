//
//  HomeViewController.h
//  CrossFitter
//
//  Created by Cleo Barretto on 8/7/12.
//
//

#import <UIKit/UIKit.h>
#import "AppScreenSwitchDelegate.h"

@interface HomeViewController : UIViewController <UIActionSheetDelegate>

@property AppScreenSwitchDelegate* appScreenSwitchDelegate;

- (IBAction) displayPRWall;
- (IBAction) displayMyBody;
- (IBAction) displayWorkout;
- (IBAction) displayWOD;
- (IBAction) displayMove;

@end
