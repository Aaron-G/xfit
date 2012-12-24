//
//  MoveScreenSwitchDelegate.m
//  PR Wall
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "MoveScreenSwitchDelegate.h"

@implementation MoveScreenSwitchDelegate

- (AppScreenIdentifier) appScreen {
  return AppScreenIdentifierMove;
}

- (void) initNavigationItems
{
  self.viewController.navigationItem.leftBarButtonItem =
  
  [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"new-label", @"The label for New")
                                   style:UIBarButtonItemStylePlain target:self.viewController action:@selector(newMoveAction)];
  
  self.viewController.navigationItem.rightBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"log-label", @"The label for Log")
                                   style:UIBarButtonItemStylePlain target:self.viewController action:@selector(logMoveAction)];
}

- (void) initToolbarItems
{
  self.viewController.toolbarItems = nil;
}

- (void) initTitle
{
  self.viewController.title = NSLocalizedString(@"move-screen-title", @"The title of the Move screen");
}

@end
