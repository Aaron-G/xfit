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

@interface App : NSObject

@property (nonatomic, readonly) AppViewController *appViewController;
@property (nonatomic, readonly) UINavigationController *navigationViewController;
@property (nonatomic) AppDelegate *appDelegate;
@property (nonatomic, readonly) NSString* systemInformation;
@property (nonatomic, readonly) NSString* appInformation;
@property (nonatomic, readonly) NSString* appSupportEmail;
@property (nonatomic, readonly) NSString* appVersion;

//Starts the app
- (void)startApp;

//Returns the shared instance of the running app.
+ (App*)sharedInstance;

@end
