//
//  MeasurableLayoutViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 12/4/12.
//
//

#import "MeasurableLayoutViewController.h"

@interface MeasurableLayoutViewController ()

@end

@implementation MeasurableLayoutViewController

@synthesize layoutDelegate;
@synthesize needsLayout;

@synthesize measurable = _measurable;

- (void)forceLayout {
  self.needsLayout = YES;
  [self layoutView];
}

- (void) layoutView {
  if(self.needsLayout) {
    [self.layoutDelegate layoutViewInViewController:self withMeasurable: self.measurable withLayoutPosition:self.layoutPosition];
  }
}

- (void) viewWillAppear:(BOOL)animated {
  [self layoutView];
  [super viewWillAppear:animated];
}

-(void) viewDidLoad {
  [super viewDidLoad];
  [self layoutView];
}

- (void) reloadView {
  [self forceLayout];
}

- (id<Measurable>) measurable {
  return _measurable;
}

- (void)setMeasurable:(id<Measurable>)measurable {
  _measurable = measurable;
  [self reloadView];
}

@end