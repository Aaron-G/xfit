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
#import "App.h"

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
    self.appViewController = [[App sharedInstance] appViewController];
  }
  
  return self;
}


- (void)newMoveAction {
  NSLog(@"New Move");
}

- (void)logMoveAction {
  NSLog(@"Log Move");
}

@end
