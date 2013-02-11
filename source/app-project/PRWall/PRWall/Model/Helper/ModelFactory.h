//
//  ModelFactory.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import <Foundation/Foundation.h>
#import "UserProfile.h"

@interface ModelFactory : NSObject

+ (UserProfile*) createAppDefaultUserProfile;
+ (BOOL) createAppUnits;
+ (BOOL) createAppMeasurableCategories;
+ (BOOL) createAppBodyMetricsForUserProfile: (UserProfile*) userProfile;
+ (BOOL) createAppExercisesForUserProfile: (UserProfile*) userProfile;

@end
