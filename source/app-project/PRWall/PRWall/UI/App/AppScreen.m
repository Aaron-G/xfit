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
    return AppScreenIdentifierPRWall;
  } else if(screenIndex == 1) {
    return AppScreenIdentifierWorkout;
  } else if(screenIndex == 2) {
    return AppScreenIdentifierExercise;
  } else if(screenIndex == 3) {
    return AppScreenIdentifierMyBody;
  } else if(screenIndex == 4) {
    return AppScreenIdentifierInfo;
  }
  
  return AppScreenIdentifierPRWall;
}

+ (NSString*) screenNameForAppScreen: (AppScreenIdentifier) appScreen {
  
  if(appScreen == AppScreenIdentifierPRWall) {
    return @"PRWall";
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
