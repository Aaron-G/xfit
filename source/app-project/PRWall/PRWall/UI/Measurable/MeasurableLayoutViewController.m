//
//  MeasurableLayoutViewController.m
//  PR Wall
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

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self) {
    self.layoutAsynchronous = YES;
  }
  return self;
}

- (void)forceLayout {
  self.needsLayout = YES;
  [self layoutView];
}

- (void) layoutView {
  if(self.needsLayout) {

    if(self.layoutAsynchronous) {
      //This ensures that the layout is properly done the first time around
      dispatch_async(dispatch_get_main_queue(), ^{
        [self.layoutDelegate layoutViewInViewController:self withMeasurable: self.measurable withLayoutPosition:self.layoutPosition];
      });
    } else {
      [self.layoutDelegate layoutViewInViewController:self withMeasurable: self.measurable withLayoutPosition:self.layoutPosition];
    }
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

- (Measurable*) measurable {
  return _measurable;
}

- (void)setMeasurable:(Measurable*)measurable {
  _measurable = measurable;
  [self reloadView];
}

@end