//
//  ExerciseUnitValueDescriptorEditViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/31/12.
//
//

#import "ExerciseUnitValueDescriptorEditViewController.h"
#import "Unit.h"
#import "UIHelper.h"
#import "MeasurableHelper.h"
#import "Exercise.h"
#import "ExerciseUnitValueDescriptor.h"
#import "ModelHelper.h"

@interface ExerciseUnitValueDescriptorEditViewController () <UITextFieldDelegate, MeasurableValuePickerViewDelegate>

@property BOOL initializing;

@property NSMutableArray* selectedUnitValueDescriptors;

@property NSArray* unitTypes;

@property UITextField* textFieldBeingEdited;
@property ExerciseUnitValueDescriptor* unitValueDescriptorBeingEdited;

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

@property ExerciseUnitValueDescriptor* lastGeneralUnitValueDescriptor;
@property ExerciseUnitValueDescriptor* lastMassUnitValueDescriptor;
@property ExerciseUnitValueDescriptor* lastTimeUnitValueDescriptor;
@property ExerciseUnitValueDescriptor* lastLengthUnitValueDescriptor;

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

@implementation ExerciseUnitValueDescriptorEditViewController

@synthesize unit;

-(id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self) {
    self.initializing = YES;
    self.unitTypes = [NSArray arrayWithObjects:
                      [NSNumber numberWithInt:UnitTypeGeneral],
                      [NSNumber numberWithInt:UnitTypeLength],
                      [NSNumber numberWithInt:UnitTypeMass],
                      [NSNumber numberWithInt:UnitTypeTime],
                      nil];
  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Title
  self.title = NSLocalizedString(@"more-label", @"More");
  
  //Labels
  self.generalLabel.text = [UIHelper generalNameForUnitType: UnitTypeGeneral];
  self.lengthLabel.text = [UIHelper generalNameForUnitType: UnitTypeLength];
  self.massLabel.text = [UIHelper generalNameForUnitType: UnitTypeMass];
  self.timeLabel.text = [UIHelper generalNameForUnitType: UnitTypeTime];
  
  //Segmented Controls
  [MeasurableHelper configureSegmentedControlForLengthUnit:self.lengthSegmentedControl];
  [MeasurableHelper configureSegmentedControlForMassUnit:self.massSegmentedControl];

  //Update the controls to reflect the provider state
  for (NSNumber* unitType in self.unitTypes) {
    [self updateControlsForUnitWithUnitType:[unitType integerValue]];
  }

  self.initializing = NO;
}

- (NSUInteger)supportedInterfaceOrientations {
  return [UIHelper supportedInterfaceOrientations];
}

- (void) updateControlsForUnitWithUnitType:(NSInteger) unitType {

  UITextField* textField = nil;
  UISwitch* uiSwitch = nil;
  UISegmentedControl* segmentedControl = nil;
  
  ExerciseUnitValueDescriptor* unitValueDescriptor = [self unitValueDescriptorForUnitType:unitType];
  
  if(UnitTypeGeneral == unitType) {
    textField = self.generalTextField;
    uiSwitch = self.generalSwitch;
  } else if(UnitTypeLength == unitType) {
    textField = self.lengthTextField;
    uiSwitch = self.lengthSwitch;
    segmentedControl = self.lengthSegmentedControl;
    
    if(unitValueDescriptor) {
      self.lengthSegmentedControl.selectedSegmentIndex = [MeasurableHelper segmentedControlIndexForLengthUnit:unitValueDescriptor.unit];
    }
  } else if(UnitTypeMass == unitType) {
    textField = self.massTextField;
    uiSwitch = self.massSwitch;
    segmentedControl = self.massSegmentedControl;
    
    if(unitValueDescriptor) {
     self.massSegmentedControl.selectedSegmentIndex = [MeasurableHelper segmentedControlIndexForMassUnit:unitValueDescriptor.unit];
    }
  } else if(UnitTypeTime == unitType) {
    textField = self.timeTextField;
    uiSwitch = self.timeSwitch;
  }
  
  if(unitValueDescriptor) {
    textField.text = [unitValueDescriptor.unit.valueFormatter formatValue:unitValueDescriptor.value];
    textField.enabled = YES;
    uiSwitch.on = YES;
    segmentedControl.enabled = YES;
  } else {
    textField.text = nil;
    textField.enabled = NO;
    uiSwitch.on = NO;
    segmentedControl.enabled = NO;
  }
  
  [self unitValueDescriptorsUpdated];
}

