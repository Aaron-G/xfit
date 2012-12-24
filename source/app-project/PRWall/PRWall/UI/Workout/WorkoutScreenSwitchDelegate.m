//
//  WorkoutScreenSwitchDelegate.m
//  PR Wall
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "WorkoutScreenSwitchDelegate.h"

@implementation WorkoutScreenSwitchDelegate

#pragma BaseScreenSwitchViewController

- (AppScreenIdentifier) appScreen
{
  return AppScreenIdentifierWorkout;
}

- (void) initNavigationItems
{
  self.viewController.navigationItem.leftBarButtonItem =
  
  [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"new-label", @"The label for New")
                                   style:UIBarButtonItemStylePlain target:self.viewController action:@selector(newWorkoutAction)];
  
  self.viewController.navigationItem.rightBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"log-label", @"The label for Log")
                                   style:UIBarButtonItemStylePlain target:self.viewController action:@selector(logWorkoutAction)];
}

- (void) initToolbarItems
{
  self.viewController.toolbarItems = nil;
}

- (void) initTitle
{
  self.viewController.title = NSLocalizedString(@"workout-screen-title", @"The title of the Workout screen");
}

@end
