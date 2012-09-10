//
//  AppViewControllerSegue.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "AppViewControllerSegue.h"
#import "AppViewController.h"
#import "App.h"

@interface AppViewControllerSegue ()

@end

@implementation AppViewControllerSegue

- (void)perform {
  
  AppViewController * appViewController = [[App sharedInstance] appViewController];
  [appViewController.navigationController pushViewController:self.destinationViewController animated:YES];
  
}

@end