- (void) editExerciseUnitValueDescriptors:(NSArray*) unitValueDescriptors {
  
  self.selectedUnitValueDescriptors = [NSMutableArray arrayWithArray: unitValueDescriptors];
  
  [UIHelper showViewController:self asModal:NO withTransitionTitle:@"To Edit Exercise More"];
}

- (IBAction)changeSwitchState:(id)sender {
  
  UISwitch* uiSwitch = (UISwitch*)sender;
  
  if(uiSwitch.on) {
    
    ExerciseUnitValueDescriptor* unitValueDescriptor = nil;
    
    if(sender == self.generalSwitch) {
      
      if(self.lastGeneralUnitValueDescriptor) {
        unitValueDescriptor = self.lastGeneralUnitValueDescriptor;
      } else {
        //CXB - handle - this is not being explicitly saved. but hte course of action ensures this is always saved. we may these being created over and over again.
        unitValueDescriptor = [ModelHelper newExerciseUnitValueDescriptor];
        unitValueDescriptor.unit = [Unit unitForUnitIdentifier:UnitIdentifierNone];
        unitValueDescriptor.value = [unitValueDescriptor.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithInt:1]];
      }
    } else if(sender == self.timeSwitch) {
      if(self.lastTimeUnitValueDescriptor) {
        unitValueDescriptor = self.lastTimeUnitValueDescriptor;
      } else {
        unitValueDescriptor = [ModelHelper newExerciseUnitValueDescriptor];
        unitValueDescriptor.unit = [Unit unitForUnitIdentifier:UnitIdentifierSecond];
        unitValueDescriptor.value = [unitValueDescriptor.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithInt:1]];
      }
    } else if(sender == self.lengthSwitch) {
      if(self.lastLengthUnitValueDescriptor) {
        unitValueDescriptor = self.lastLengthUnitValueDescriptor;
      } else {
        unitValueDescriptor = [ModelHelper newExerciseUnitValueDescriptor];
        unitValueDescriptor.unit = [Unit unitForUnitIdentifier:[MeasurableHelper lengthUnitForSegmentedControlIndex:self.lengthSegmentedControl.selectedSegmentIndex]];
        unitValueDescriptor.value = [unitValueDescriptor.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithInt:1]];
      }
    } else if(sender == self.massSwitch) {
      if(self.lastMassUnitValueDescriptor) {
        unitValueDescriptor = self.lastMassUnitValueDescriptor;
      } else {
        unitValueDescriptor = [ModelHelper newExerciseUnitValueDescriptor];
        unitValueDescriptor.unit = [Unit unitForUnitIdentifier:[MeasurableHelper massUnitForSegmentedControlIndex:self.massSegmentedControl.selectedSegmentIndex]];
        unitValueDescriptor.value = [unitValueDescriptor.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithInt:1]];
      }
    }

    if(unitValueDescriptor != nil) {
      
      UnitType unitType = unitValueDescriptor.unit.type;
      
      //Remove existing
      [self.selectedUnitValueDescriptors removeObject:[self unitValueDescriptorForUnitType:unitType]];
      
      //Add new
      [self.selectedUnitValueDescriptors addObject:unitValueDescriptor];
      
      [self updateControlsForUnitWithUnitType:unitType];
    }

  } else {

    ExerciseUnitValueDescriptor* unitValueDescriptor = nil;

    if(sender == self.generalSwitch) {
      unitValueDescriptor = [self unitValueDescriptorForUnitType:UnitTypeGeneral];
      self.lastGeneralUnitValueDescriptor = unitValueDescriptor;
    } else if(sender == self.timeSwitch) {
      unitValueDescriptor = [self unitValueDescriptorForUnitType:UnitTypeTime];
      self.lastTimeUnitValueDescriptor = unitValueDescriptor;
    } else if(sender == self.lengthSwitch) {
      unitValueDescriptor = [self unitValueDescriptorForUnitType:UnitTypeLength];
      self.lastLengthUnitValueDescriptor = unitValueDescriptor;
    } else if(sender == self.massSwitch) {
      unitValueDescriptor = [self unitValueDescriptorForUnitType:UnitTypeMass];
      self.lastMassUnitValueDescriptor = unitValueDescriptor;
    }

    [self.selectedUnitValueDescriptors removeObject:unitValueDescriptor];
    [self updateControlsForUnitWithUnitType:unitValueDescriptor.unit.type];
  }
}

