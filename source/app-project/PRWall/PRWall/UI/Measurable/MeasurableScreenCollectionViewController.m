//
//  MeasurableScreenCollectionViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/30/12.
//
//

#import "MeasurableScreenCollectionViewController.h"
#import "UIHelper.h"

@interface MeasurableScreenCollectionViewController () {
  
}

@property (readonly) MeasurableViewController* measurableViewController;

@end

@implementation MeasurableScreenCollectionViewController

const NSInteger MEASURABLE_LOG_SCREEN_INDEX = 0;
const NSInteger MEASURABLE_INFO_SCREEN_INDEX = 1;

@synthesize measurable = _measurable;
@synthesize logToolbarItems = _logToolbarItems;
@synthesize infoToolbarItems = _infoToolbarItems;
@synthesize currentViewControllerIndex = _currentViewControllerIndex;

- (UIViewController *)displayedMeasurableScreen {
  
  if(self.currentViewControllerIndex == MEASURABLE_LOG_SCREEN_INDEX) {
    return self.logViewController;
  } else if(self.currentViewControllerIndex == MEASURABLE_INFO_SCREEN_INDEX) {
    return self.infoViewController;
  }
  return nil;
}
- (MeasurableViewController *)measurableViewController {
  return [UIHelper measurableViewController];
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

  //Reset to the first view
  [self scrollToViewControllerAtIndex:0 animated:NO];
}

- (id<Measurable>)measurable {
  return _measurable;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
  
  self = [super initWithCoder:aDecoder];
  if(self) {
    self.infoViewController = (MeasurableInfoViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier:@"MeasurableInfoViewController"];
    self.logViewController = (MeasurableLogViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier:@"MeasurableLogViewController"];
    self.currentViewControllerIndex = MEASURABLE_LOG_SCREEN_INDEX;    
  }
  return self;
}

-(void)viewWillAppear:(BOOL)animated {
  
  [self updateUIControlsToIndex:self.currentViewControllerIndex];
  
  [super viewWillAppear:animated];
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
  if(indexPath.item == MEASURABLE_LOG_SCREEN_INDEX) {
    view = self.logViewController.view;
  } else if(indexPath.item == MEASURABLE_INFO_SCREEN_INDEX) {
    view = self.infoViewController.view;
  }

  if(view) {
    [cell addSubview: view];
  }
  
  return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
  NSInteger viewIndex = (scrollView.contentOffset.x < scrollView.bounds.size.width/2) ? MEASURABLE_LOG_SCREEN_INDEX : MEASURABLE_INFO_SCREEN_INDEX;
  
  if(viewIndex != _currentViewControllerIndex) {

    //Update the UI controls
    [self updateUIControlsToIndex:viewIndex];

    //Give the detail screen a chance to prepare to show/hide
    //
    //IMPL NOTE
    //Right now only the log screen needs this "heads up"
    //
    if(viewIndex == MEASURABLE_LOG_SCREEN_INDEX) {
      [self.logViewController viewDidAppear:NO];
    } else if (viewIndex == MEASURABLE_INFO_SCREEN_INDEX) {
      [self.logViewController viewDidDisappear:NO];
    }
    
  }
}

//Updates the UI controls so that info and log related UI controls are shown/hidden appropriately
- (void) updateUIControlsToIndex:(NSInteger)viewIndex {
  
  //If we are editing, do not mess with the UI controls
  if((viewIndex == MEASURABLE_LOG_SCREEN_INDEX && self.logViewController.editing) || (viewIndex == MEASURABLE_INFO_SCREEN_INDEX && self.infoViewController.editing)) {
    return;
  }
    
  //Update the page control
  if(viewIndex < 2) {
    self.measurableViewController.measurableDetailPageControl.currentPage = viewIndex;
  }
  NSArray* toolbarItems = nil;
  
  //Update the toolbar buttons
  if(viewIndex == MEASURABLE_LOG_SCREEN_INDEX) {
    toolbarItems = [self logToolbarItems];
  } else if(viewIndex == MEASURABLE_INFO_SCREEN_INDEX) {
    toolbarItems = [self infoToolbarItems];
  }
  
  [self.measurableViewController.toolbar setItems:toolbarItems animated:YES];

  [UIView animateWithDuration: 0.3
                        delay: 0
                      options: 0
                   animations:^{
                     self.measurableViewController.buttonSwitchToLog.alpha = (viewIndex == 0) ? 0 : 1;
                     self.measurableViewController.buttonSwitchToInfo.alpha = (viewIndex == 1) ? 0 : 1;
                   }
                   completion: nil];

  //Update current view index
  _currentViewControllerIndex = viewIndex;
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
  
  //Should only be enable when we have data
  BOOL buttonsEnabled = (self.measurable.dataProvider.values.count > 0);
  self.measurableViewController.barButtonItemEditLog.enabled = buttonsEnabled;
  self.measurableViewController.barButtonItemChartLog.enabled = buttonsEnabled;
  self.measurableViewController.barButtonItemShareLog.enabled = buttonsEnabled;
  
  return _logToolbarItems;
}

- (NSArray *)infoToolbarItems {
  
  if(!_infoToolbarItems) {
  
    NSMutableArray* toolBarItems = [NSMutableArray array];
    
    [toolBarItems addObject:self.measurableViewController.barButtonItemShareInfo];
    [toolBarItems addObject:self.measurableViewController.barButtonItemSpacerOne];
    
    if(self.measurable.metadataProvider.copyable) {
      [toolBarItems addObject:self.measurableViewController.barButtonItemCopyMeasurable];
      [toolBarItems addObject:self.measurableViewController.barButtonItemSpacerTwo];
    }
    
    [toolBarItems addObject:self.measurableViewController.barButtonItemEditInfo];
    
    _infoToolbarItems = toolBarItems;
    
  }
  return _infoToolbarItems;
}

- (void)displayMeasurableLog {
  [self scrollToViewControllerAtIndex:MEASURABLE_LOG_SCREEN_INDEX animated:YES];
}

- (void)displayMeasurableInfo {
  [self scrollToViewControllerAtIndex:MEASURABLE_INFO_SCREEN_INDEX animated:YES];
}


- (void)scrollToViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated {
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
  
  [self.collectionView scrollToItemAtIndexPath:indexPath
                              atScrollPosition:UICollectionViewScrollPositionNone
                                      animated:animated];
}

@end
