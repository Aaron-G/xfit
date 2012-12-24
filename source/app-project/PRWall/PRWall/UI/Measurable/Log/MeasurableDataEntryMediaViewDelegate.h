//
//  MeasurableDataEntryMediaViewDelegate.h
//  PR Wall
//
//  Created by Cleo Barretto on 11/15/12.
//
//

#import <UIKit/UIKit.h>
#import "MeasurableDataEntry.h"

@interface MeasurableDataEntryMediaViewDelegate : NSObject <UICollectionViewDelegate>

@property MeasurableDataEntry* measurableDataEntry;

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
