//
//  WODScreenSwitchDelegatet.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "WODScreenSwitchDelegate.h"

@implementation WODScreenSwitchDelegate

- (AppScreenIdentifier) appScreen {
  return kAppScreenIdentifierWOD;
}

- (void) initNavigationItems
{
  self.viewController.navigationItem.leftBarButtonItem =
  
  [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"new-label", @"The label for New")
                                   style:UIBarButtonItemStylePlain target:self.viewController action:@selector(newWODAction)];
  
  self.viewController.navigationItem.rightBarButtonItem =
  [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"log-label", @"The label for Log")
                                   style:UIBarButtonItemStylePlain target:self.viewController action:@selector(logWODAction)];
}

- (void) initToolbarItems
{
  UIBarButtonItem* spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
  
  UIBarButtonItem* options = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPageCurl target:self.viewController action:@selector(showOptionsAction)];
  
  self.viewController.toolbarItems = [NSArray arrayWithObjects:spacer, options, nil];
}

- (void) initTitle
{
  self.viewController.title = NSLocalizedString(@"wod-screen-title", @"The title of the WOD screen");
}

@end
