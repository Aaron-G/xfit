//
//  MediaHelper.m
//  CrossFitter
//
//  Created by Cleo Barretto on 10/26/12.
//
//

#import "MediaHelper.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppConstants.h"
#import "UIHelper.h"
#import "AppViewControllerSegue.h"

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

+ (NSURL*) saveImage:(UIImage*) image forPurpose: (MediaHelperPurpose) purpose {
  return [MediaHelper saveMedia: UIImagePNGRepresentation(image) forPurpose: purpose forMediaType: MediaHelperMediaTypeImage];
}

+ (NSURL*) saveVideo:(NSURL*) videoURL forPurpose: (MediaHelperPurpose) purpose {
  return [MediaHelper saveMedia: videoURL forPurpose: purpose forMediaType: MediaHelperMediaTypeVideo];
}

+ (NSURL*) saveMedia:(id) media forPurpose: (MediaHelperPurpose) purpose forMediaType: (MediaHelperMediaType) mediaType {
  
  NSString* directoryPath = nil;
  NSString* mediaName = nil;
  
  NSString* mediaCountKey = nil;
  
  if(MediaHelperPurposeUserProfile == purpose) {
    
    if(MediaHelperMediaTypeImage == mediaType) {
      directoryPath = UserImagesUserDirectory;
      mediaName = UserProfileImageName;
    }
    
  } else if (MediaHelperPurposeMove == purpose) {
    
    if(MediaHelperMediaTypeImage == mediaType) {
      directoryPath = UserImagesContentDirectory;
      mediaName = MoveImageNamePreffix;
      mediaCountKey = MoveImageCountKey;
    } else if (MediaHelperMediaTypeVideo == mediaType) {
      directoryPath = UserVideosContentDirectory;
      mediaName = MoveVideoNamePreffix;
      mediaCountKey = MoveVideoCountKey;
    }
    
  } else if (MediaHelperPurposeWOD == purpose) {
    
    if(MediaHelperMediaTypeImage == mediaType) {
      directoryPath = UserImagesContentDirectory;
      mediaName = WODImageNamePreffix;
      mediaCountKey = WODImageCountKey;
    } else if (MediaHelperMediaTypeVideo == mediaType) {
      directoryPath = UserVideosContentDirectory;
      mediaName = WODVideoNamePreffix;
      mediaCountKey = WODVideoCountKey;
    }
    
  } else if (MediaHelperPurposeWorkout == purpose) {
    
    if(MediaHelperMediaTypeImage == mediaType) {
      directoryPath = UserImagesContentDirectory;
      mediaName = WorkoutImageNamePreffix;
      mediaCountKey = WorkoutImageCountKey;
    } else if (MediaHelperMediaTypeVideo == mediaType) {
      directoryPath = UserVideosContentDirectory;
      mediaName = WorkoutVideoNamePreffix;
      mediaCountKey = WorkoutVideoCountKey;
    }
    
  } else if (MediaHelperPurposeBodyMetric == purpose) {
    
    if(MediaHelperMediaTypeImage == mediaType) {
      directoryPath = UserImagesContentDirectory;
      mediaName = BodyMetricImageNamePreffix;
      mediaCountKey = BodyMetricImageCountKey;
    } else if (MediaHelperMediaTypeVideo == mediaType) {
      directoryPath = UserVideosContentDirectory;
      mediaName = BodyMetricVideoNamePreffix;
      mediaCountKey = BodyMetricVideoCountKey;
    }
    
  }
  
  if(mediaName && directoryPath) {
    
    NSString* fileExtension = nil;
    if(MediaHelperMediaTypeImage == mediaType) {
      fileExtension = @"png";
    } else if(MediaHelperMediaTypeVideo == mediaType) {
      fileExtension = [((NSURL*)media).path pathExtension];
    }
    
    if(mediaCountKey) {
      NSInteger mediaCount = [MediaHelper countForKey:mediaCountKey];
      mediaName = [NSString stringWithFormat: @"%@%d.%@", mediaName, mediaCount, fileExtension];
    }
    //Only 1 user profile image is kept so no need to keep a media count
    else {
      //CXB TODO replace with NSString stringsByAppendingPaths
      mediaName = [NSString stringWithFormat: @"%@.%@", mediaName, fileExtension];
    }
    
    NSString* filePath = [NSString stringWithFormat:@"%@%@", NSHomeDirectory(), [NSString stringWithFormat:@"%@%@", directoryPath, mediaName]];
    
    if(MediaHelperMediaTypeImage == mediaType) {
      return [MediaHelper saveData:(NSData*)media withPath:filePath withCountKey:mediaCountKey];
    } else if(MediaHelperMediaTypeVideo == mediaType) {
      return [MediaHelper copyFileAtPath:((NSURL*)media).path toPath: filePath withCountKey: mediaCountKey];
    }
  }
  
  return nil;
}

