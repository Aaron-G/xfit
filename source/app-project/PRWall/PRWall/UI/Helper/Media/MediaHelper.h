//
//  MediaHelper.h
//  PR Wall
//
//  Created by Cleo Barretto on 10/26/12.
//
//

#import <Foundation/Foundation.h>

typedef enum {
  MediaHelperPurposeBodyMetric,
  MediaHelperPurposeMove,
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

+ (void) displayImageFullScreen:(NSString*) image;
+ (void) displayVideoFullScreen:(NSString*) video;


@end
