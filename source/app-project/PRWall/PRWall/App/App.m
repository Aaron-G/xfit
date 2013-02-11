//
//  App.m
//  PR Wall
//
//  Created by Cleo Barretto on 8/7/12.
//
//

#import "App.h"
#import "AppConstants.h"
#import "ModelFactory.h"
#import "UIHelper.h"
#import "ModelHelper.h"

@interface App () {
  
}

@property NSInteger applicationRunCount;

////Determines of the app menu has been displayed during this run of the app
//@property BOOL appMenuDisplayedAtStartup;

@end

@implementation App

static App *sharedInstance = nil;

@synthesize appDelegate = _appDelegate;
@synthesize userProfile = _userProfile;
@synthesize started = _started;

////////////////////////////////////////////////////////////////
//View Controllers that are "provided" by the App
//
//NOTE - If we start seeing more and more of these popping up,
//we may want to put this in a Dictionary
//
@synthesize appViewController = _appViewController;
@synthesize navigationViewController = _navigationViewController;
@synthesize measurableViewController = _measurableViewController;
@synthesize userProfileViewController = _userProfileViewController;
////////////////////////////////////////////////////////////////

- (id)init {
  self = [super init];
  if(self) {
//    self.appMenuDisplayedAtStartup = NO;
    _started = NO;
  }
  return self;
}

- (void) setAppDelegate:(AppDelegate *)appDelegate {
  
  if(!_appDelegate) {
    _appDelegate = appDelegate;
    _navigationViewController = (UINavigationController*)[[appDelegate window] rootViewController];
    _appViewController = (AppViewController*)[_navigationViewController topViewController];
  }
  
}

//CXB TODO - if too slow may need to do on another thread as
//this gets called from the main thread
- (void)startApp {
  
  //Read application run count
  //NSInteger appRunCount = [self applicationRunCount];
  
  //For now hard code the start screen at the the home screen
  [[self appViewController] displayScreenForStartUp:AppScreenIdentifierPRWall];
  
  //Initialize the file structure - needed to initialize the model
  [self initDirectoryStructure];

  //Initiialize the data model
  [self initDataModel];

  //Ensure the device is firing these events
  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];

  //Update application run count
  self.applicationRunCount = self.applicationRunCount + 1;

  _started = YES;
}

//Initializes the application data model
- (void) initDataModel {
  
  //Get reference to user profile. This also inits the default app data - if needed
  _userProfile = [ModelHelper userProfile];
}

- (void) initDirectoryStructure {
  
  NSFileManager * fileManager = [NSFileManager defaultManager];
  
  //Already created file structure
  if([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@%@", NSHomeDirectory(), UserImagesDirectory]]) {
    return;
  }
  
  NSArray* directoryPaths = [NSArray arrayWithObjects: UserImagesDirectory, UserImagesContentDirectory, UserImagesUserDirectory, UserVideosDirectory, UserVideosContentDirectory, nil];
  NSError *error = nil;
  
  for (NSString* directoryPath in directoryPaths) {
    
    if(![fileManager createDirectoryAtPath: [NSString stringWithFormat:@"%@%@", NSHomeDirectory(), directoryPath] withIntermediateDirectories:YES attributes:nil error:&error]) {
      if(error) {
        NSLog(@"Cannot create app directory path %@ with this error: %@", directoryPath, [error description]);
      }
    }
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

- (NSString*) appName {
  return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

- (NSString*) appInformation {
  return [NSString stringWithFormat:@"%@ %@", [self appName], [self appVersion]];
}

- (NSString*) appVersion {
  return [NSString stringWithFormat:@"%@ (b%@)",
          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"],
          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
}

- (NSString*) appSupportEmail {
  return @"prwall-support@ikonnos.com";
}

- (MeasurableViewController *)measurableViewController {
  
  if(!_measurableViewController) {
    _measurableViewController = (MeasurableViewController*) [UIHelper viewControllerWithViewStoryboardIdentifier: @"MeasurableViewController"];
  }  
  return _measurableViewController;
}

- (UserProfileViewController *)userProfileViewController {
  if(!_userProfileViewController) {
    _userProfileViewController = (UserProfileViewController*) [UIHelper viewControllerWithViewStoryboardIdentifier: @"UserProfileViewController"];
  }
  return _userProfileViewController;  
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
