//
//  MediaHelper.m
//  CrossFitter
//
//  Created by Cleo Barretto on 10/26/12.
//
//

#import "MediaHelper.h"
#import "AppConstants.h"

@interface MediaHelper ()

@end

NSString* BodyMetricImageCountKey = @"bodyMetricImageCount";
NSString* MoveImageCountKey = @"moveImageCount";
NSString* WorkoutImageCountKey = @"workoutImageCount";
NSString* WODImageCountKey = @"wodImageCount";

NSString* BodyMetricVideoCountKey = @"bodyMetricVideoCount";
NSString* MoveVideoCountKey = @"moveVideoCount";
NSString* WorkoutVideoCountKey = @"workoutVideoCount";
NSString* WODVideoCountKey = @"wodVideoCount";

typedef enum {
  MediaHelperMediaTypeImage,
  MediaHelperMediaTypeVideo
} MediaHelperMediaType;

@implementation MediaHelper

//IMPL NOTE
//This will be needed for video saves
//
//+ (NSURL*) saveVideo:(UIVideo*) image forPurpose: (MediaHelperPurpose) purpose {
//  return [MediaHelper save: UIImagePNGRepresentation(image) forPurpose: purpose forMediaType: MediaHelperMediaTypeImage];
//}

+ (NSURL*) saveImage:(UIImage*) image forPurpose: (MediaHelperPurpose) purpose {
  return [MediaHelper save: UIImagePNGRepresentation(image) forPurpose: purpose forMediaType: MediaHelperMediaTypeImage];
}

+ (NSURL*) save:(NSData*) data forPurpose: (MediaHelperPurpose) purpose forMediaType: (MediaHelperMediaType) mediaType {
  
  NSString* directoryPath = nil;
  NSString* imageName = nil;
  
  NSString* imageCountKey = nil;
  NSInteger imageCount;
  
  if(MediaHelperPurposeUserProfile == purpose) {
    
    directoryPath = UserImagesUserDirectory;
    imageName = UserProfileImageName;
    
  } else if (MediaHelperPurposeMove == purpose) {

    if(MediaHelperMediaTypeImage == mediaType) {
      directoryPath = UserImagesContentDirectory;
      imageName = MoveImageNamePreffix;
      imageCountKey = MoveImageCountKey;
    } else if (MediaHelperMediaTypeVideo == mediaType) {
      directoryPath = UserVideosContentDirectory;
      imageName = MoveVideoNamePreffix;
      imageCountKey = MoveVideoCountKey;
    }
    
  } else if (MediaHelperPurposeWOD == purpose) {
    
    if(MediaHelperMediaTypeImage == mediaType) {
      directoryPath = UserImagesContentDirectory;
      imageName = WODImageNamePreffix;
      imageCountKey = WODImageCountKey;
    } else if (MediaHelperMediaTypeVideo == mediaType) {
      directoryPath = UserVideosContentDirectory;
      imageName = WODVideoNamePreffix;
      imageCountKey = WODVideoCountKey;
    }
    
  } else if (MediaHelperPurposeWorkout == purpose) {
    
    if(MediaHelperMediaTypeImage == mediaType) {
      directoryPath = UserImagesContentDirectory;
      imageName = WorkoutImageNamePreffix;
      imageCountKey = WorkoutImageCountKey;
    } else if (MediaHelperMediaTypeVideo == mediaType) {
      directoryPath = UserVideosContentDirectory;
      imageName = WorkoutVideoNamePreffix;
      imageCountKey = WorkoutVideoCountKey;
    }
    
  } else if (MediaHelperPurposeBodyMetric == purpose) {
    
    if(MediaHelperMediaTypeImage == mediaType) {
      directoryPath = UserImagesContentDirectory;
      imageName = BodyMetricImageNamePreffix;
      imageCountKey = BodyMetricImageCountKey;
    } else if (MediaHelperMediaTypeVideo == mediaType) {
      directoryPath = UserVideosContentDirectory;
      imageName = BodyMetricVideoNamePreffix;
      imageCountKey = BodyMetricVideoCountKey;
    }
    
  } else {
    return NO;
  }
  
  if(imageCountKey) {
    imageCount = [MediaHelper countForKey:imageCountKey];
    imageName = [NSString stringWithFormat: @"%@%d.png", imageName, imageCount];
  }
  
  return [MediaHelper saveData: data withPath: [NSString stringWithFormat:@"%@%@", directoryPath, imageName] withCountKey: imageCountKey];
}


+ (NSURL*) saveData:(NSData*) data withPath: (NSString*) filePath withCountKey: (NSString*) countKey {
  
  NSURL* fileURL = nil;
  
  NSString* finalFilePath = [NSString stringWithFormat:@"%@%@", NSHomeDirectory(), filePath];
  
  BOOL success = [[NSFileManager defaultManager] createFileAtPath:finalFilePath
                                                         contents:data
                                                       attributes:nil];
  if(success) {
    if (countKey) {
      [MediaHelper setCount: ([MediaHelper countForKey: countKey]+1) forKey: countKey];
    }
    
    fileURL = [NSURL fileURLWithPath:finalFilePath];
  }
  
  return fileURL;
}

+ (NSInteger) countForKey: (NSString*) key {
  return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+ (void) setCount:(NSInteger) count forKey: (NSString*) key{
  [[NSUserDefaults standardUserDefaults] setInteger:count forKey:key];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL) enoughSpaceForImage:(UIImage*) image {
  
  NSError* error;
  
  NSDictionary* fileSystemProperties = [[NSFileManager defaultManager]attributesOfFileSystemForPath:[NSString stringWithFormat:@"%@%@", NSHomeDirectory(), UserImagesDirectory] error:&error];
  
  if(!error) {    
    NSData* imageData = UIImagePNGRepresentation(image);
    NSNumber* freeSpace = [fileSystemProperties objectForKey:NSFileSystemFreeSize];
    return (freeSpace.intValue >= imageData.length);
  } else {
    return NO;
  }
}

@end
