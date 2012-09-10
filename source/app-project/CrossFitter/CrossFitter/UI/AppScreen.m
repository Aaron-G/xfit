//
//  AppScreen.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/8/12.
//
//

#import "AppScreen.h"

@interface AppScreen () {
}

@end

@implementation AppScreen

+ (AppScreenIdentifier) appScreenForScreenIndex: (NSInteger) screenIndex {

  if(screenIndex == 0) {
    return kAppScreenIdentifierHome;
  } else if(screenIndex == 1) {
    return kAppScreenIdentifierPRWall;
  } else if(screenIndex == 2) {
    return kAppScreenIdentifierWOD;
  } else if(screenIndex == 3) {
    return kAppScreenIdentifierWorkout;
  } else if(screenIndex == 4) {
    return kAppScreenIdentifierMove;
  } else if(screenIndex == 5) {
    return kAppScreenIdentifierMyBody;
  } else if(screenIndex == 6) {
    return kAppScreenIdentifierInfo;
  }
  
  return kAppScreenIdentifierHome;
}

+ (NSString*) screenNameForAppScreen: (AppScreenIdentifier) appScreen {
  
  if(appScreen == kAppScreenIdentifierHome) {
    return @"Home";
  } else if(appScreen == kAppScreenIdentifierPRWall) {
    return @"PRWall";
  } else if(appScreen == kAppScreenIdentifierWOD) {
    return @"WOD";
  } else if(appScreen == kAppScreenIdentifierWorkout) {
    return @"Workout";
  } else if(appScreen == kAppScreenIdentifierMove) {
    return @"Move";
  } else if(appScreen == kAppScreenIdentifierMyBody) {
    return @"MyBody";
  } else if(appScreen == kAppScreenIdentifierInfo) {
    return @"Info";
  }
  
  return nil;
}


@end
