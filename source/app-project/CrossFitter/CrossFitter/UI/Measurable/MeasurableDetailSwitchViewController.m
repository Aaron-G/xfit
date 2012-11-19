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
@synthesize measurableViewController = _measurableViewController;
@synthesize logToolbarItems = _logToolbarItems;
@synthesize infoToolbarItems = _infoToolbarItems;

-(void)setMeasurableViewController:(MeasurableViewController *)measurableViewController {
  
  _measurableViewController = measurableViewController;
  
  self.measurable = measurableViewController.measurable;
}

- (MeasurableViewController *)measurableViewController {
  return _measurableViewController;
}

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

  UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MeasurableViewControllerCollectionViewCell_StoryBoard" forIndexPath:indexPath];

  //Clean up the cell
  for (UIView* view in [cell subviews]) {
    [view removeFromSuperview];
  }
  
  //Add appropriate sub view
  UIView* view = nil;
  if(indexPath.item == 0) {
    view = self.logViewController.view;
  } else if(indexPath.item == 1) {
    view = self.infoViewController.view;
  }
  
  if(view) {
    [cell addSubview: view];
  }

  //Update the page control
  if(indexPath.item < 2) {
    self.measurableViewController.measurableDetailPageControl.currentPage = indexPath.item;
  }
  NSArray* toolbarItems = nil;
  
  //Update the toolbar buttons
  if(indexPath.item == 0) {
    toolbarItems = [self logToolbarItems];    
  } else if(indexPath.item == 1) {
    toolbarItems = [self infoToolbarItems];
  }
  
  [self.measurableViewController.toolbar setItems:toolbarItems animated:NO];
  
  return cell;
}

- (NSArray *)logToolbarItems {

  if(!_logToolbarItems) {
    
    _logToolbarItems = [NSArray arrayWithObjects:
                        self.measurableViewController.barButtonItemShareLog,
                        self.measurableViewController.barButtonItemSpacerOne,
                        self.measurableViewController.barButtonItemChartLog,
                        self.measurableViewController.barButtonItemSpacerTwo,
                        self.measurableViewController.barButtonItemEditLog,
                        nil];
  }
  return _logToolbarItems;
}

- (NSArray *)infoToolbarItems {
  
  if(!_infoToolbarItems) {
  
    if(self.measurable.metadataProvider.editable) {
    _infoToolbarItems = [NSArray arrayWithObjects:
                        self.measurableViewController.barButtonItemShareInfo,
                        self.measurableViewController.barButtonItemSpacerOne,
                        self.measurableViewController.barButtonItemCopyMeasurable,
                        self.measurableViewController.barButtonItemSpacerTwo,
                        self.measurableViewController.barButtonItemEditInfo,
                        nil];
    } else {
      _infoToolbarItems = [NSArray arrayWithObjects:
                           self.measurableViewController.barButtonItemShareInfo,
                           self.measurableViewController.barButtonItemSpacerOne,
                           self.measurableViewController.barButtonItemSpacerTwo,
                           nil];

    }
  }
  return _infoToolbarItems;
}

@end
