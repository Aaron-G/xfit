//
//  PRWallScreenSwitchDelegate.m
//  PR Wall
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "PRWallScreenSwitchDelegate.h"
#import "PRWallViewController.h"

@implementation PRWallScreenSwitchDelegate

#pragma BaseScreenSwitchViewController

- (AppScreenIdentifier) appScreen
{
  return AppScreenIdentifierPRWall;
}

- (void) initNavigationItems
{
  PRWallViewController* prwallViewController = (PRWallViewController*)self.viewController;
  
  prwallViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: prwallViewController.screenFullButton];
  prwallViewController.navigationItem.rightBarButtonItem = prwallViewController.barButtonItemShare;
}

- (void) initToolbarItems
{
  self.viewController.toolbarItems = nil;
}

- (void) initTitle
{
  self.viewController.title = NSLocalizedString(@"prwall-screen-title", @"PR Wall");
}


@end
