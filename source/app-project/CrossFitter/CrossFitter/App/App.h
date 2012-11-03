//
//  App.h
//  CrossFitter
//
//  Created by Cleo Barretto on 8/7/12.
//
//

#import <Foundation/Foundation.h>
#import "AppViewController.h"
#import "AppDelegate.h"
#import "UserProfile.h"
#import "MeasurableViewController.h"
#import "UserProfileViewController.h"

@interface App : NSObject

@property (nonatomic, readonly) AppViewController* appViewController;
@property (nonatomic, readonly) UINavigationController* navigationViewController;
@property (nonatomic, readonly) MeasurableViewController* measurableViewController;
@property (nonatomic, readonly) UserProfileViewController* userProfileViewController;

@property (nonatomic) AppDelegate* appDelegate;
@property (nonatomic, readonly) NSString* systemInformation;
@property (nonatomic, readonly) NSString* appInformation;
@property (nonatomic, readonly) NSString* appSupportEmail;
@property (nonatomic, readonly) NSString* appVersion;
@property (readonly) UserProfile* userProfile;
@property (readonly) BOOL started;

//Starts the app
- (void)startApp;

//Displays the app menu - if needed
- (void) displayAppMenuIfNeeded;

//Returns the shared instance of the running app.
+ (App*)sharedInstance;

@end
