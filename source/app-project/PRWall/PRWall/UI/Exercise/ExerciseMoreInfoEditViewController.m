//
//  ExerciseMoreInfoEditViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/31/12.
//
//

#import "ExerciseMoreInfoEditViewController.h"
#import "Unit.h"
#import "UIHelper.h"
#import "MeasurableHelper.h"
#import "Exercise.h"
#import "ExerciseMoreInfo.h"

@interface ExerciseMoreInfoEditViewController () <UITextFieldDelegate, MeasurableValuePickerViewDelegate>

@property BOOL initializing;

@property NSMutableDictionary* selectedMoreInfo;

@property NSArray* exerciseMoreInfoIdentifiers;

@property UITextField* textFieldBeingEdited;
@property ExerciseMoreInfo* exerciseMoreInfoBeingEdited;

@property IBOutlet UILabel* generalLabel;
@property IBOutlet UILabel* massLabel;
@property IBOutlet UILabel* timeLabel;
@property IBOutlet UILabel* lengthLabel;

@property IBOutlet UISwitch* generalSwitch;
@property IBOutlet UISwitch* massSwitch;
@property IBOutlet UISwitch* timeSwitch;
@property IBOutlet UISwitch* lengthSwitch;

@property IBOutlet UITextField* generalTextField;
@property IBOutlet UITextField* massTextField;
@property IBOutlet UITextField* timeTextField;
@property IBOutlet UITextField* lengthTextField;

@property IBOutlet UIToolbar* editToolbar;

@property ExerciseMoreInfo* generalLastExerciseMoreInfo;
@property ExerciseMoreInfo* massLastExerciseMoreInfo;
@property ExerciseMoreInfo* timeLastExerciseMoreInfo;
@property ExerciseMoreInfo* lengthLastExerciseMoreInfo;

@property IBOutlet UISegmentedControl* lengthSegmentedControl;
@property IBOutlet UISegmentedControl* massSegmentedControl;

//Value Edit Pickers
@property IBOutlet MeasurableNumberValuePickerView* valueTypeNumberPickerView;
@property IBOutlet MeasurableNumberWithDecimalValuePickerView* valueTypeNumberWithDecimalPickerView;
@property IBOutlet MeasurableTimeValuePickerView* valueTypeTimePickerView;
@property IBOutlet MeasurableFootInchValuePickerView* valueTypeFootInchPickerView;

- (IBAction)changeSwitchState:(id)sender;
- (IBAction)changeSegmentedControlState:(id)sender;

- (IBAction) startEditingView:(id)sender;
- (IBAction) endEditingView;

@end

@implementation ExerciseMoreInfoEditViewController

@synthesize unit;

-(id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self) {
    self.initializing = YES;
    self.exerciseMoreInfoIdentifiers = [NSArray arrayWithObjects:ExerciseMoreInfoGeneral, ExerciseMoreInfoLength, ExerciseMoreInfoMass, ExerciseMoreInfoTime, nil];
  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Title
  self.title = NSLocalizedString(@"exercise-edit-more-info-label", @"More Info");
  
  //Labels
  self.generalLabel.text = [UIHelper generalNameForUnitType: UnitTypeGeneral];
  self.lengthLabel.text = [UIHelper generalNameForUnitType: UnitTypeLength];
  self.massLabel.text = [UIHelper generalNameForUnitType: UnitTypeMass];
  self.timeLabel.text = [UIHelper generalNameForUnitType: UnitTypeTime];
  
  //Segmented Controls
  [MeasurableHelper configureSegmentedControlForLengthUnit:self.lengthSegmentedControl];
  [MeasurableHelper configureSegmentedControlForMassUnit:self.massSegmentedControl];

  //Update the controls to reflect the provider state
  for (MeasurableMoreInfoIdentifier idenfitier in self.exerciseMoreInfoIdentifiers) {
    [self updateControlsForMeasurableMoreInfoIndentifier: idenfitier];
  }

  self.initializing = NO;
}

- (NSUInteger)supportedInterfaceOrientations {
  return [UIHelper supportedInterfaceOrientations];
}

- (void) updateControlsForMeasurableMoreInfoIndentifier:(MeasurableMoreInfoIdentifier) identifier {

  UITextField* textField = nil;
  UISwitch* uiSwitch = nil;
  UISegmentedControl* segmentedControl = nil;
  
  ExerciseMoreInfo* moreInfo = [self.selectedMoreInfo objectForKey:identifier];
  
  if(ExerciseMoreInfoGeneral == identifier) {
    textField = self.generalTextField;
    uiSwitch = self.generalSwitch;
  } else if(ExerciseMoreInfoLength == identifier) {
    textField = self.lengthTextField;
    uiSwitch = self.lengthSwitch;
    segmentedControl = self.lengthSegmentedControl;
    
    if(moreInfo) {
      self.lengthSegmentedControl.selectedSegmentIndex = [MeasurableHelper segmentedControlIndexForLengthUnit:moreInfo.unit];
    }
  } else if(ExerciseMoreInfoMass == identifier) {
    textField = self.massTextField;
    uiSwitch = self.massSwitch;
    segmentedControl = self.massSegmentedControl;
    
    if(moreInfo) {
     self.massSegmentedControl.selectedSegmentIndex = [MeasurableHelper segmentedControlIndexForMassUnit:moreInfo.unit];
    }
  } else if(ExerciseMoreInfoTime == identifier) {
    textField = self.timeTextField;
    uiSwitch = self.timeSwitch;
  }
  
  if(moreInfo) {
    textField.text = [moreInfo.unit.valueFormatter formatValue:moreInfo.value];
    textField.enabled = YES;
    uiSwitch.on = YES;
    segmentedControl.enabled = YES;
  } else {
    textField.text = nil;
    textField.enabled = NO;
    uiSwitch.on = NO;
    segmentedControl.enabled = NO;
  }
  
  [self moreInfoUpdated];
}

