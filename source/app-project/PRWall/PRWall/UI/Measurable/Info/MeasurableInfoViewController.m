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

@interface MeasurableInfoViewController ()

@property MeasurableShareDelegate* shareDelegate;
@property MeasurableInfoEditViewController* measurableInfoEditViewController;

@end

@implementation MeasurableInfoViewController

@synthesize layoutDelegate;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    // Custom initialization
    self.shareDelegate = [[MeasurableInfoShareDelegate alloc]initWithViewController:self withMeasurableProvider:self];
  }
  return self;
}

#pragma mark - Measurable Layout View Controller

- (id<MeasurableViewLayoutDelegate>) layoutDelegate {
  return  [MeasurableHelper measurableInfoViewLayoutDelegateForMeasurable:self.measurable];
}

- (void) share {
  [self.shareDelegate shareFromToolBar:[UIHelper measurableViewController].toolbar];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
  
  UIView* fromView = nil;
  UIView* toView = nil;
  
  if(editing) {
    
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

@end
