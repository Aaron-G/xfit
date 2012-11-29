//
//  VideoThumbnailGenerator.h
//  CrossFitter
//
//  Created by Cleo Barretto on 11/22/12.
//
//

#import <Foundation/Foundation.h>

@protocol VideoThumbnailGeneratorDelegate <NSObject>

- (void)didGenerateThumbnailForVideo:(NSString*) video;
- (void)didNotGenerateThumbnailForVideo:(NSString*) video;

@end

@interface VideoThumbnailGenerator : NSObject

@property id<VideoThumbnailGeneratorDelegate> delegate;

- (void) generateThumbnailForVideo:(NSString*) video;

@end

