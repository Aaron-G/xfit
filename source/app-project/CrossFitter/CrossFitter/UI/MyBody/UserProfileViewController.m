//
//  UserProfileViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 10/20/12.
//
//

#import "UserProfileViewController.h"
#import "App.h"
#import "UserProfile.h"
#import "UIHelper.h"
#import "MediaHelper.h"

@interface UserProfileViewController ()

@property UIImagePickerController *imagePickerController;

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Update the title
  self.title = NSLocalizedString(@"user-profile-screen-title", @"Profile");
  
  /////////////////////////////////////////////////////////////////
  //Customize the Segmented Control
  /////////////////////////////////////////////////////////////////
  //Size
  CGRect sexControlFrame = self.sexSegmentedControl.frame;
  NSInteger newHeight = 30;
  [self.sexSegmentedControl setFrame:CGRectMake(sexControlFrame.origin.x, (((sexControlFrame.size.height + 3) - newHeight)/2), sexControlFrame.size.width, newHeight)];
  
  //Font
  UIFont *Boldfont = [UIFont boldSystemFontOfSize:14.0f];
  NSDictionary *attributes = [NSDictionary dictionaryWithObject:Boldfont
                                                         forKey:UITextAttributeFont];
  [self.sexSegmentedControl setTitleTextAttributes:attributes
                                  forState:UIControlStateNormal];
  
  /////////////////////////////////////////////////////////////////
  //Localize Labels
  /////////////////////////////////////////////////////////////////
  self.nameTextField.placeholder = NSLocalizedString(@"user-profile-name-tip", @"Add name");
  self.boxLabel.text = NSLocalizedString(@"user-profile-box-label", @"Box");
  self.boxTextField.placeholder = NSLocalizedString(@"user-profile-box-tip", @"Add box/gym");
  self.dateOfBirthLabel.text = NSLocalizedString(@"user-profile-date-of-birth-label", @"Date of Birth");
  self.sexLabel.text = NSLocalizedString(@"user-profile-sex-label", @"Sex");
  [self.sexSegmentedControl setTitle:NSLocalizedString(@"male-label", @"Male") forSegmentAtIndex:0];
  [self.sexSegmentedControl setTitle:NSLocalizedString(@"female-label", @"Female") forSegmentAtIndex:1];
  
  /////////////////////////////////////////////////////////////////
  //Configure TextFields
  /////////////////////////////////////////////////////////////////
  self.dateOfBirthTextField.inputView = self.dateOfBirthDatePicker;
  self.dateOfBirthTextField.inputAccessoryView = self.editToolbar;

  self.nameTextField.inputAccessoryView = self.editToolbar;
  self.boxTextField.inputAccessoryView = self.editToolbar;

  /////////////////////////////////////////////////////////////////
  //Image Picker
  self.imagePickerController = [[UIImagePickerController alloc] init];
  self.imagePickerController.delegate = self;
  self.imagePickerController.allowsEditing = YES;

  /////////////////////////////////////////////////////////////////
  //Image Buttom
  //
  //Disable image picking if not available
  if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
    self.imageButton.userInteractionEnabled = NO;
  }
}

- (void)viewWillAppear:(BOOL)animated {
  
  UserProfile* userProfile = [App sharedInstance].userProfile;
  
  self.nameTextField.text = userProfile.name;
  self.dateOfBirthTextField.text = [UIHelper.appDateFormat stringFromDate:userProfile.dateOfBirth];
  
  self.boxTextField.text = userProfile.box;
  
  NSInteger sexSelection = UISegmentedControlNoSegment;
  if(userProfile.sex == UserProfileSexMale) {
    sexSelection = 0;
  } else if (userProfile.sex == UserProfileSexFemale) {
    sexSelection = 1;
  }
  self.sexSegmentedControl.selectedSegmentIndex =  sexSelection;
  
  self.dateOfBirthDatePicker.date = userProfile.dateOfBirth;

  [self.imageButton setImage:userProfile.image forState:UIControlStateNormal];
  
  [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {

  //In case the user did not dismiss the name editor
  [self hideAllControls];
  
  [super viewWillDisappear:animated];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

  //Prevents the Date of Birth field from being manually edited
  if(textField == self.dateOfBirthTextField) {
    return NO;
  }
  
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  
  [self dismissInputView];
  
  return YES;
}

- (void) hideAllControls {
  [self.nameTextField resignFirstResponder];
  [self.boxTextField resignFirstResponder];
  [self.dateOfBirthTextField resignFirstResponder];
}

- (IBAction) dismissInputView {
  
  [self changeName];
  [self changeBox];
  
  [self invalidateUserProfileSummaryRow];
  
  [self hideAllControls];
}

- (IBAction) changeDateOfBirth {
  
  //Update data model
  UserProfile* userProfile = [App sharedInstance].userProfile;
  userProfile.dateOfBirth = self.dateOfBirthDatePicker.date;
  
  //Update UI
  self.dateOfBirthTextField.text = [UIHelper.appDateFormat stringFromDate:userProfile.dateOfBirth];

  [self invalidateUserProfileSummaryRow];
}

- (IBAction)changeSex {
  
  UserProfile* userProfile = [App sharedInstance].userProfile;
  
  if (self.sexSegmentedControl.selectedSegmentIndex == 0) {
    userProfile.sex = UserProfileSexMale;
  } else if (self.sexSegmentedControl.selectedSegmentIndex == 1) {
    userProfile.sex = UserProfileSexFemale;
  }
  
  [self invalidateUserProfileSummaryRow];
}

- (void)changeBox {
  UserProfile* userProfile = [App sharedInstance].userProfile;
  userProfile.box = self.boxTextField.text;
}

- (void)changeName {  
  UserProfile* userProfile = [App sharedInstance].userProfile;
  userProfile.name = self.nameTextField.text;

  [self invalidateUserProfileSummaryRow];
}

- (void) invalidateUserProfileSummaryRow {

  dispatch_async(dispatch_get_main_queue(), ^{
    //Update the first row of the first section
    [self.myBodyViewController.tableView reloadRowsAtIndexPaths: [NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]] withRowAnimation: NO];
  });

}

- (IBAction) startChangingImage {  
  [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  
  UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
  UserProfile* userProfile = [App sharedInstance].userProfile;
  userProfile.image = image;

  if([MediaHelper enoughSpaceForImage:image]) {
    
    NSURL* imageURL = [MediaHelper saveImage:image forPurpose:MediaHelperPurposeUserProfile];
    
    if(imageURL) {
      [self.imageButton setImage:image forState:UIControlStateNormal];
      [self invalidateUserProfileSummaryRow];
    } else {
      
      [UIHelper showMessage:NSLocalizedString(@"unexpected-problem-message", "There was an unexpected problem. If the problem persists, please contact us.")
                  withTitle:NSLocalizedString(@"user-profile-cannot-change-profile-image-title", "Can't Change Profile Image")];
    }
  } else {
    
    [UIHelper showMessage:NSLocalizedString(@"no-space-in-device-message", @"Your device does not have enough space.")
                withTitle:NSLocalizedString(@"user-profile-cannot-change-profile-image-title", "Can't Change Profile Image")];
    
  }
  
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