+ (NSURL*) saveData:(NSData*) data withPath: (NSString*) filePath withCountKey: (NSString*) countKey {
  
  NSURL* fileURL = nil;
  
  BOOL success = [[NSFileManager defaultManager] createFileAtPath:filePath
                                                         contents:data
                                                       attributes:nil];
  
  if(success) {
    if (countKey) {
      [MediaHelper setCount: ([MediaHelper countForKey: countKey]+1) forKey: countKey];
    }
    
    fileURL = [NSURL fileURLWithPath:filePath];
  }
  
  return fileURL;
}

+ (NSURL*) saveImage:(UIImage*) image withPath: (NSString*) filePath {
  return [MediaHelper saveData:UIImagePNGRepresentation(image) withPath: filePath withCountKey:nil];
}


+ (NSURL*) copyFileAtPath:(NSString*) fromPath toPath: (NSString*) toPath withCountKey: (NSString*) countKey {
  
  NSURL* fileURL = nil;
  
  NSError* error;

  BOOL success = [[NSFileManager defaultManager] copyItemAtPath:fromPath toPath:toPath error:&error];
  
  if(success) {
    if (countKey) {
      [MediaHelper setCount: ([MediaHelper countForKey: countKey]+1) forKey: countKey];
    }
    
    fileURL = [NSURL fileURLWithPath:toPath];
  } else if(error) {
    NSLog(@"Could not copy file from '%@' to '%@' with this error: '%@'", fromPath, toPath, [error localizedDescription]);
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

+ (BOOL) enoughSpaceForVideo:(NSURL*) video {
  
  NSError* error;
  
  NSDictionary* fileSystemProperties = [[NSFileManager defaultManager]attributesOfFileSystemForPath:[NSString stringWithFormat:@"%@%@", NSHomeDirectory(), UserVideosDirectory] error:&error];
  
  if(!error) {
    NSDictionary* properties = [[NSFileManager defaultManager] attributesOfItemAtPath:video.path error:&error];
    NSNumber* size = [properties objectForKey: NSFileSize];
    NSNumber* freeSpace = [fileSystemProperties objectForKey:NSFileSystemFreeSize];
    //NSLog(@"%@ - %@", size, video.path);
    
    return (freeSpace.intValue >= size.intValue);
  } else {
    return NO;
  }
}

+ (NSString*) thumbnailForVideo:(NSString*) video returnDefaultIfNotAvailable:(BOOL) returnDefault {

  NSString* videoFileName = [video substringToIndex: (video.length - 4)];
  NSString* videoThumbnailFileName = [NSString stringWithFormat:@"%@%@", videoFileName, UserVideosThumbnailImageNameSuffix];
  
  if((!returnDefault) || [[NSFileManager defaultManager] fileExistsAtPath:videoThumbnailFileName]) {
    return videoThumbnailFileName;
  } else {
    return [NSString stringWithFormat:@"%@/%@", [NSBundle mainBundle].resourcePath, UserVideosDefaultThumbnailImageName];
  }  
}

+ (void) displayImageFullScreen:(NSString*) image {
  
  ImageDisplayViewController* imageDisplayViewController = [UIHelper imageDisplayViewController];
  imageDisplayViewController.image = [UIImage imageWithContentsOfFile:image];

  [UIHelper showViewController:imageDisplayViewController asModal:YES withTransitionTitle:@"To Image Display"];
}

+ (void) displayVideoFullScreen:(NSString*) video {
  
  NSURL* url = [NSURL fileURLWithPath:video isDirectory:NO];

  MPMoviePlayerViewController* moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL: url];
  moviePlayerController.moviePlayer.shouldAutoplay = NO;
  
  moviePlayerController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
  [moviePlayerController.moviePlayer prepareToPlay];

  [UIHelper showViewController:moviePlayerController asModal:YES withTransitionTitle:@"To Video Display"];
}

@end
