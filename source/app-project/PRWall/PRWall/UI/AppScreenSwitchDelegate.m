//
//  AppScreenSwitchDelegate.m
//  PR Wall
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "AppScreenSwitchDelegate.h"
#import "UIHelper.h"
#import "AppConstants.h"
#import "App.h"

@interface AppScreenSwitchDelegate () {
}

@end

@implementation AppScreenSwitchDelegate


- initWithViewController: (UIViewController*) viewController {
  self = [super init];
  
  if(self) {
    
    //Initialize
    _viewController = viewController;
    _appViewController = [UIHelper appViewController];
    
    self.initialized = NO;
    
    //Register screen switch delegate
    [AppViewController addAppScreenSwitchDelegate:self forAppScreen: [self appScreen]];
    
    //Default to NO
    self.displayBackButtonAsBack = NO;
  }
  
  return self;
}

- (void) initialize {
  
  if(!self.initialized) {
    [self initTitle];
    [self initToolbarItems];
    [self initNavigationItems];
    self.initialized = YES;
  }
  
}
- (void)initToolbarItems {
  self.viewController.toolbarItems = nil;
}

- (void)initNavigationItems {
  self.viewController.navigationItem.leftBarButtonItem = nil;
  self.viewController.navigationItem.rightBarButtonItem = nil;
}

- (void)initTitle {
  self.viewController.title = nil;
}

- (void)updateMainView {
  
  //Only use animation after the app has started
  if([App sharedInstance].started) {
    
    //Put a nice animation when doing the view transition...
    [UIView transitionWithView:self.appViewController.contentView
                      duration:ScreenSwitchAnimationDuration
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^ {
                      [self updateMainViewImpl];
                    }
                    completion:nil];
  } else {
    [self updateMainViewImpl];
  }
}

- (void)updateMainViewImpl {
  
  //Remove all the subviews
  NSArray *viewsToRemove = self.appViewController.contentView.subviews;
  for (UIView *viewToRemove in viewsToRemove) {
    [viewToRemove removeFromSuperview];
  }
  //Add the new view
  [self.appViewController.contentView addSubview:self.viewController.view];
  
  //Adjust the height of the newly displayed view if needed
  CGRect currentFrame = self.viewController.view.frame;
  NSInteger minHeight = self.appViewController.contentView.bounds.size.height;
  
  if(currentFrame.size.height < minHeight) {
    self.viewController.view.frame = CGRectMake(currentFrame.origin.x, currentFrame.origin.y, currentFrame.size.width, minHeight);
  }
  
}

- (void)updateBars {
  [self updateNavigationBar];
  [self updateNavigationToolbar];
}

- (void)updateNavigationBar
{
  //Update title
  self.appViewController.title = self.viewController.title;
  
  //Configure the navigation buttons
  [self.appViewController.navigationItem setLeftBarButtonItem:self.viewController.navigationItem.leftBarButtonItem animated:YES];
  [self.appViewController.navigationItem setRightBarButtonItem:self.viewController.navigationItem.rightBarButtonItem animated:YES];
  
}

- (void)updateNavigationToolbar
{
  
  BOOL hasToolbarItems = (self.viewController.toolbarItems != nil);
  
  //Update the items
  [self.appViewController setToolbarItems:self.viewController.toolbarItems animated:YES];
  
  //Show/hide the toolbar as needed
  [self.appViewController.navigationController setToolbarHidden:(!hasToolbarItems) animated:YES];
}

- (void)screenWillAppear {
  
  //Reset the title
  self.appViewController.title = self.viewController.title;
}

- (void)screenWillDisappear {

  //Change title to enable the back button to say "Back"
  if(self.displayBackButtonAsBack) {
    self.appViewController.title = nil;
  }
  
  //Reset flag
  self.displayBackButtonAsBack = NO;
}

@end