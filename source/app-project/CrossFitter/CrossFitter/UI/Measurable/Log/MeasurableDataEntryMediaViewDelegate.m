//
//  MeasurableDataEntryMediaViewDelegate.m
//  CrossFitter
//
//  Created by Cleo Barretto on 11/15/12.
//
//

#import "MeasurableDataEntryMediaViewDelegate.h"
#import "MeasurableDataEntryMediaCollectionViewCell.h"
#import "UIHelper.h"

@interface MeasurableDataEntryMediaViewDelegate ()

@end

@implementation MeasurableDataEntryMediaViewDelegate

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
  //CXB TODO - Add video count too
  return self.measurableDataEntry.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  MeasurableDataEntryMediaCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MeasurableDataEntryMediaCollectionViewCell" forIndexPath:indexPath];
  
  UIImage *image = [self.measurableDataEntry.images objectAtIndex:indexPath.item];
  SEL action = @selector(displayMedia);
  
  [cell.mediaButton setBackgroundImage:image forState:UIControlStateNormal];
  
  //Remove the previous target
  [cell.mediaButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
  
  //Add the new target
  [cell.mediaButton addTarget:cell action:action forControlEvents:UIControlEventTouchUpInside];
  
  return cell;
}

@end
