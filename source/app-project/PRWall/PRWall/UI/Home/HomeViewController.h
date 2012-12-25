//
//  HomeViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 8/7/12.
//
//

#import <UIKit/UIKit.h>
#import "AppScreenSwitchDelegate.h"

@interface HomeViewController : UIViewController <UIActionSheetDelegate>

@property AppScreenSwitchDelegate* appScreenSwitchDelegate;

@property IBOutlet UIButton* prWallButton;
@property IBOutlet UIButton* wodButton;
@property IBOutlet UIButton* myBodyButton;
@property IBOutlet UIButton* exerciseButton;
@property IBOutlet UIButton* workoutButton;

- (IBAction) displayPRWall;
- (IBAction) displayMyBody;
- (IBAction) displayWorkout;
- (IBAction) displayWOD;
- (IBAction) displayExercise;

@end
