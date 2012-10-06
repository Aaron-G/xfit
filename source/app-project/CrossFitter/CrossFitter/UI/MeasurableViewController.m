//
//  MeasurableViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/29/12.
//
//

#import "MeasurableViewController.h"
#import "MeasurableDetailSwitchViewController.h"
#import "UIHelper.h"

@interface MeasurableViewController () {
  
}

@end

@implementation MeasurableViewController

@synthesize measurable = _measurable;
@synthesize measurableDetailSwitchViewController = _measurableDetailSwitchViewController;
@synthesize measurableTitleView = _measurableTitleView;

-(id)initWithCoder:(NSCoder *)aDecoder {
  
  self = [super initWithCoder:aDecoder];
  if(self) {
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  //The first time around it can happen that we are not completely initialized yet
  if(!_measurableDetailSwitchViewController) {
    self.measurableDetailSwitchViewController.measurable = self.measurable;
  }
  
  self.measurableDetailSwitchViewController.measurableDetailPageControl = self.measurableDetailPageControl;
  self.measurableDetailSwitchViewController.measurableTitleView = self.measurableTitleView;
  
  //Update the title view
  self.navigationItem.titleView = self.measurableTitleView;
}

- (void)viewWillAppear:(BOOL)animated {
  self.navigationItem.rightBarButtonItem = self.barButtonItemLog;
  
  [super viewWillAppear:animated];
}

- (MeasurableTitleView *)measurableTitleView {
  if(!_measurableTitleView) {
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"MeasurableTitleView"
                                                         owner:self
                                                       options:nil];
    _measurableTitleView = (MeasurableTitleView *)[nibContents objectAtIndex:0];
  }
  return _measurableTitleView;
}

- (id<Measurable>)measurable {
  return _measurable;
}

- (void)setMeasurable:(id<Measurable>)measurable {
  _measurable = measurable;
  
  self.measurableTitleView.titleLabel.text = measurable.metadataProvider.type.displayName;

  self.barButtonItemLog.title = NSLocalizedString(@"log-label", @"Log");
  
  self.measurableDetailSwitchViewController.measurable = self.measurable;
}

- (MeasurableDetailSwitchViewController *)measurableDetailSwitchViewController {
  if(!_measurableDetailSwitchViewController) {
    for (UIViewController * viewController in self.childViewControllers) {
      if([viewController isKindOfClass: [MeasurableDetailSwitchViewController class]]) {
        _measurableDetailSwitchViewController = (MeasurableDetailSwitchViewController*)viewController;
      }
    }
  }
  return _measurableDetailSwitchViewController;
}

- (IBAction)editMeasurableAction:(id)sender {
//  NSLog(@"EDIT");
}
- (IBAction)copyMeasurableAction:(id)sender {
//  NSLog(@"COPY");
}
- (IBAction)shareMeasurableAction:(id)sender {
//  NSLog(@"SHARE");
}

- (IBAction)logMeasurableAction:(id)sender {
//  NSLog(@"LOG");
}


@end