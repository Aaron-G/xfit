//
//  MeasurablePickerCollectionView.m
//  PR Wall
//
//  Created by Cleo Barretto on 1/2/13.
//
//

#import "MeasurablePickerCollectionView.h"

@interface MeasurablePickerCollectionView ()

//We have a special property for the item height as the height changes
//depending on which device we are running iphone 4, 4s or 5.
@property (readonly) CGFloat itemHeight;

@end

@implementation MeasurablePickerCollectionView

@synthesize itemHeight = _itemHeight;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self) {
    
    UICollectionViewFlowLayout* flowLayout = (UICollectionViewFlowLayout*)self.collectionViewLayout;
    
    [self updateItemHeightBasedOnRunningDevice];
    
    flowLayout.itemSize = CGSizeMake(flowLayout.itemSize.width, self.itemHeight);
  }
  return self;
}

- (void)setFrame:(CGRect)frame {
  
  //IMPL NOTE
  //If we do not enforce this height the UICollectionViewFlowLayout
  //fails to layout the MeasurableScreenCollectionView appropriately
  [super setFrame: CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, self.itemHeight)];
}

- (void)updateItemHeightBasedOnRunningDevice {
  
  //iPhone 3Gs, 4 and 4s
  if([[UIScreen mainScreen] bounds].size.height == 480) {
    _itemHeight = 460;
  }
  
  //iPhone 5
  else if ([[UIScreen mainScreen] bounds].size.height == 568) {
    _itemHeight = 548;
  }
}

@end
