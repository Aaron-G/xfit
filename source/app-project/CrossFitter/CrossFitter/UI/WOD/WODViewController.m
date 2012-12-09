//
//  WODViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/8/12.
//
//

#import "WODViewController.h"
#import "AppViewController.h"
#import "WODScreenSwitchDelegate.h"
#import "UIHelper.h"

@interface WODViewController ()
{
}

@property AppViewController* appViewController;

- (IBAction)showOptionsAction;
- (IBAction)newWODAction;
- (IBAction)logWODAction;

@end

@implementation WODViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self) {
    self.appScreenSwitchDelegate = [[WODScreenSwitchDelegate alloc]initWithViewController:self];
    self.appViewController = [UIHelper appViewController];
  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.barButtonItemLog.title = NSLocalizedString(@"log-label", @"Log");
  self.barButtonItemNew.title = NSLocalizedString(@"new-label", @"New");
  
  [self.appScreenSwitchDelegate initialize];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.appScreenSwitchDelegate updateBars];
}

- (IBAction)newWODAction {
  NSLog(@"New WOD");
}

- (IBAction)logWODAction {
  NSLog(@"Log WOD");
}

- (IBAction)showOptionsAction {
  NSLog(@"Show options WOD");
}

@end