- (IBAction)changeSegmentedControlState:(id)sender {

  ExerciseUnitValueDescriptor* unitValueDescriptor = nil;
  UITextField* textField = nil;
  
  if(sender == self.lengthSegmentedControl) {
    unitValueDescriptor = [self unitValueDescriptorForUnitType:UnitTypeLength];
    unitValueDescriptor.unit = [Unit unitForUnitIdentifier:[MeasurableHelper lengthUnitForSegmentedControlIndex:self.lengthSegmentedControl.selectedSegmentIndex]];
    textField = self.lengthTextField;
  } else if(sender == self.massSegmentedControl) {
    unitValueDescriptor = [self unitValueDescriptorForUnitType:UnitTypeMass];
    unitValueDescriptor.unit = [Unit unitForUnitIdentifier:[MeasurableHelper massUnitForSegmentedControlIndex:self.massSegmentedControl.selectedSegmentIndex]];
    textField = self.massTextField;
  }

  if(unitValueDescriptor) {
    textField.text = [unitValueDescriptor.unit.valueFormatter formatValue:unitValueDescriptor.value];
    [self unitValueDescriptorsUpdated];
  }
}

- (void) unitValueDescriptorsUpdated {
  
  if(self.initializing) {
    return;
  } else {    
    [self.delegate didChangeExerciseUnitValueDescriptors:self.selectedUnitValueDescriptors];
  }
}

- (ExerciseUnitValueDescriptor*) unitValueDescriptorForUnitType:(UnitType) unitType {
  
  //CXB TODO - refactor for performance
  for (ExerciseUnitValueDescriptor* unitValueDescriptor in self.selectedUnitValueDescriptors) {
    if(unitValueDescriptor.unit.type == unitType) {
      return unitValueDescriptor;
    }
  }
  return nil;
}

- (IBAction) startEditingView:(id) sender {
  
  //Hide navigation bar buttons
  self.navigationItem.hidesBackButton = YES;
  
  UITextField* textField = (UITextField*)sender;
  textField.inputAccessoryView = self.editToolbar;
  self.textFieldBeingEdited = textField;
  
  UnitType unitType;
  
  ExerciseUnitValueDescriptor* unitValueDescriptor = nil;

  MeasurableValuePickerView* measurableValuePickerView = nil;
  
  //Adjust the input view
  if(textField == self.generalTextField) {
    measurableValuePickerView = self.valueTypeNumberPickerView;
    unitType = UnitTypeGeneral;
  } else if(textField == self.timeTextField) {
    measurableValuePickerView = self.valueTypeTimePickerView;
    unitType = UnitTypeTime;
  } else if(textField == self.massTextField) {
    measurableValuePickerView = self.valueTypeNumberWithDecimalPickerView;;
    unitType = UnitTypeMass;
  } else if(textField == self.lengthTextField) {
    measurableValuePickerView = self.valueTypeNumberWithDecimalPickerView;
    unitType = UnitTypeLength;
  } else {
    //CXB handle
    return;
  }
  
  unitValueDescriptor = [self unitValueDescriptorForUnitType:unitType];
  self.unitValueDescriptorBeingEdited = unitValueDescriptor;
  
  //Special case
  if(unitValueDescriptor.unit.identifier == UnitIdentifierFoot) {
    measurableValuePickerView = self.valueTypeFootInchPickerView;
  }

  //Update the value
  measurableValuePickerView.value = unitValueDescriptor.value;
  
  //Hook it as the input view
  textField.inputView = measurableValuePickerView;
}

- (IBAction) endEditingView {

  [self.textFieldBeingEdited resignFirstResponder];
  
  //Reset input/accessory views
  self.textFieldBeingEdited.inputAccessoryView = nil;
  self.textFieldBeingEdited.inputView = nil;
  
  [self.delegate didChangeExerciseUnitValueDescriptors:self.selectedUnitValueDescriptors];

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
  self.unitValueDescriptorBeingEdited.value = measurableValuePickerView.value;

  self.textFieldBeingEdited.text = [self.unitValueDescriptorBeingEdited.unit.valueFormatter formatValue:self.unitValueDescriptorBeingEdited.value];
}

- (Unit *)unit {
  return self.unitValueDescriptorBeingEdited.unit;
}

@end
