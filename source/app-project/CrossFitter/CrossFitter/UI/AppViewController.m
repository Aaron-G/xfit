//
//  AppViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/6/12.
//
//

#import "AppViewController.h"
#import "App.h"
#import "HomeViewController.h"
#import "PRWallViewController.h"
#import "WODViewController.h"
#import "WorkoutViewController.h"
#import "MoveViewController.h"
#import "MyBodyViewController.h"
#import "InfoViewController.h"
#import "AppConstants.h"
#import "AppScreen.h"
#import "AppScreenSwitchDelegate.h"
#import "AppViewGestureRecognizer.h"

static NSMutableDictionary* appScreenSwitchDelegates;

@interface AppViewController () {
  
}

////////////////////////////////////////////////////////////////
//Typedefs
////////////////////////////////////////////////////////////////

typedef enum {
  MenuDisclosureDirectionUp,
  MenuDisclosureDirectionDown
} MenuDisclosureDirection;

////////////////////////////////////////////////////////////////
//Class
////////////////////////////////////////////////////////////////

//Returns a dictionary with the AppScreenSwitchDelegate objects
+ (NSMutableDictionary*) appScreenSwitchDelegates;

+ (NSString*) appScreenKeyForAppScreen: (AppScreenIdentifier) screen;

+ (id) appScreenSwitchDelegateForAppScreen: (AppScreenIdentifier) screen;

////////////////////////////////////////////////////////////////
//Instance
////////////////////////////////////////////////////////////////

//Interface Builder
@property IBOutlet UIButton* menuDisclosureButton;

//The view that holds the app content and menu 
@property IBOutlet UIView* containerView;

//Gesture Reconizer
@property AppViewGestureRecognizer* gestureRecognizer;

-(IBAction) showOrHideMenuAction:(id)sender;

//API
@property BOOL menuVisible;

- (void) rotateMenuDisclosureWithDirection: (MenuDisclosureDirection) direction;

@end


@implementation AppViewController


- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];

  if (self) {
    
    //Custom Initialization
    self.menuVisible = NO;
    
    //Gesture recognizer
    self.gestureRecognizer = [[AppViewGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
  }
  
  return self;
}

//Hide the app menu when the user taps on the content views
//while the menu is displayed
- (void)handleTap:(UITapGestureRecognizer *)sender {
  [self showOrHideMenu];
}

- (void)viewDidLoad
{
  //NSLog(@"viewDidLoad");
  [super viewDidLoad];
  
  //Adjust the menu disclosure button
  [self rotateMenuDisclosureWithDirection: MenuDisclosureDirectionDown];
  
  //Hide the navigation toolbar which is displayed by default
  self.navigationController.toolbarHidden = YES;
  
  //Start the application
  [[App sharedInstance] startApp];
}

- (void)viewWillAppear:(BOOL)animated {
  //NSLog(@"viewWillAppear");
  [super viewWillAppear:animated];
  
  dispatch_async(dispatch_get_main_queue(), ^{

    //CXB_REVIEW
    //This may not be the case all the time
    //Hide the menu
    self.containerView.transform = CGAffineTransformMakeTranslation(0, -self.menuView.bounds.size.height);
    
    //Display the app menu if needed
    [[App sharedInstance] displayAppMenuIfNeeded];
  });
}

- (void)viewWillDisappear:(BOOL)animated {

  //Hide the menu in case it is visible so that the UI
  //stays consistent
  if(self.menuVisible) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self showOrHideMenu];
    });
  }

  //Super call
  [super viewWillDisappear:animated];
}


#pragma Application API
- (void) displayScreenForStartUp:(AppScreenIdentifier) screen {
  [self displayScreen: screen withAutoHide: NO];
}

- (void) displayScreen:(AppScreenIdentifier) screen {
  [self displayScreen: screen withAutoHide: YES];
}

- (void) displayScreen:(AppScreenIdentifier) screen withAutoHide: (BOOL) autoHide {
  
  //Only update if different
  if(self.displayedAppScreen != screen) {
  
    AppScreenSwitchDelegate* screenSwitchDelegate = [AppViewController appScreenSwitchDelegateForAppScreen:screen];
    
    //Update the state variable
    _displayedAppScreen = screen;
    
    [screenSwitchDelegate updateNavigationBar];
    [screenSwitchDelegate updateNavigationToolbar];
    [screenSwitchDelegate updateMainView];

    if(self.menuVisible && autoHide) {
      dispatch_async(dispatch_get_main_queue(), ^{
        [self showOrHideMenu];
      });
    }
  } else if(self.menuVisible) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self showOrHideMenu];
    });
  }

}

- (void) displayInfoScreen {
  [self displayScreen:AppScreenIdentifierInfo];
}

- (void) displayPRWallScreen {
  [self displayScreen:AppScreenIdentifierPRWall];
}

- (void) displayMyBodyScreen {
  [self displayScreen:AppScreenIdentifierMyBody];
}

- (void) displayWorkoutScreen {
  [self displayScreen:AppScreenIdentifierWorkout];
}

- (void) displayWODScreen {
  [self displayScreen:AppScreenIdentifierWOD];
}

- (void) displayMoveScreen {
  [self displayScreen:AppScreenIdentifierMove];
}

- (void) displayHomeScreen {
  [self displayScreen:AppScreenIdentifierHome];
}

