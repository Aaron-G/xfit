//
//  AppScreen.h
//  CrossFitter
//
//  Created by Cleo Barretto on 8/8/12.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
  kAppScreenIdentifierInfo,
  kAppScreenIdentifierHome,
  kAppScreenIdentifierMove,
  kAppScreenIdentifierMyBody,
  kAppScreenIdentifierPRWall,
  kAppScreenIdentifierWorkout,
  kAppScreenIdentifierWOD
} AppScreenIdentifier;

@interface AppScreen : NSObject

//Returns the AppScreenIdentifer for the provided index
//for the order that the screen is displayed
+ (AppScreenIdentifier) appScreenForScreenIndex: (NSInteger) screenIndex;

//Returns a screen name that can be used to identify the provoded screen
//for programatic purposes
+ (NSString*) screenNameForAppScreen: (AppScreenIdentifier) appScreen;
@end


