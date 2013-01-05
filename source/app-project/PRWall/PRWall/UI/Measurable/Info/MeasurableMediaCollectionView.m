//
//  MeasurableMediaCollectionView.m
//  PR Wall
//
//  Created by Cleo Barretto on 1/1/13.
//
//

#import "MeasurableMediaCollectionView.h"
#import "MediaCollectionViewCell.h"

@implementation MeasurableMediaCollectionView

- (void)setFrame:(CGRect)frame {
  
  //IMPL NOTE
  //If we do not enforce this height the UICollectionViewFlowLayout
  //fails to layout the MeasurableMediaCollectionView appropriately
  [super setFrame: CGRectMake(frame.origin.x, frame.origin.y, MediaCollectionViewCellWidth, MediaCollectionViewCellHeight)];
}

@end
