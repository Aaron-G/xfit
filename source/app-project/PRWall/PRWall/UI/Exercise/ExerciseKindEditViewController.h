//
//  ExerciseKindEditViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/27/12.
//
//

#import <UIKit/UIKit.h>
#import "ExerciseKind.h"

@protocol ExerciseKindEditViewControllerDelegate <NSObject>

- (void) didChangeExerciseKind:(ExerciseKind*) exerciseKind;

@end

@interface ExerciseKindEditViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property IBOutlet UITableView* tableView;
@property id<ExerciseKindEditViewControllerDelegate> delegate;

- (void) editExerciseKind:(ExerciseKind*) exerciseKind;

@end