//
//  MediaHelper.h
//  CrossFitter
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

//+ (BOOL) saveVideo:(UIVideo*) image forPurpose: (MediaHelperPurpose) purpose;

+ (BOOL) enoughSpaceForImage:(UIImage*) image;

@end
