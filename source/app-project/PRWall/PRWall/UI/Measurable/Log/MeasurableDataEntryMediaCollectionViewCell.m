//
//  MeasurableDataEntryMediaCollectionViewCell.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/16/12.
//
//

#import "MeasurableDataEntryMediaCollectionViewCell.h"
#import "ImageDisplayViewController.h"
#import "MediaHelper.h"

@implementation MeasurableDataEntryMediaCollectionViewCell

- (void)displayPicture {
  [MediaHelper displayImageFullScreen:self.mediaPath];
}

- (void)displayVideo {
  [MediaHelper displayVideoFullScreen:self.mediaPath];
}

@end
