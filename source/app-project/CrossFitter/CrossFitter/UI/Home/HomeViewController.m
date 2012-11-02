//
//  HomeViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/7/12.
//
//

#import "HomeViewController.h"
#import "UIHelper.h"
#import "AppViewController.h"
#import "HomeScreenSwitchDelegate.h"
#import "ShareDelegate.h"
#import "HomeScreenShareDelegate.h"

@interface HomeViewController () {
}

@property AppViewController* appViewController;
@property ShareDelegate* appScreenShareDelegate;

@end

@implementation HomeViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self) {
    self.appScreenSwitchDelegate = [[HomeScreenSwitchDelegate alloc]initWithViewController:self];
    self.appScreenShareDelegate = [[HomeScreenShareDelegate alloc]init];
    self.appViewController = [UIHelper appViewController];
  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.prWallButton setImage: [UIImage imageNamed:@"prwall-screen-button"] forState:UIControlStateNormal];
  [self.wodButton setImage: [UIImage imageNamed:@"wod-screen-button"] forState:UIControlStateNormal];
  [self.workoutButton setImage: [UIImage imageNamed:@"workout-screen-button"] forState:UIControlStateNormal];
  [self.myBodyButton setImage: [UIImage imageNamed:@"mybody-screen-button"] forState:UIControlStateNormal];
  [self.moveButton setImage: [UIImage imageNamed:@"move-screen-button"] forState:UIControlStateNormal];
}

- (IBAction) displayPRWall {
  [self.appViewController displayPRWallScreen];
}

- (IBAction) displayMyBody {
  [self.appViewController displayMyBodyScreen];
}

- (IBAction) displayWorkout {
  [self.appViewController displayWorkoutScreen];
}

- (IBAction) displayWOD {
  [self.appViewController displayWODScreen];
}

- (IBAction) displayMove {
  [self.appViewController displayMoveScreen];
}

- (void)shareAppAction {
  [self.appScreenShareDelegate share];
}

@end
