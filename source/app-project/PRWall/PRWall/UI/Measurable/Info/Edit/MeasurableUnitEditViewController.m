//
//  MeasurableUnitEditViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/28/12.
//
//

#import "MeasurableUnitEditViewController.h"
#import "UIHelper.h"
#import "MeasurableHelper.h"

@interface MeasurableUnitEditViewController ()

@property Unit* selectedUnit;

@property NSArray* switches;

@property IBOutlet UILabel* generalLabel;
@property IBOutlet UILabel* massLabel;
@property IBOutlet UILabel* timeLabel;
@property IBOutlet UILabel* lengthLabel;

@property IBOutlet UISwitch* generalSwitch;
@property IBOutlet UISwitch* massSwitch;
@property IBOutlet UISwitch* timeSwitch;
@property IBOutlet UISwitch* lengthSwitch;

@property IBOutlet UISegmentedControl* lengthSegmentedControl;
@property IBOutlet UISegmentedControl* massSegmentedControl;

- (IBAction)changeSwitchState:(id)sender;
- (IBAction)changeSegmentedControlState:(id)sender;

@end

@implementation MeasurableUnitEditViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  //Title
  self.title = NSLocalizedString(@"unit-edit-title", @"How to track");
  
  //Labels
  self.generalLabel.text = [UIHelper generalNameForUnitType: UnitTypeGeneral];
  self.lengthLabel.text = [UIHelper generalNameForUnitType: UnitTypeLength];
  self.massLabel.text = [UIHelper generalNameForUnitType: UnitTypeMass];
  self.timeLabel.text = [UIHelper generalNameForUnitType: UnitTypeTime];
  
  //Switches
  self.switches = [NSArray arrayWithObjects:self.lengthSwitch, self.massSwitch,self.generalSwitch,self.timeSwitch, nil];
  
  //Segmented Controls
  [MeasurableHelper configureSegmentedControlForLengthUnit:self.lengthSegmentedControl];
  [MeasurableHelper configureSegmentedControlForMassUnit:self.massSegmentedControl];

  //Update the switch to reflect the starting selection
  if(self.selectedUnit.type == UnitTypeLength) {
    self.lengthSegmentedControl.selectedSegmentIndex = [MeasurableHelper segmentedControlIndexForLengthUnit:self.selectedUnit];
  } else if(self.selectedUnit.type == UnitTypeMass) {
    self.massSegmentedControl.selectedSegmentIndex = [MeasurableHelper segmentedControlIndexForMassUnit:self.selectedUnit];
  }

  [self changeSwitchState: [self switchForUnit:self.selectedUnit]];
  
}

- (NSUInteger)supportedInterfaceOrientations {
  return [UIHelper supportedInterfaceOrientations];
}

- (void) editUnit:(Unit*) unit {
  self.selectedUnit = unit;
  [UIHelper showViewController:self asModal:NO withTransitionTitle:@"To Edit Unit"];
}

- (UISwitch*) switchForUnit:(Unit*) unit {

  if(unit.type == UnitTypeTime) {
    return self.timeSwitch;
  } else if(unit.type == UnitTypeLength) {
    return self.lengthSwitch;
  } else if(unit.type == UnitTypeMass) {
    return self.massSwitch;
  } else {
    return self.generalSwitch;
  }
}

- (IBAction)changeSwitchState:(id)sender {
  
  UISwitch* uiSwitch = (UISwitch*) sender;

  if(uiSwitch.on) {
    
    NSMutableArray* filteredArray = [NSMutableArray arrayWithArray:self.switches];
    
    [filteredArray removeObject:uiSwitch];
    
    for (UISwitch* curSwitch in filteredArray) {
      [curSwitch setOn:NO animated:YES];
      
      if(curSwitch == self.lengthSwitch) {
        self.lengthSegmentedControl.enabled = NO;
      } else if(curSwitch == self.massSwitch) {
        self.massSegmentedControl.enabled = NO;
      }
    }
    
    if(uiSwitch == self.lengthSwitch) {
      self.lengthSegmentedControl.enabled = YES;
      [self updateUnitWithUnitIdentifier: [MeasurableHelper lengthUnitForSegmentedControlIndex:self.lengthSegmentedControl.selectedSegmentIndex]];
    } else if(uiSwitch == self.massSwitch) {
      self.massSegmentedControl.enabled = YES;
      [self updateUnitWithUnitIdentifier: [MeasurableHelper massUnitForSegmentedControlIndex:self.massSegmentedControl.selectedSegmentIndex]];
    } else if(uiSwitch == self.timeSwitch) {
      [self updateUnitWithUnitIdentifier:UnitIdentifierSecond];
    } else if(uiSwitch == self.generalSwitch) {
      [self updateUnitWithUnitIdentifier:UnitIdentifierNone];
    }

  } else {
    [uiSwitch setOn:YES animated:YES];
  }
}

- (IBAction)changeSegmentedControlState:(id)sender {
  
  if(sender == self.lengthSegmentedControl) {
    [self updateUnitWithUnitIdentifier: [MeasurableHelper lengthUnitForSegmentedControlIndex:self.lengthSegmentedControl.selectedSegmentIndex]];
  } else if(sender == self.massSegmentedControl) {
    [self updateUnitWithUnitIdentifier: [MeasurableHelper massUnitForSegmentedControlIndex:self.massSegmentedControl.selectedSegmentIndex]];
  }
}

- (void) updateUnitWithUnitIdentifier:(UnitIdentifier) unitIdentifier {
  
  if(unitIdentifier != self.selectedUnit.identifier) {
    
    self.selectedUnit = [Unit unitForUnitIdentifier:unitIdentifier];    
    [self.delegate didChangeUnit:self.selectedUnit];
  }
}

@end