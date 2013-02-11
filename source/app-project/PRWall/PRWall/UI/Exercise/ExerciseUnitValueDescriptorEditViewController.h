//
//  ExerciseUnitValueDescriptorEditViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/31/12.
//
//

#import <UIKit/UIKit.h>

@protocol ExerciseUnitValueDescriptorEditViewControllerDelegate <NSObject>

- (void) didChangeExerciseUnitValueDescriptors:(NSArray*) unitValueDescriptors;

@end

@interface ExerciseUnitValueDescriptorEditViewController : UITableViewController

@property id<ExerciseUnitValueDescriptorEditViewControllerDelegate> delegate;

- (void) editExerciseUnitValueDescriptors:(NSArray*) unitValueDescriptors;

@end