-(void)editExerciseMoreInfo:(NSDictionary *)moreInfo {
  self.selectedMoreInfo = [NSMutableDictionary dictionaryWithDictionary:moreInfo];
  [UIHelper showViewController:self asModal:NO withTransitionTitle:@"To Edit Exercise More Info"];
}

- (IBAction)changeSwitchState:(id)sender {
  
  UISwitch* uiSwitch = (UISwitch*)sender;
  
  if(uiSwitch.on) {
    
    ExerciseMoreInfo* exerciseMoreInfo = nil;
    if(sender == self.generalSwitch) {
      
      if(self.generalLastExerciseMoreInfo) {
        exerciseMoreInfo = self.generalLastExerciseMoreInfo;
      } else {
        exerciseMoreInfo = [[ExerciseMoreInfo alloc]initWithIdentifier:ExerciseMoreInfoGeneral];
        exerciseMoreInfo.unit = [Unit unitForUnitIdentifier:UnitIdentifierNone];
        exerciseMoreInfo.value = [exerciseMoreInfo.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithInt:1]];
      }
    } else if(sender == self.timeSwitch) {
      if(self.timeLastExerciseMoreInfo) {
        exerciseMoreInfo = self.timeLastExerciseMoreInfo;
      } else {
        exerciseMoreInfo = [[ExerciseMoreInfo alloc]initWithIdentifier:ExerciseMoreInfoTime];
        exerciseMoreInfo.unit = [Unit unitForUnitIdentifier:UnitIdentifierSecond];
        exerciseMoreInfo.value = [exerciseMoreInfo.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithInt:1]];
      }
    } else if(sender == self.lengthSwitch) {
      if(self.lengthLastExerciseMoreInfo) {
        exerciseMoreInfo = self.lengthLastExerciseMoreInfo;
      } else {
        exerciseMoreInfo = [[ExerciseMoreInfo alloc]initWithIdentifier:ExerciseMoreInfoLength];
        exerciseMoreInfo.unit = [Unit unitForUnitIdentifier:[MeasurableHelper lengthUnitForSegmentedControlIndex:self.lengthSegmentedControl.selectedSegmentIndex]];
        exerciseMoreInfo.value = [exerciseMoreInfo.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithInt:1]];
      }
    } else if(sender == self.massSwitch) {
      if(self.massLastExerciseMoreInfo) {
        exerciseMoreInfo = self.massLastExerciseMoreInfo;
      } else {
        exerciseMoreInfo = [[ExerciseMoreInfo alloc]initWithIdentifier:ExerciseMoreInfoMass];
        exerciseMoreInfo.unit = [Unit unitForUnitIdentifier:[MeasurableHelper massUnitForSegmentedControlIndex:self.massSegmentedControl.selectedSegmentIndex]];
        exerciseMoreInfo.value = [exerciseMoreInfo.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithInt:1]];
      }
    }

    if(exerciseMoreInfo != nil) {
      [self.selectedMoreInfo setObject:exerciseMoreInfo forKey:exerciseMoreInfo.identifier];
      [self updateControlsForMeasurableMoreInfoIndentifier:exerciseMoreInfo.identifier];
    }

  } else {

    ExerciseMoreInfo* exerciseMoreInfo = nil;

    if(sender == self.generalSwitch) {
      exerciseMoreInfo = (ExerciseMoreInfo*)[self.selectedMoreInfo objectForKey:ExerciseMoreInfoGeneral];
      self.generalLastExerciseMoreInfo = exerciseMoreInfo;
    } else if(sender == self.timeSwitch) {
      exerciseMoreInfo = (ExerciseMoreInfo*)[self.selectedMoreInfo objectForKey:ExerciseMoreInfoTime];
      self.timeLastExerciseMoreInfo = exerciseMoreInfo;
    } else if(sender == self.lengthSwitch) {
      exerciseMoreInfo = (ExerciseMoreInfo*)[self.selectedMoreInfo objectForKey:ExerciseMoreInfoLength];
      self.lengthLastExerciseMoreInfo = exerciseMoreInfo;
    } else if(sender == self.massSwitch) {
      exerciseMoreInfo = (ExerciseMoreInfo*)[self.selectedMoreInfo objectForKey:ExerciseMoreInfoMass];
      self.massLastExerciseMoreInfo = exerciseMoreInfo;
    }

    [self.selectedMoreInfo removeObjectForKey:exerciseMoreInfo.identifier];
    [self updateControlsForMeasurableMoreInfoIndentifier:exerciseMoreInfo.identifier];
  }
}

