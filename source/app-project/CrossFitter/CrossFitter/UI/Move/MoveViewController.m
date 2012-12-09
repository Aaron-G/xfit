//
//  MoveViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/8/12.
//
//

#import "MoveViewController.h"
#import "AppViewController.h"
#import "MoveScreenSwitchDelegate.h"
#import "UIHelper.h"

@interface MoveViewController ()
{
}

@property AppViewController* appViewController;

@end

@implementation MoveViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self) {
    self.appScreenSwitchDelegate = [[MoveScreenSwitchDelegate alloc]initWithViewController:self];
    self.appViewController = [UIHelper appViewController];
  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.appScreenSwitchDelegate initialize];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.appScreenSwitchDelegate updateBars];
}

- (void)newMoveAction {
  NSLog(@"New Move");
}

- (void)logMoveAction {
  NSLog(@"Log Move");
}

@end
