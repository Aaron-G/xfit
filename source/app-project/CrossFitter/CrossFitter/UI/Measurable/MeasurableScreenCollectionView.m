//
//  MeasurableScreenCollectionView.m
//  CrossFitter
//
//  Created by Cleo Barretto on 12/15/12.
//
//

#import "MeasurableScreenCollectionView.h"

@implementation MeasurableScreenCollectionView

const NSInteger MINIMUM_SCREEN_COLLECTION_VIEW_HEIGHT = 392;

- (void)setFrame:(CGRect)frame {
  
  //IMPL NOTE
  //If we do not enforce this height the UICollectionViewFlowLayout
  //fails to layout the MeasurableScreenCollectionView appropriately
  [super setFrame: CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, MINIMUM_SCREEN_COLLECTION_VIEW_HEIGHT)];
}
@end