- (IBAction)changeSegmentedControlState:(id)sender {

  ExerciseMoreInfo* exerciseMoreInfo = nil;
  UITextField* textField = nil;
  
  if(sender == self.lengthSegmentedControl) {
    exerciseMoreInfo = (ExerciseMoreInfo*)[self.selectedMoreInfo objectForKey:ExerciseMoreInfoLength];
    exerciseMoreInfo.unit = [Unit unitForUnitIdentifier:[MeasurableHelper lengthUnitForSegmentedControlIndex:self.lengthSegmentedControl.selectedSegmentIndex]];
    textField = self.lengthTextField;
  } else if(sender == self.massSegmentedControl) {
    exerciseMoreInfo = (ExerciseMoreInfo*)[self.selectedMoreInfo objectForKey:ExerciseMoreInfoMass];
    exerciseMoreInfo.unit = [Unit unitForUnitIdentifier:[MeasurableHelper massUnitForSegmentedControlIndex:self.massSegmentedControl.selectedSegmentIndex]];
    textField = self.massTextField;
  }

  if(exerciseMoreInfo) {
    textField.text = [exerciseMoreInfo.unit.valueFormatter formatValue:exerciseMoreInfo.value];
    [self moreInfoUpdated];
  }
}

- (void) moreInfoUpdated {
  
  if(self.initializing) {
    return;
  } else {    
    [self.delegate didChangeExerciseMoreInfo:self.selectedMoreInfo];
  }
}

- (IBAction) startEditingView:(id) sender {
  
  //Hide navigation bar buttons
  self.navigationItem.hidesBackButton = YES;
  
  UITextField* textField = (UITextField*)sender;
  textField.inputAccessoryView = self.editToolbar;
  self.textFieldBeingEdited = textField;
  
  MeasurableMoreInfoIdentifier measurableMoreInfoIdentifier = nil;
  
  ExerciseMoreInfo* exerciseMoreInfo = nil;

  MeasurableValuePickerView* measurableValuePickerView = nil;
  
  //Adjust the input view
  if(textField == self.generalTextField) {
    measurableValuePickerView = self.valueTypeNumberPickerView;
    measurableMoreInfoIdentifier = ExerciseMoreInfoGeneral;
  } else if(textField == self.timeTextField) {
    measurableValuePickerView = self.valueTypeTimePickerView;
    measurableMoreInfoIdentifier = ExerciseMoreInfoTime;
  } else if(textField == self.massTextField) {
    measurableValuePickerView = self.valueTypeNumberWithDecimalPickerView;;
    measurableMoreInfoIdentifier = ExerciseMoreInfoMass;
  } else if(textField == self.lengthTextField) {
    measurableValuePickerView = self.valueTypeNumberWithDecimalPickerView;
    measurableMoreInfoIdentifier = ExerciseMoreInfoLength;
  }
  
  exerciseMoreInfo = [self.selectedMoreInfo objectForKey:measurableMoreInfoIdentifier];
  self.exerciseMoreInfoBeingEdited = exerciseMoreInfo;
  
  //Special case
  if(exerciseMoreInfo.unit.identifier == UnitIdentifierFoot) {
    measurableValuePickerView = self.valueTypeFootInchPickerView;
  }

  //Update the value
  measurableValuePickerView.value = exerciseMoreInfo.value;
  
  //Hook it as the input view
  textField.inputView = measurableValuePickerView;
}

- (IBAction) endEditingView {

  [self.textFieldBeingEdited resignFirstResponder];
  
  //Reset input/accessory views
  self.textFieldBeingEdited.inputAccessoryView = nil;
  self.textFieldBeingEdited.inputView = nil;
  
  [self.delegate didChangeExerciseMoreInfo:self.selectedMoreInfo];

  //Restore navigation buttons
  self.navigationItem.hidesBackButton = NO;
}


///////////////////////////////////////////////////////////////////
//TEXT FIELD EDITING
///////////////////////////////////////////////////////////////////

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  
  [self startEditingView:textField];
  
  return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  //Prevents the value and date fields from being manually edited
  return NO;
}

///////////////////////////////////////////////////////////////////
//VALUE FIELD EDITING
///////////////////////////////////////////////////////////////////

-(void)valueSelectionChangedInMeasurableValuePickerView:(MeasurableValuePickerView*) measurableValuePickerView {
  
  //Update data model
  self.exerciseMoreInfoBeingEdited.value = measurableValuePickerView.value;

  self.textFieldBeingEdited.text = [self.exerciseMoreInfoBeingEdited.unit.valueFormatter formatValue:self.exerciseMoreInfoBeingEdited.value];
}

- (Unit *)unit {
  return self.exerciseMoreInfoBeingEdited.unit;
}

@end
