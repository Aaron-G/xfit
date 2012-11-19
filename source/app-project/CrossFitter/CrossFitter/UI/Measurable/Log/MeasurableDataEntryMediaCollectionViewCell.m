//
//  MeasurableDataEntryMediaCollectionViewCell.m
//  CrossFitter
//
//  Created by Cleo Barretto on 11/16/12.
//
//

#import "MeasurableDataEntryMediaCollectionViewCell.h"
#import "ImageDisplayViewController.h"
#import "UIHelper.h"

@implementation MeasurableDataEntryMediaCollectionViewCell

- (void)displayMedia {
  [UIHelper displayImageFullScreen:[self.mediaButton backgroundImageForState:UIControlStateNormal]];
}

@end
