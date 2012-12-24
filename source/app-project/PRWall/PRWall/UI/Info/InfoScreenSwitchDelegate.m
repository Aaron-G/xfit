//
//  InfoScreenSwitchDelegate.m
//  PR Wall
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "InfoScreenSwitchDelegate.h"

@implementation InfoScreenSwitchDelegate

- (AppScreenIdentifier) appScreen
{
  return AppScreenIdentifierInfo;
}

- (void) initNavigationItems
{
  self.viewController.navigationItem.leftBarButtonItem = nil;
  self.viewController.navigationItem.rightBarButtonItem = nil;
}

- (void) initToolbarItems
{
  self.viewController.toolbarItems = nil;
}

- (void) initTitle
{
  self.viewController.title = NSLocalizedString(@"info-screen-title", @"The title of the Info screen");
}

@end
