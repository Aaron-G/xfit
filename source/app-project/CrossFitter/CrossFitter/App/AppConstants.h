//
//  AppConstants.h
//  CrossFitter
//
//  Created by Cleo Barretto on 8/10/12.
//
//

#import <Foundation/Foundation.h>


@interface AppConstants : NSObject

//Duration of animation when switching screens
extern const CGFloat ScreenSwitchAnimationDuration;
extern const NSInteger NumberOfRunsToShowHelp;

extern NSString* UserImagesDirectory;
extern NSString* UserImagesContentDirectory;
extern NSString* UserImagesUserDirectory;

extern NSString* UserVideosDirectory;
extern NSString* UserVideosContentDirectory;

extern NSString* UserProfileImageName;
extern NSString* UserProfileDefaultImageName;

extern NSString* MoveImageNamePreffix;
extern NSString* WorkoutImageNamePreffix;
extern NSString* WODImageNamePreffix;
extern NSString* BodyMetricImageNamePreffix;

extern NSString* MoveVideoNamePreffix;
extern NSString* WorkoutVideoNamePreffix;
extern NSString* WODVideoNamePreffix;
extern NSString* BodyMetricVideoNamePreffix;

extern NSString* TableViewSectionTitleSpacer;

@end