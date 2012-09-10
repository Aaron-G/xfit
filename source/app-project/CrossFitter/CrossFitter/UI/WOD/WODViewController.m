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
#import "App.h"

@interface WODViewController ()
{
}

@property AppViewController* appViewController;

@end

@implementation WODViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self) {
    self.appScreenSwitchDelegate = [[WODScreenSwitchDelegate alloc]initWithViewController:self];
    self.appViewController = [[App sharedInstance] appViewController];
  }
  
  return self;
}

- (void)newWODAction {
  NSLog(@"New WOD");
}

- (void)logWODAction {
  NSLog(@"Log WOD");
}

- (void)showOptionsAction {
  NSLog(@"Show options WOD");
}

@end
