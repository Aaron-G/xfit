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

@interface UserProfileViewController ()

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

  //Update the first row of the first section
  [self.myBodyViewController.tableView reloadRowsAtIndexPaths: [NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]] withRowAnimation: NO];
}

@end
