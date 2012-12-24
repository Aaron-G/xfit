//
//  AppConstants.m
//  PR Wall
//
//  Created by Cleo Barretto on 8/10/12.
//
//

#import "AppConstants.h"

@implementation AppConstants

const CGFloat ScreenSwitchAnimationDuration = 0.3;
const NSInteger NumberOfRunsToShowHelp = 3;

const NSString* UserImagesDirectory = @"/Documents/Images/";
const NSString* UserImagesContentDirectory = @"/Documents/Images/Content/";
const NSString* UserImagesUserDirectory = @"/Documents/Images/User/";

const NSString* UserVideosDirectory = @"/Documents/Videos/";
const NSString* UserVideosContentDirectory = @"/Documents/Videos/Content/";
const NSString* UserVideosDefaultThumbnailImageName = @"default-video-thumbnail.png";
const NSString* UserVideosThumbnailImageNameSuffix = @"-thumbnail.png";

const NSString* UserProfileImageName = @"user-profile-image";
const NSString* UserProfileDefaultImageName = @"default-user-profile-image.png";

const NSString* MoveImageNamePreffix = @"move-image-";
const NSString* WorkoutImageNamePreffix = @"workout-image-";
const NSString* WODImageNamePreffix = @"wod-image-";
const NSString* BodyMetricImageNamePreffix = @"bodymetric-image-";

const NSString* MoveVideoNamePreffix = @"move-video-";
const NSString* WorkoutVideoNamePreffix = @"workout-video-";
const NSString* WODVideoNamePreffix = @"wod-video-";
const NSString* BodyMetricVideoNamePreffix = @"bodymetric-video-";

//This is used as a blank header title in UITableView sections to provide additional spacing
//at the top between the given section and the previous section or the previous UI component
//if this is the first section
const NSString* TableViewSectionTitleSpacer = @" ";
@end
