//
//  PRWallScreenSwitchDelegate.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "PRWallScreenSwitchDelegate.h"

@implementation PRWallScreenSwitchDelegate

#pragma BaseScreenSwitchViewController

- (AppScreenIdentifier) appScreen
{
  return kAppScreenIdentifierPRWall;
}

- (void) initNavigationItems
{
  self.viewController.navigationItem.leftBarButtonItem =
  
  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self.viewController action:@selector(showFullScreenPRWallAction)];
  
  self.viewController.navigationItem.rightBarButtonItem =
  
  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self.viewController action:@selector(sharePRWallAction)];
}

- (void) initToolbarItems
{
  self.viewController.toolbarItems = nil;
}

- (void) initTitle
{
  self.viewController.title = NSLocalizedString(@"prwall-screen-title", @"The title of the PR Wall screen");
}


@end
