//
//  MyBodyScreenSwitchDelegate.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "MyBodyScreenSwitchDelegate.h"

@implementation MyBodyScreenSwitchDelegate

- (AppScreenIdentifier) appScreen
{
  return AppScreenIdentifierMyBody;
}

- (void) initNavigationItems
{
  self.viewController.navigationItem.leftBarButtonItem = nil;
  self.viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self.viewController action:@selector(shareMyBodyAction)];
}

- (void) initToolbarItems
{
  self.viewController.toolbarItems = nil;
}

- (void) initTitle
{
  self.viewController.title = NSLocalizedString(@"mybody-screen-title", @"The title of the My Body screen");
}

@end
