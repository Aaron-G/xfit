//
//  AppDelegate.m
//  PR Wall
//
//  Created by Cleo Barretto on 7/18/12.
//

#import "AppDelegate.h"
#import "App.h"
@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  //Customize general settings
  [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
  UINavigationController* navigationController = (UINavigationController*)[self window].rootViewController;
  navigationController.toolbar.barStyle = UIBarStyleBlack;
  navigationController.navigationBar.barStyle = UIBarStyleBlack;

  //Configure the App
  App* app = [App sharedInstance];
  app.appDelegate = self;

  // Override point for customization after application launch.
  return YES;
}
@end
