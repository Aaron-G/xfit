//
//  MeasurableInfoViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/30/12.
//
//

#import "MeasurableInfoViewController.h"
#import "MeasurableShareDelegate.h"
#import "MeasurableInfoShareDelegate.h"
#import "MeasurableHelper.h"
#import "MeasurableViewLayoutDelegate.h"
#import "UIHelper.h"
#import "AppViewControllerSegue.h"
#import "MeasurableInfoEditViewController.h"
#import "ModelHelper.h"

@interface MeasurableInfoViewController ()

@property MeasurableShareDelegate* shareDelegate;
@property MeasurableInfoEditViewController* measurableInfoEditViewController;
@property MediaCollectionViewDelegate* mediaCollectionViewDelegate;
@end

@implementation MeasurableInfoViewController

@synthesize layoutDelegate;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    // Custom initialization
    self.shareDelegate = [[MeasurableInfoShareDelegate alloc]initWithViewController:self withMeasurableProvider:self];
    self.mediaCollectionViewDelegate = [[MediaCollectionViewDelegate alloc] init];
    self.mediaCollectionViewDelegate.mediaProvider = self;
  }
  return self;
}

- (void)reloadView {
  
  [super reloadView];

  [self.mediaView reloadData];
}

#pragma mark - Measurable Layout View Controller

- (id<MeasurableViewLayoutDelegate>) layoutDelegate {
  return [MeasurableHelper measurableInfoViewLayoutDelegateForMeasurable:self.measurable];
}

- (void) share {
  [self.shareDelegate shareFromToolBar:[UIHelper measurableViewController].toolbar];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
  
  UIView* fromView = nil;
  UIView* toView = nil;
  
  if(editing) {
    
    if([ModelHelper hasUnsavedModelChanges]) {
      NSLog(@"MeasurableInfoViewController - model changes pending - edit measurable metadata");
      return;
    }

    //Get hold of info edit view controller
    self.measurableInfoEditViewController = [MeasurableHelper measurableInfoEditViewControllerForMeasurable:self.measurable];
    
    //Link the delegate for it
    self.measurableInfoEditViewController.delegate = [UIHelper measurableViewController];
    self.measurableInfoEditViewController.layoutPosition = self.layoutPosition;
    
    //Setup views
    toView = self.measurableInfoEditViewController.view;
    fromView = self.view;
    
  } else {
    
    toView = self.view;
    fromView = self.measurableInfoEditViewController.view;
    
    //Clear reference
    self.measurableInfoEditViewController = nil;
  }
  
  if(toView && fromView) {
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseOut
                    completion:nil];
  }
  
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
  return self.measurable.metadata.images;
}

- (NSArray*)videos {
  return self.measurable.metadata.videos;
}

@end
