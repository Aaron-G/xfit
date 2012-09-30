//
//  MeasurableViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/29/12.
//
//

#import "MeasurableViewController.h"

@interface MeasurableViewController () {
  
}

@end

@implementation MeasurableViewController

@synthesize measurable = _measurable;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
  self.navigationItem.rightBarButtonItem = self.barButtonItemLog;
  
  [super viewWillAppear:animated];
}

- (id<Measurable>)measurable {
  return _measurable;
}

- (void)setMeasurable:(id<Measurable>)measurable {
  _measurable = measurable;
  self.title = [NSString stringWithFormat:NSLocalizedString(@"measurable-info-screen-title-format", @"%@ Info"), measurable.metadataProvider.name];
  self.barButtonItemLog.title = NSLocalizedString(@"log-label", @"Log");
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
