//
//  MediaHelper.h
//  PR Wall
//
//  Created by Cleo Barretto on 10/26/12.
//
//

#import <Foundation/Foundation.h>
#import "Media.h"

typedef enum {
  MediaHelperPurposeBodyMetric,
  MediaHelperPurposeExercise,
  MediaHelperPurposeUserProfile,
  MediaHelperPurposeWorkout,
  MediaHelperPurposeWOD
} MediaHelperPurpose;

@interface MediaHelper : NSObject

//Returns an NSURL instance if the save succeeded, nil otherwise.
+ (NSURL*) saveImage:(UIImage*) image forPurpose: (MediaHelperPurpose) purpose;

//Returns an NSURL instance if the save succeeded, nil otherwise.
+ (NSURL*) saveImage:(UIImage*) image withPath: (NSString*) filePath;

//Returns an NSURL instance if the save succeeded, nil otherwise.
+ (NSURL*) saveVideo:(NSURL*) video forPurpose: (MediaHelperPurpose) purpose;

+ (BOOL) enoughSpaceForImage:(UIImage*) image;
+ (BOOL) enoughSpaceForVideo:(NSURL*) video;

+ (NSString*) thumbnailForVideo:(NSString*) video returnDefaultIfNotAvailable:(BOOL) returnDefault;

+ (void) displayImageFullScreen:(Media*) image;
+ (void) displayVideoFullScreen:(Media*) video;

+ (void) moveMediaAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath inVideos:(NSArray*) videos inVideosSection:(NSInteger) videosSection orInImages:(NSArray*) images inImagesSection:(NSInteger) imagesSection;


@end