//
//  ExerciseScreenSwitchDelegate.m
//  PR Wall
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "ExerciseScreenSwitchDelegate.h"

@implementation ExerciseScreenSwitchDelegate

- (AppScreenIdentifier) appScreen {
  return AppScreenIdentifierExercise;
}

- (void) initNavigationItems
{
  self.viewController.navigationItem.leftBarButtonItem =
  
  [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"new-label", @"The label for New")
                                   style:UIBarButtonItemStylePlain target:self.viewController action:@selector(newExerciseAction)];
  
  self.viewController.navigationItem.rightBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"log-label", @"The label for Log")
                                   style:UIBarButtonItemStylePlain target:self.viewController action:@selector(logExerciseAction)];
}

- (void) initToolbarItems
{
  self.viewController.toolbarItems = nil;
}

- (void) initTitle
{
  self.viewController.title = NSLocalizedString(@"exercise-screen-title", @"The title of the Exercise screen");
}

@end
