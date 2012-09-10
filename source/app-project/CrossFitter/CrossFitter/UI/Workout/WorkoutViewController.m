//
//  WorkoutViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/8/12.
//
//

#import "WorkoutViewController.h"
#import "AppViewController.h"
#import "WorkoutScreenSwitchDelegate.h"
#import "App.h"

@interface WorkoutViewController ()
{
}

@property AppViewController* appViewController;

@end

@implementation WorkoutViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
 
  if(self) {
    self.appScreenSwitchDelegate = [[WorkoutScreenSwitchDelegate alloc]initWithViewController:self];
    self.appViewController = [[App sharedInstance] appViewController];
  }
  
  return self;
}

- (void)newWorkoutAction
{
  NSLog(@"New Workout");
}

- (void)logWorkoutAction
{
  NSLog(@"Log Workout");
}

@end
