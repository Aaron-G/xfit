//
//  AppViewControllerSegue.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "AppViewControllerSegue.h"
#import "AppViewController.h"
#import "UIHelper.h"

@interface AppViewControllerSegue ()

@end

@implementation AppViewControllerSegue

- (void)perform {
  
  AppViewController * appViewController = [UIHelper appViewController];
  
  //Display "Back" as back button
  AppScreenSwitchDelegate* appScreenSwitchDelegate = [AppViewController appScreenSwitchDelegateForAppScreen:  [appViewController displayedAppScreen]];
  appScreenSwitchDelegate.displayBackButtonAsBack = YES;
  
  //Navigate off now
  [appViewController.navigationController pushViewController:self.destinationViewController animated:YES];  
}

@end
