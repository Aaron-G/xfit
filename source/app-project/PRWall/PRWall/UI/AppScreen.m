//
//  AppScreen.m
//  PR Wall
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
    return AppScreenIdentifierHome;
  } else if(screenIndex == 1) {
    return AppScreenIdentifierPRWall;
  } else if(screenIndex == 2) {
    return AppScreenIdentifierWOD;
  } else if(screenIndex == 3) {
    return AppScreenIdentifierWorkout;
  } else if(screenIndex == 4) {
    return AppScreenIdentifierExercise;
  } else if(screenIndex == 5) {
    return AppScreenIdentifierMyBody;
  } else if(screenIndex == 6) {
    return AppScreenIdentifierInfo;
  }
  
  return AppScreenIdentifierHome;
}

+ (NSString*) screenNameForAppScreen: (AppScreenIdentifier) appScreen {
  
  if(appScreen == AppScreenIdentifierHome) {
    return @"Home";
  } else if(appScreen == AppScreenIdentifierPRWall) {
    return @"PRWall";
  } else if(appScreen == AppScreenIdentifierWOD) {
    return @"WOD";
  } else if(appScreen == AppScreenIdentifierWorkout) {
    return @"Workout";
  } else if(appScreen == AppScreenIdentifierExercise) {
    return @"Exercise";
  } else if(appScreen == AppScreenIdentifierMyBody) {
    return @"MyBody";
  } else if(appScreen == AppScreenIdentifierInfo) {
    return @"Info";
  }
  
  return nil;
}


@end