-(IBAction) showOrHideMenuAction:(id)sender {
  [self showOrHideMenu];
}

- (void) showOrHideMenu {
  [self showOrHideMenuWithDelay: 0.0 withAutoHideDelay: -1];
}

- (void) showMenuWithAutoHideDelay: (CGFloat) autoHideDelay {

  if(!self.menuVisible) {
    [self showOrHideMenuWithDelay: 0.0 withAutoHideDelay: autoHideDelay];
  }
  
}

- (void) showOrHideMenuWithDelay: (CGFloat) delay withAutoHideDelay: (CGFloat) autoHideDelay {
//  NSLog(@"showOrHideMenuWithDelay");
  //Figure out the translation and animation options
  CGFloat verticalTranslation;
  UIViewAnimationOptions animationOptions;
  MenuDisclosureDirection direction;
  
  if(self.menuVisible) {

    verticalTranslation = -self.menuView.bounds.size.height;
    animationOptions = UIViewAnimationOptionCurveEaseIn;
    direction = MenuDisclosureDirectionDown;
    
    [self.contentView removeGestureRecognizer:self.gestureRecognizer];
    
  } else {

    verticalTranslation = 0;
    animationOptions = UIViewAnimationOptionCurveEaseOut;
    direction = MenuDisclosureDirectionUp;
    
    [self.contentView addGestureRecognizer:self.gestureRecognizer];
  }

  //Update the visbility
  self.menuVisible =   !self.menuVisible;
  
  
  [UIView animateWithDuration: kScreenSwitchAnimationDuration
                        delay: delay
                      options: UIViewAnimationOptionAllowUserInteraction | animationOptions
                   animations:^{
                     self.containerView.transform = CGAffineTransformMakeTranslation(0, verticalTranslation);
                     [self rotateMenuDisclosureWithDirection: direction];
                   }
                   completion: ^(BOOL finished){
                     
                     if(autoHideDelay >= 0) {
                       [self showOrHideMenuWithDelay: autoHideDelay withAutoHideDelay:-1];
                     }
                   }];
}

//Direction refers to the end state of the menu disclosure
- (void) rotateMenuDisclosureWithDirection: (MenuDisclosureDirection) direction {
  
  CGFloat menuDisclosureRotationAngle;

  if(MenuDisclosureDirectionUp == direction) {
    menuDisclosureRotationAngle = 270;
  } else if(MenuDisclosureDirectionDown == direction) {
    menuDisclosureRotationAngle = 90;
  }

  self.menuDisclosureButton.transform = CGAffineTransformMakeRotation(menuDisclosureRotationAngle*M_PI/180.0);
}

////////////////////////////////////////////////////////////////
//Class - START
////////////////////////////////////////////////////////////////
+ (NSMutableDictionary*) appScreenSwitchDelegates {
  
  if(!appScreenSwitchDelegates) {
    appScreenSwitchDelegates = [NSMutableDictionary dictionary];
  }
  return appScreenSwitchDelegates;
}

+ (void) addAppScreenSwitchDelegate: (AppScreenSwitchDelegate*) appScreenSwitchDelegate forAppScreen: (AppScreenIdentifier) screen {
  
  NSString * screenKey = [AppViewController appScreenKeyForAppScreen:screen];
  
  [[AppViewController appScreenSwitchDelegates] setObject:appScreenSwitchDelegate forKey:screenKey];
}

+ (NSString*) appScreenKeyForAppScreen: (AppScreenIdentifier) screen {
  return [AppScreen screenNameForAppScreen:screen];
}

+ (AppScreenSwitchDelegate*)appScreenSwitchDelegateForAppScreen: (AppScreenIdentifier) screen
{
  NSString * screenKey = [AppViewController appScreenKeyForAppScreen:screen];
  
  AppScreenSwitchDelegate* appScreenSwitchDelegate = [[AppViewController appScreenSwitchDelegates] objectForKey:screenKey];
  
  //The very first time this does not exist so
  //lazely initialize it
  if(!appScreenSwitchDelegate) {
    
    NSString* viewControllerId = nil;
    
    if(AppScreenIdentifierHome == screen) {
      viewControllerId = @"HomeViewController";
    } else if(AppScreenIdentifierPRWall == screen) {
      viewControllerId = @"PRWallViewController";
    } else if(AppScreenIdentifierWOD == screen) {
      viewControllerId = @"WODViewController";
    } else if(AppScreenIdentifierWorkout == screen) {
      viewControllerId = @"WorkoutViewController";
    } else if(AppScreenIdentifierMove == screen) {
      viewControllerId = @"MoveViewController";
    } else if(AppScreenIdentifierMyBody == screen) {
      viewControllerId = @"MyBodyViewController";
    } else if(AppScreenIdentifierInfo == screen) {
      viewControllerId = @"InfoViewController";
    }
    
    AppViewController* appViewController = [[App sharedInstance] appViewController];
    id viewController = [appViewController.storyboard instantiateViewControllerWithIdentifier:viewControllerId];
    
    if([viewController respondsToSelector:@selector(appScreenSwitchDelegate)]) {
      appScreenSwitchDelegate = (AppScreenSwitchDelegate*)[viewController performSelector:@selector(appScreenSwitchDelegate)];
    } else {
      NSLog(@"Could not find appScreenSwitchDelegate");
    }
  }
  
  return appScreenSwitchDelegate;
}


@end
