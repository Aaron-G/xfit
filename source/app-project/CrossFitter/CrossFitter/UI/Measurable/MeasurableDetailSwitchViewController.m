//
//  MeasurableDetailSwitchViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/30/12.
//
//

#import "MeasurableDetailSwitchViewController.h"
#import "UIHelper.h"

@interface MeasurableDetailSwitchViewController () {
  
}

@end

@implementation MeasurableDetailSwitchViewController

@synthesize measurable = _measurable;

- (void)setMeasurable:(id<Measurable>)measurable {
  
  _measurable = measurable;
  
  self.infoViewController.measurable = measurable;
  self.logViewController.measurable = measurable;
  
  [self reset];
}

//Resets the UI controls so that a fresh look
//to the measurable can be displayed
- (void)reset {

  NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
  
  //Reset to the info view
  [self.collectionView scrollToItemAtIndexPath:indexPath
                              atScrollPosition:UICollectionViewScrollPositionNone
                                      animated:NO];
}

- (id<Measurable>)measurable {
  return _measurable;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
  
  self = [super initWithCoder:aDecoder];
  if(self) {
    self.infoViewController = (MeasurableInfoViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier:@"MeasurableInfoViewController"];
    self.logViewController = (MeasurableLogViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier:@"MeasurableLogViewController"];    
  }
  return self;
}

-(void)viewDidLoad
{
  [super viewDidLoad];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
  if(section == 0) {
    //Info and Log Screens
    return 2;
  } else {
    return 0;
  }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

  UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MEASURABLE_CELL" forIndexPath:indexPath];

  //Clean up the cell
  for (UIView* view in [cell subviews]) {
    [view removeFromSuperview];
  }
  
  //Add appropriate sub view
  UIView* view = nil;
  if(indexPath.item == 0) {
    view = self.infoViewController.view;
  } else if(indexPath.item == 1) {
    view = self.logViewController.view;
  }
  
  if(view) {
    [cell addSubview: view];
  }

  if(self.pageControlInfoLog && indexPath.item < 2) {
    self.pageControlInfoLog.currentPage = indexPath.item;
  }
  return cell;
}


@end
