//
//  PRWallViewController.m
//  PR Wall
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

- (IBAction)fullScreenAction;
- (IBAction)restoreScreenAction;
- (IBAction)shareAction;

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

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.appScreenSwitchDelegate initialize];
  
  //For some reason the viewWillAppear is not called at application
  //startup time so we need to explicitly make this call
  [self.appScreenSwitchDelegate updateBars];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.appScreenSwitchDelegate updateBars];
}

- (IBAction)fullScreenAction {
  [[UIHelper appViewController].navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView: self.screenRestoreButton] animated:YES];
}

- (IBAction)restoreScreenAction {
  [[UIHelper appViewController].navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView: self.screenFullButton] animated:YES];
}

- (IBAction)shareAction {
  [self.appScreenShareDelegate share];
}

@end
