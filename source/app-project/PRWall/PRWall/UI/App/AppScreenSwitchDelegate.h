//
//  AppScreenSwitchDelegate.h
//  PR Wall
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import <Foundation/Foundation.h>
#import "AppViewController.h"
@class AppViewController;

//Used to ease switching between the app screens.
@interface AppScreenSwitchDelegate : NSObject

@property (readonly) UIViewController * viewController;
@property (readonly) AppViewController * appViewController;
@property (readonly) AppScreenIdentifier appScreen;
@property BOOL displayBackButtonAsBack;
@property BOOL initialized;

//Initialization API
- initWithViewController: (UIViewController*) viewController;


//Screen component initialization API
- (void)initialize;
- (void)initToolbarItems;
- (void)initNavigationItems;
- (void)initTitle;

//Screen switching API
- (void)updateBars;
- (void)updateNavigationBar;
- (void)updateNavigationToolbar;
- (void)updateMainView;
- (void)screenWillAppear;
- (void)screenWillDisappear;


@end
