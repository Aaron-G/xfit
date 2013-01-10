//
//  AppViewController.h
//  PR Wall
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

- (void) displayPRWallScreen;
- (void) displayWorkoutScreen;
- (void) displayExerciseScreen;
- (void) displayMyBodyScreen;
- (void) displayInfoScreen;

//Shows or hides the application menu
- (void) showOrHideMenu;

//Shows the application menu and hides it after the provided hide delay
- (void) showOrHideMenuWithDelay: (CGFloat) delay withAutoHideDelay: (CGFloat) autoHideDelay;

//Sets the supported interface orientation. Passing zero to it resets to the app's defaults
- (void)setSupportedInterfaceOrientations:(NSUInteger)supportedInterfaceOrientations;

//Allows AppScreenSwitchDelegate to register themselves
+ (void) addAppScreenSwitchDelegate: (AppScreenSwitchDelegate *) appScreenSwitchDelegate forAppScreen: (AppScreenIdentifier) screenIdentifier;
//Return the AppScreenSwitchDelegate for the given AppScreenIdentifier
+ (AppScreenSwitchDelegate*)appScreenSwitchDelegateForAppScreen: (AppScreenIdentifier) screenIdentifier;

@end