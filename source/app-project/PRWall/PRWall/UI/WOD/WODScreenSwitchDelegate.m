//
//  WODScreenSwitchDelegatet.m
//  PR Wall
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "WODScreenSwitchDelegate.h"
#import "WODViewController.h"

@implementation WODScreenSwitchDelegate

//- (AppScreenIdentifier) appScreen {
//  return AppScreenIdentifierWOD;
//}

- (void) initNavigationItems
{
  WODViewController* wodViewController = ((WODViewController*)self.viewController);
  
  self.viewController.navigationItem.leftBarButtonItem = wodViewController.barButtonItemNew;
  self.viewController.navigationItem.rightBarButtonItem = wodViewController.barButtonItemLog;
}

- (void) initToolbarItems
{
  self.viewController.toolbarItems = [NSArray arrayWithObjects:
                                      [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                      ((WODViewController*)self.viewController).barButtonItemSettings,
                                      nil];
}

- (void) initTitle
{
  self.viewController.title = NSLocalizedString(@"wod-screen-title", @"WODs");
}

@end
