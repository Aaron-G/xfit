//
//  AppViewController.h
//  CrossFitter
//
//  Created by Cleo Barretto on 8/6/12.
//
//

#import <UIKit/UIKit.h>
#import "AppScreen.h"
#import "AppScreenSwitchDelegate.h"
@class AppScreenSwitchDelegate;

@interface AppViewController : UIViewController

//The view that dislays the app content
@property IBOutlet UIView* contentView;

//The view that displays the app menu
@property IBOutlet UIView* menuView;

//The currently displayed AppScreen
@property (readonly) AppScreenIdentifier displayedAppScreen;

//Displays the requested screen
- (void) displayScreen:(AppScreenIdentifier) screen;
- (void) displayScreenForStartUp:(AppScreenIdentifier) screen;

- (void) displayHomeScreen;
- (void) displayPRWallScreen;
- (void) displayWODScreen;
- (void) displayWorkoutScreen;
- (void) displayMoveScreen;
- (void) displayMyBodyScreen;
- (void) displayInfoScreen;

//Shows or hides the application menu
- (void) showOrHideMenu;

//Shows the application menu and hides it after the provided hide delay
- (void) showOrHideMenuWithDelay: (CGFloat) delay withAutoHideDelay: (CGFloat) autoHideDelay;

//Allows AppScreenSwitchDelegate to register themselves
+ (void) addAppScreenSwitchDelegate: (AppScreenSwitchDelegate *) appScreenSwitchDelegate forAppScreen: (AppScreenIdentifier) screen;

@end