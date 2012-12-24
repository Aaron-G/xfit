//
//  MeasurableDataEntryMediaViewDelegate.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/15/12.
//
//

#import "MeasurableDataEntryMediaViewDelegate.h"
#import "MeasurableDataEntryMediaCollectionViewCell.h"
#import "UIHelper.h"
#import "AppConstants.h"
#import "MediaHelper.h"

@interface MeasurableDataEntryMediaViewDelegate ()

@end

@implementation MeasurableDataEntryMediaViewDelegate

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
  return self.measurableDataEntry.images.count + self.measurableDataEntry.videos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  MeasurableDataEntryMediaCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MeasurableDataEntryMediaCollectionViewCell" forIndexPath:indexPath];
  cell.mediaButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
  
  NSInteger numberOfImages = self.measurableDataEntry.images.count;
  NSInteger numberOfVideos = self.measurableDataEntry.videos.count;
  
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

- (void)updateMeasurableDataEntryMediaCollectionViewCell:(MeasurableDataEntryMediaCollectionViewCell *)cell withPictureContentFromIndexPath:(NSIndexPath *)indexPath {

  NSString* imagePath = [self.measurableDataEntry.images objectAtIndex:indexPath.item];
  
  [self updateMeasurableDataEntryMediaCollectionViewCell:cell withImagePath:imagePath withMediaPath: imagePath withAction:@selector(displayPicture)];
}

- (void)updateMeasurableDataEntryMediaCollectionViewCell:(MeasurableDataEntryMediaCollectionViewCell *)cell withVideoContentFromIndexPath:(NSIndexPath *)indexPath {
  
  NSString* videoThumbnailPath = [MediaHelper thumbnailForVideo:[self.measurableDataEntry.videos objectAtIndex:indexPath.item] returnDefaultIfNotAvailable:YES];
  
  [self updateMeasurableDataEntryMediaCollectionViewCell:cell withImagePath:videoThumbnailPath withMediaPath: [self.measurableDataEntry.videos objectAtIndex:indexPath.item] withAction:@selector(displayVideo)];
}

- (void)updateMeasurableDataEntryMediaCollectionViewCell:(MeasurableDataEntryMediaCollectionViewCell *)cell withImagePath:(NSString*) imagePath withMediaPath:(NSString *)mediaPath withAction:(SEL) action {

  cell.mediaPath = mediaPath;
  [cell.mediaButton setImage:[UIImage imageWithContentsOfFile:imagePath] forState:UIControlStateNormal];
  
  //Remove the previous target
  [cell.mediaButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
  
  //Add the new target
  [cell.mediaButton addTarget:cell action:action forControlEvents:UIControlEventTouchUpInside];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
}

@end
