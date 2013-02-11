//
//  AppNavigationController.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/20/12.
//
//

#import "AppNavigationController.h"
#import "UIHelper.h"

@interface AppNavigationController ()

@end

@implementation AppNavigationController

- (BOOL)shouldAutorotate {
  return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
  
  //Check with the View Controller currently being displayed
  if ([[self topViewController] respondsToSelector:@selector(supportedInterfaceOrientations)]) {
    return [[self topViewController] supportedInterfaceOrientations];
  } else {
    return [super supportedInterfaceOrientations];
  }
}

@end
