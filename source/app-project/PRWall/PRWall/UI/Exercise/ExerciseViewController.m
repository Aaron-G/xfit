//
//  ExerciseViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 8/8/12.
//
//

#import "ExerciseViewController.h"
#import "AppViewController.h"
#import "ExerciseScreenSwitchDelegate.h"
#import "UIHelper.h"

@interface ExerciseViewController ()
{
}

@property AppViewController* appViewController;

@end

@implementation ExerciseViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self) {
    self.appScreenSwitchDelegate = [[ExerciseScreenSwitchDelegate alloc]initWithViewController:self];
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

- (void)newExerciseAction {
  NSLog(@"New Exercise");
}

- (void)logExerciseAction {
  NSLog(@"Log Exercise");
}

@end
