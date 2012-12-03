//
//  MeasurableInfoViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/30/12.
//
//

#import "MeasurableInfoViewController.h"
#import "MeasurableShareDelegate.h"
#import "MeasurableInfoShareDelegate.h"
#import "MeasurableHelper.h"
#import "MeasurableViewUpdateDelegate.h"
#import "UIHelper.h"
#import "AppViewControllerSegue.h"
#import "MeasurableInfoEditViewController.h"

@interface MeasurableInfoViewController ()

@property MeasurableShareDelegate* shareDelegate;
@property MeasurableInfoEditViewController* measurableInfoEditViewController;

@end

@implementation MeasurableInfoViewController

@synthesize measurable = _measurable;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    // Custom initialization
    self.shareDelegate = [[MeasurableInfoShareDelegate alloc]initWithViewController:self withMeasurableProvider:self];
  }
  return self;
}

-(void)viewDidLoad {
  [super viewDidLoad];
  
  [self updateView];
}

- (void)setMeasurable:(id<Measurable>)measurable {
  _measurable = measurable;

  [self reloadView];
}

- (id<Measurable>)measurable {
  return _measurable;
}

- (void)viewWillAppear:(BOOL)animated {
  [self updateView];
  
  [super viewWillAppear:animated];
}
- (void) updateView {
  
  if(self.requiresViewUpdate) {
    
    //Update the view
    id<MeasurableViewUpdateDelegate> updateDelegate = [MeasurableHelper measurableInfoViewUpdateDelegateForMeasurable:self.measurable];
    [updateDelegate updateViewInViewController:self withMeasurable: self.measurable withLayoutPosition: self.viewLayoutPosition];
  }
}

- (void) reloadView {
  
  [self forceUpdateView];
}

- (void) forceUpdateView {
  
  self.requiresViewUpdate = YES;
  [self updateView];
  
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
    self.measurableInfoEditViewController.viewLayoutPosition = self.viewLayoutPosition;
    
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
