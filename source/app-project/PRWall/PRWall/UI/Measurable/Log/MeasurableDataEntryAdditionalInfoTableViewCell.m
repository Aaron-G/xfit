//
//  MeasurableDataEntryAdditionalInfoTableViewCell.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/10/12.
//
//

#import "MeasurableDataEntryAdditionalInfoTableViewCell.h"
#import "UIHelper.h"
#import "MediaCollectionViewDelegate.h"

@interface MeasurableDataEntryAdditionalInfoTableViewCell () <MediaCollectionViewDelegateMediaProvider>

@property MediaCollectionViewDelegate* mediaCollectionViewDelegate;

@end

@implementation MeasurableDataEntryAdditionalInfoTableViewCell

static NSInteger VERTICAL_PADDING_FROM_CELL_BORDER = 10;
static NSInteger VERTICAL_LAYOUT_PADDING = 5;
static NSInteger MEDIA_TABLE_CELL_HEIGHT = 75;

@synthesize measurableDataEntry = _measurableDataEntry;

-(id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self) {
    self.mediaCollectionViewDelegate = [[MediaCollectionViewDelegate alloc] init];
    self.mediaCollectionViewDelegate.mediaProvider = self;
  }
  
  return self;
}

- (void)setMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry {
  _measurableDataEntry = measurableDataEntry;
  
  [self updateCell];
}

- (MeasurableDataEntry *)measurableDataEntry {
  return _measurableDataEntry;
}

- (void) updateCell {
  
  //Media - images and videos
  [self.mediaCollectionView reloadData];
  
  //Comment
  self.commentTextView.text = self.measurableDataEntry.comment;

  //Update the minimum height
  [self updateMinimumHeight];
}

- (void) updateMinimumHeight {

  BOOL hasImagesOrVideos = (self.measurableDataEntry.images != nil || self.measurableDataEntry.videos != nil);
  BOOL hasComments = (self.measurableDataEntry.comment != nil);
  
  NSInteger newMinimumHeight = 0;
  
  if(hasImagesOrVideos || hasComments) {
    
    newMinimumHeight = VERTICAL_PADDING_FROM_CELL_BORDER;
    
    if (hasComments) {
      newMinimumHeight += self.commentTextView.contentSize.height;
    }
    
    if (hasImagesOrVideos) {
      
      if(hasComments) {
        newMinimumHeight += VERTICAL_LAYOUT_PADDING;
      }
      
      newMinimumHeight += MEDIA_TABLE_CELL_HEIGHT;
    }
    
    newMinimumHeight +=  VERTICAL_PADDING_FROM_CELL_BORDER;
  }
  
  self.minimumHeight = newMinimumHeight;
}

- (void) layoutCellContent {
  
  NSInteger layoutYCoordinate = VERTICAL_PADDING_FROM_CELL_BORDER;
  
  //Images and Videos Collection View
  layoutYCoordinate = [UIHelper moveToYLocation:layoutYCoordinate
                                reshapeWithSize:CGSizeMake(self.mediaCollectionView.frame.size.width, MEDIA_TABLE_CELL_HEIGHT)
                                         orHide:(self.measurableDataEntry.images == nil && self.measurableDataEntry.videos == nil)
                                           view:self.mediaCollectionView
                            withVerticalSpacing:VERTICAL_LAYOUT_PADDING];
  
  
  //Comments
  [UIHelper moveToYLocation:layoutYCoordinate
            reshapeWithSize:CGSizeMake(self.commentTextView.frame.size.width, self.commentTextView.contentSize.height)
                     orHide:(self.measurableDataEntry.comment == nil)
                       view:self.commentTextView
        withVerticalSpacing:VERTICAL_LAYOUT_PADDING];

}

- (void)layoutSubviews {
  //Have the default implementation do its thing...
  [super layoutSubviews];
  
  //Ensure the custom UI components are layout as desired
  [self layoutCellContent];
}

//////////////////////////////////////////////////////////////////////
//UICollectionViewDelegate
//////////////////////////////////////////////////////////////////////
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
  return [self.mediaCollectionViewDelegate collectionView:view numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  return [self.mediaCollectionViewDelegate collectionView:cv cellForItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [self.mediaCollectionViewDelegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

- (NSArray*)images {
  return self.measurableDataEntry.images;
}

- (NSArray*)videos {
  return self.measurableDataEntry.videos;
}

@end
