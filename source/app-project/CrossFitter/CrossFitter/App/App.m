//
//  App.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/7/12.
//
//

#import "App.h"
#import "AppConstants.h"
@interface AppViewController () {
  
}
@property NSInteger applicationRunCount;

@end

@implementation App

static App *sharedInstance = nil;

@synthesize appDelegate = _appDelegate;
@synthesize appViewController= _appViewController;
@synthesize navigationViewController = _navigationViewController;

- (void) setAppDelegate:(AppDelegate *)appDelegate {
  
  if(!_appDelegate) {
    _appDelegate = appDelegate;
    _navigationViewController = (UINavigationController*)[[appDelegate window] rootViewController];
    _appViewController = (AppViewController*)[_navigationViewController topViewController];
  }
  
}

- (void)startApp {
  
  //Read application run count
  NSInteger appRunCount = [self applicationRunCount];
  
  //For now hard code the start screen at the the home screen
  [[self appViewController] displayScreenForStartUp:kAppScreenIdentifierHome];
  
  //Show and Hide the Application menu after a short moment - only the first
  //few times the user has run the app
  if(appRunCount <= kNumberOfRunsToShowHelp) {
    [[self appViewController] showOrHideMenuWithDelay:1.5 withAutoHideDelay:2];
    
    //Save application run count - only for the same of keeping track on this
    //So no need to keep track of it later
    self.applicationRunCount = ++appRunCount;
  }
  
}

- (NSInteger) applicationRunCount {
  return [[NSUserDefaults standardUserDefaults] integerForKey:@"appRunCount"];
}

- (void) setApplicationRunCount:(NSInteger) count {
  [[NSUserDefaults standardUserDefaults] setInteger:count forKey:@"appRunCount"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*) systemInformation {

  UIDevice* device = [UIDevice currentDevice];

  return [NSString stringWithFormat:@"Name:     %@<br>OS:       %@<br>Version:  %@<br>Model:    %@",
          device.name,
          device.systemName,
          device.systemVersion,
          device.model];
}

- (NSString*) appInformation {
  return [NSString stringWithFormat:@"%@ %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"], [self appVersion]];
}

- (NSString*) appVersion {
  return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (NSString*) appSupportEmail {
  return @"crossfitter-support@ikonnos.com";
  
}

////////////////////////////////////////////////
//Singleton Implementation
////////////////////////////////////////////////


+ (App *)sharedInstance
{
  if(sharedInstance == nil)
    {
    @synchronized(self)
      {
      if (sharedInstance == nil)
        sharedInstance = [[self alloc] init];
      }
    }
  
  return sharedInstance;
}
@end
