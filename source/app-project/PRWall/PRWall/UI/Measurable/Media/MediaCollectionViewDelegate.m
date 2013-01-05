//
//  MediaCollectionViewDelegate.m
//  PR Wall
//
//  Created by Cleo Barretto on 1/2/13.
//
//

#import "MediaCollectionViewDelegate.h"
#import "MediaCollectionViewCell.h"
#import "MediaHelper.h"

@interface MediaCollectionViewDelegate ()

@end

@implementation MediaCollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
  return self.mediaProvider.images.count + self.mediaProvider.videos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MediaCollectionViewCell* cell = [cv dequeueReusableCellWithReuseIdentifier:@"MediaCollectionViewCell" forIndexPath:indexPath];
  cell.mediaButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
  
  NSInteger numberOfImages = self.mediaProvider.images.count;
  NSInteger numberOfVideos = self.mediaProvider.videos.count;
  
  if(numberOfImages > 0) {
    
    if(indexPath.item < numberOfImages) {
      [self updateMeasurableDataEntryMediaCollectionViewCell:cell withPictureContentFromIndexPath:indexPath];
    } else {
      NSInteger possibleMovieIndex = indexPath.item - numberOfImages;
      if(possibleMovieIndex < numberOfVideos) {
        [self updateMeasurableDataEntryMediaCollectionViewCell:cell withVideoContentFromIndexPath: [NSIndexPath indexPathForItem:possibleMovieIndex inSection:indexPath.section]];
      }
    }
  } else if (numberOfVideos > 0) {
    
    if(indexPath.item < numberOfVideos) {
      [self updateMeasurableDataEntryMediaCollectionViewCell:cell withVideoContentFromIndexPath: indexPath];
    }
  }
  
  return cell;
}

- (void)updateMeasurableDataEntryMediaCollectionViewCell:(MediaCollectionViewCell *)cell withPictureContentFromIndexPath:(NSIndexPath *)indexPath {
  
  NSString* imagePath = [self.mediaProvider.images objectAtIndex:indexPath.item];
  
  [self updateMeasurableDataEntryMediaCollectionViewCell:cell withImagePath:imagePath withMediaPath: imagePath withAction:@selector(displayPicture)];
}

- (void)updateMeasurableDataEntryMediaCollectionViewCell:(MediaCollectionViewCell *)cell withVideoContentFromIndexPath:(NSIndexPath *)indexPath {
  
  NSString* videoThumbnailPath = [MediaHelper thumbnailForVideo:[self.mediaProvider.videos objectAtIndex:indexPath.item] returnDefaultIfNotAvailable:YES];
  
  [self updateMeasurableDataEntryMediaCollectionViewCell:cell withImagePath:videoThumbnailPath withMediaPath: [self.mediaProvider.videos objectAtIndex:indexPath.item] withAction:@selector(displayVideo)];
}

- (void)updateMeasurableDataEntryMediaCollectionViewCell:(MediaCollectionViewCell *)cell withImagePath:(NSString*) imagePath withMediaPath:(NSString *)mediaPath withAction:(SEL) action {
  
  [cell.mediaButton setImage:[UIImage imageWithContentsOfFile:imagePath] forState:UIControlStateNormal];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
  NSInteger numberOfImages = self.mediaProvider.images.count;
  NSInteger numberOfVideos = self.mediaProvider.videos.count;
  
  if(numberOfImages > 0) {
    
    if(indexPath.item < numberOfImages) {
      [self showPictureContentFromIndexPath: indexPath];
    } else {
      NSInteger possibleMovieIndex = indexPath.item - numberOfImages;
      if(possibleMovieIndex < numberOfVideos) {
        [self showVideoContentFromIndexPath: [NSIndexPath indexPathForItem:possibleMovieIndex inSection:indexPath.section]];
      }
    }
  } else if (numberOfVideos > 0) {
    
    if(indexPath.item < numberOfVideos) {
      [self showVideoContentFromIndexPath: indexPath];
    }
  }
}

- (void)showPictureContentFromIndexPath:(NSIndexPath *)indexPath {
  [MediaHelper displayImageFullScreen:[self.mediaProvider.images objectAtIndex:indexPath.item]];
}

- (void)showVideoContentFromIndexPath:(NSIndexPath *)indexPath {
  [MediaHelper displayVideoFullScreen:[self.mediaProvider.videos objectAtIndex:indexPath.item]];
}

@end