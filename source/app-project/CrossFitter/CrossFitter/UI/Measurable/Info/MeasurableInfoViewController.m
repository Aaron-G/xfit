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

@interface MeasurableInfoViewController ()

@property MeasurableShareDelegate* shareDelegate;
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

  self.requiresViewUpdate = YES;
  [self updateView];
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
    id<MeasurableViewUpdateDelegate> updateDelegate = [MeasurableHelper measurableInfoUpdateDelegateForMeasurable:self.measurable];
    [updateDelegate updateViewInViewController:self withMeasurable: self.measurable withLayoutPosition: self.viewLayoutPosition];
  }
}

- (void) share {
  [self.shareDelegate shareFromToolBar:[UIHelper measurableViewController].toolbar];
}

@end
