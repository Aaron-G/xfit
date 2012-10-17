//
//  PRWallViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/7/12.
//
//

#import "App.h"
#import "PRWallViewController.h"
#import "AppViewController.h"
#import "PRWallScreenSwitchDelegate.h"
#import "ShareDelegate.h"
#import "PRWallScreenShareDelegate.h"
#import "UIHelper.h"

@interface PRWallViewController ()
{
}
@property AppViewController* appViewController;
@property ShareDelegate* appScreenShareDelegate;

@end

@implementation PRWallViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self) {
    self.appScreenSwitchDelegate = [[PRWallScreenSwitchDelegate alloc]initWithViewController:self];
    self.appScreenShareDelegate = [[PRWallScreenShareDelegate alloc]init];
    self.appViewController = [UIHelper appViewController];
  }
  
  return self;
}

- (void)showFullScreenPRWallAction {
  NSLog(@"PR Wall full screen :-)");
}

- (void)sharePRWallAction {
  [self.appScreenShareDelegate share];
}

@end
