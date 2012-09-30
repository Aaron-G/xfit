//
//  HomeScreenSwitchDelegate.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "HomeScreenSwitchDelegate.h"

@implementation HomeScreenSwitchDelegate

- (AppScreenIdentifier) appScreen
{
  return AppScreenIdentifierHome;
}

- (void) initNavigationItems
{
  self.viewController.navigationItem.leftBarButtonItem = nil;
  self.viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self.viewController action:@selector(shareAppAction)];
}

- (void) initToolbarItems
{
  self.viewController.toolbarItems = nil;
}

- (void) initTitle
{
  self.viewController.title = NSLocalizedString(@"home-screen-title", @"The title of the Home screen");
}

@end
