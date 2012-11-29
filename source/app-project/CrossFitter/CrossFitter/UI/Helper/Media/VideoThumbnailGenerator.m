//
//  VideoThumbnailGenerator.m
//  CrossFitter
//
//  Created by Cleo Barretto on 11/22/12.
//
//

#import <MediaPlayer/MediaPlayer.h>
#import "VideoThumbnailGenerator.h"
#import "MediaHelper.h"

@interface VideoThumbnailGenerator () {
  
}

@property (strong) MPMoviePlayerController* moviePlayerController;
@property (strong) NSString* video;

- (void) movieStateChanged:(NSNotification*)notification;

@end

@implementation VideoThumbnailGenerator

- (void) generateThumbnailForVideo:(NSString*) video {
  
  self.video = video;
  
  NSURL* url = [NSURL fileURLWithPath:video isDirectory:NO];
  
  self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL: url];
  self.moviePlayerController.shouldAutoplay = NO;
  
  self.moviePlayerController.movieSourceType = MPMovieSourceTypeFile;
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(movieStateChanged:)
                                               name:MPMoviePlayerPlaybackStateDidChangeNotification
                                             object:self.moviePlayerController];
  [self.moviePlayerController prepareToPlay];
  
  //  [[NSNotificationCenter defaultCenter] addObserver:self
  //                                           selector:@selector(movieStateChangedError:)
  //                                               name:MPMoviePlayerPlaybackDidFinishNotification
  //                                             object:self.moviePlayerController.moviePlayer];
  
}

//- (void) movieStateChangedError:(NSNotification*)notification {
//}

- (void) movieStateChanged:(NSNotification*)notification {
  
  int loadState = self.moviePlayerController.loadState;
  
  if(loadState & MPMovieLoadStatePlayable) {


    UIImage* thumbnail = [self.moviePlayerController thumbnailImageAtTime:0.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
    
    
    if(thumbnail) {
      
      //1- Report generation completion
      NSString* thumbnailPath = [MediaHelper thumbnailForVideo:self.video returnDefaultIfNotAvailable:NO];
      
      if([MediaHelper saveImage:thumbnail withPath:thumbnailPath]) {
        [self.delegate didGenerateThumbnailForVideo:self.video];
      } else {
        [self.delegate didNotGenerateThumbnailForVideo:self.video];
      }
    
  } else {
    [self.delegate didNotGenerateThumbnailForVideo:self.video];
  }
  
  //2- Wrap up the video player
  //[self.moviePlayerController stop];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  
  }
}


@end