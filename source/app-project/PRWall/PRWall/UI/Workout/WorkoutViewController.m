//
//  WorkoutViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 8/8/12.
//
//

#import "WorkoutViewController.h"
#import "AppViewController.h"
#import "WorkoutScreenSwitchDelegate.h"
#import "UIHelper.h"

@interface WorkoutViewController ()
{
}

@property AppViewController* appViewController;

@end

@implementation WorkoutViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
 
  if(self) {
    self.appScreenSwitchDelegate = [[WorkoutScreenSwitchDelegate alloc]initWithViewController:self];
    self.appViewController = [UIHelper appViewController];
  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.appScreenSwitchDelegate initialize];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.appScreenSwitchDelegate updateBars];
}

- (void)newWorkoutAction
{
  NSLog(@"New Workout");
}

- (void)logWorkoutAction
{
  NSLog(@"Log Workout");
}

@end
