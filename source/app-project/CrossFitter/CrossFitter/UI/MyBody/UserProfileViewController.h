//
//  UserProfileViewController.h
//  CrossFitter
//
//  Created by Cleo Barretto on 10/20/12.
//
//

#import <UIKit/UIKit.h>
#import "MyBodyViewController.h"

@interface UserProfileViewController : UITableViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property MyBodyViewController* myBodyViewController;

@property IBOutlet UIButton* imageButton;

@property IBOutlet UITextField* nameTextField;

@property IBOutlet UILabel* boxLabel;
@property IBOutlet UITextField* boxTextField;

@property IBOutlet UILabel* dateOfBirthLabel;
@property IBOutlet UITextField* dateOfBirthTextField;
@property IBOutlet UIDatePicker* dateOfBirthDatePicker;

@property IBOutlet UIToolbar* editToolbar;

@property IBOutlet UILabel* sexLabel;
@property IBOutlet UISegmentedControl* sexSegmentedControl;

- (IBAction) changeSex;
- (IBAction) changeDateOfBirth;
- (IBAction) dismissInputView;
- (IBAction) startChangingImage;

@end
