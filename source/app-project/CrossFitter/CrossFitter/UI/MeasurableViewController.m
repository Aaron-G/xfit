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
  
  for (UIViewController * viewController in self.childViewControllers) {
    if([viewController isKindOfClass: [MeasurableDetailSwitchViewController class]]) {
      _measurableDetailSwitchViewController = (MeasurableDetailSwitchViewController*)viewController;
    }
  }
  _measurableDetailSwitchViewController.measurableDetailPageControl = self.measurableDetailPageControl;
  _measurableDetailSwitchViewController.measurableTitleView = self.measurableTitleView;
  
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
  
  self.measurableTitleView.titleView.text = measurable.metadataProvider.name;

  self.barButtonItemLog.title = NSLocalizedString(@"log-label", @"Log");
  
  self.measurableDetailSwitchViewController.measurable = self.measurable;
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
