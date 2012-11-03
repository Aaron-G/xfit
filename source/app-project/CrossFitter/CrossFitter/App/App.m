//
//  App.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/7/12.
//
//

#import "App.h"
#import "AppConstants.h"
#import "ModelFactory.h"
#import "UIHelper.h"

@interface App () {
  
}

@property NSInteger applicationRunCount;

//Determines of the app menu has been displayed during this run of the app
@property BOOL appMenuDisplayedAtStartup;

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
    self.appMenuDisplayedAtStartup = NO;
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
  [[self appViewController] displayScreenForStartUp:AppScreenIdentifierHome];
  
  
  //CXB_TODO - uncomment this once stable
  //If first time - initialize model
  //if(appRunCount == 0) {
    [self initDataModel];
  
    [self initDirectoryStructure];
  //}
  
  _started = YES;
}

//Show and Hide the Application menu after a short moment - only the first
//few times the user has run the app
- (void) displayAppMenuIfNeeded {

  //IMPL NOTE
  //Ideally this should be part of the startApp, but due to timing during the application
  //boot sequence, we have to call this separately from the AppViewController.viewWillAppear

  if(!self.appMenuDisplayedAtStartup) {
    
    //Read application run count
    NSInteger appRunCount = [self applicationRunCount];
    
    //appRunCount starts at zero
    if(appRunCount < NumberOfRunsToShowHelp) {
      
      [[self appViewController] showOrHideMenuWithDelay:1.5 withAutoHideDelay:2];
      
      //Update control flag
      self.appMenuDisplayedAtStartup = YES;
      
      //Save application run count - only for the same of keeping track on this
      //So no need to keep track of it later
      self.applicationRunCount = ++appRunCount;
    }
  }
}

//Initializes the application data model
- (void) initDataModel {
  
  //User Profile
  _userProfile = [ModelFactory createDefaultUserProfile];

  //Body Metrics
  NSDictionary* metrics = [ModelFactory createDefaultBodyMetrics];
  _userProfile.metrics = metrics;
  
  //Moves
  
  //Workouts
  
  //WODs
  
}

- (void) initDirectoryStructure {
  
  NSFileManager * fileManager = [NSFileManager defaultManager];
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

- (NSString*) appInformation {
  return [NSString stringWithFormat:@"%@ %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"], [self appVersion]];
}

- (NSString*) appVersion {
  return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (NSString*) appSupportEmail {
  return @"crossfitter-support@ikonnos.com";
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
