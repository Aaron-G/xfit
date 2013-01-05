//
//  ExerciseMoreInfoEditViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/31/12.
//
//

#import <UIKit/UIKit.h>

@protocol ExerciseMoreInfoEditViewControllerDelegate <NSObject>

- (void) didChangeExerciseMoreInfo:(NSDictionary*) moreInfo;

@end

@interface ExerciseMoreInfoEditViewController : UITableViewController

@property id<ExerciseMoreInfoEditViewControllerDelegate> delegate;

- (void) editExerciseMoreInfo:(NSDictionary*) moreInfo;

@end
