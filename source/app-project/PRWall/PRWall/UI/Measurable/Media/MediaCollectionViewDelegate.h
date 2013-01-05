//
//  MediaCollectionViewDelegate.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/2/13.
//
//

#import <Foundation/Foundation.h>

@protocol MediaCollectionViewDelegateMediaProvider <NSObject>

@property (readonly) NSArray* videos;
@property (readonly) NSArray* images;

@end

@interface MediaCollectionViewDelegate : NSObject <UICollectionViewDelegate>

@property id<MediaCollectionViewDelegateMediaProvider> mediaProvider;

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
