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

- (id)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination {
  self = [super initWithIdentifier:identifier source:source destination:destination];
  
  if(self) {
    self.modal = NO;
  }
  return self;
}

- (void)perform {
  
  AppViewController * appViewController = [UIHelper appViewController];
  
  if(self.modal) {
    if(![self.destinationViewController isBeingPresented]) {
      //NSLog(@"Present Modal - %@", self.identifier);
      [appViewController.navigationController presentViewController:self.destinationViewController animated:YES completion:nil];
    }
  } else {
    
    //Display "Back" as back button
    AppScreenSwitchDelegate* appScreenSwitchDelegate = [AppViewController appScreenSwitchDelegateForAppScreen: [appViewController displayedAppScreen]];
    appScreenSwitchDelegate.displayBackButtonAsBack = YES;
    
    //NSLog(@"Present - %@", self.identifier);
    //Navigate off now
    [appViewController.navigationController pushViewController:self.destinationViewController animated:YES];
  }
}

@end
