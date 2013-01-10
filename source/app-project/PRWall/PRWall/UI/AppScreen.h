//
//  AppScreen.h
//  PR Wall
//
//  Created by Cleo Barretto on 8/8/12.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
  AppScreenIdentifierInfo,
  AppScreenIdentifierExercise,
  AppScreenIdentifierMyBody,
  AppScreenIdentifierPRWall,
  AppScreenIdentifierWorkout,
} AppScreenIdentifier;

@interface AppScreen : NSObject

//Returns the AppScreenIdentifer for the provided index
//for the order that the screen is displayed
+ (AppScreenIdentifier) appScreenForScreenIndex: (NSInteger) screenIndex;

//Returns a screen name that can be used to identify the provoded screen
//for programatic purposes
+ (NSString*) screenNameForAppScreen: (AppScreenIdentifier) appScreen;
@end


