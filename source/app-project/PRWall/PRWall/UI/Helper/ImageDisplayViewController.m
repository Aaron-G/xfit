//
//  ImageDisplayViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/16/12.
//
//

#import "ImageDisplayViewController.h"
#import "UIHelper.h"
#import "NavigationBarAutoHideSupport.h"

@interface ImageDisplayViewController ()

@property NavigationBarAutoHideSupport* navigationBarAutoHideSupport;

@end

@implementation ImageDisplayViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  self.imageView.image = self.image;
  
  //Install the auto hide navigation support
  self.navigationBarAutoHideSupport = [[NavigationBarAutoHideSupport alloc] init];
  [self.navigationBarAutoHideSupport installSupportOnViewController:self withNavigationBar:self.navigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}
- (NSUInteger)supportedInterfaceOrientations {
  return [UIHelper supportedInterfaceOrientationsWithLandscape];
}

- (IBAction) hide:(id)sender {
  [[UIHelper appViewController] dismissViewControllerAnimated:YES completion:nil];
}

@end
