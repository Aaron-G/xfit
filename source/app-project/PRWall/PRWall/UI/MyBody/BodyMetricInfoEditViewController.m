//
//  BodyMetricInfoEditViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "BodyMetricInfoEditViewController.h"
#import "MeasurableHelper.h"

@interface BodyMetricInfoEditViewController ()

@end

@implementation BodyMetricInfoEditViewController

#pragma mark - Table view data source

-(void)loadView {
  
  [super loadView];

  [self.tableView registerNib: [UINib nibWithNibName:@"MeasurableValueGoalTableViewCell" bundle:nil] forCellReuseIdentifier:@"MeasurableValueGoalTableViewCell"];
  [self.tableView registerNib: [UINib nibWithNibName:@"MassUnitTableViewCell" bundle:nil] forCellReuseIdentifier:@"MassUnitTableViewCell"];
  [self.tableView registerNib: [UINib nibWithNibName:@"LengthUnitTableViewCell" bundle:nil] forCellReuseIdentifier:@"LengthUnitTableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  if(self.measurable.metadataProvider.unit.type == UnitTypeLength || self.measurable.metadataProvider.unit.type == UnitTypeMass) {
    return 2;
  } else {
    return 1;
  }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if(section <= 2) {
    return 1;
  } else {
    return 0;
  }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

  if(section == 0) {
    return NSLocalizedString(@"goal-label", @"Goal");
  } else if (section == 1) {
    return NSLocalizedString(@"unit-label", @"Unit");
  }
  
  return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell* cell;
  
  if(indexPath.section == 0) {
    
    //Create and assign
    cell = [self createMeasurableValueGoalCell];
    
    //Update
    ((MeasurableValueGoalTableViewCell*)cell).measurableValueGoalSegmentedControl.selectedSegmentIndex =
    [MeasurableHelper segmentedControlIndexForMeasurableValueGoal:self.measurable.metadataProvider.valueGoal];
    
  } else if (indexPath.section == 1) {
    
    if(self.measurable.metadataProvider.unit.type == UnitTypeLength) {
      
      //Create and assign
      cell = [self createLengthUnitCell];
      
      //Update
      ((LengthUnitTableViewCell*)cell).lengthUnitSegmentedControl.selectedSegmentIndex = [MeasurableHelper segmentedControlIndexForLengthUnit:self.measurable.metadataProvider.unit];
      
    } else if(self.measurable.metadataProvider.unit.type == UnitTypeMass) {
      
      //Create and assign
      cell = [self createMassUnitCell];
      
      //Update
      ((MassUnitTableViewCell*)cell).massUnitSegmentedControl.selectedSegmentIndex = [MeasurableHelper segmentedControlIndexForMassUnit:self.measurable.metadataProvider.unit];
    }
  }
  
  //Hide the cell border
  if(cell) {
    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if([cell.class isSubclassOfClass:[MassUnitTableViewCell class]]) {
    [((MassUnitTableViewCell*)cell).massUnitSegmentedControl removeTarget:self action:NULL forControlEvents:UIControlEventValueChanged];
  } else if([cell.class isSubclassOfClass:[LengthUnitTableViewCell class]]) {
    [((LengthUnitTableViewCell*)cell).lengthUnitSegmentedControl removeTarget:self action:NULL forControlEvents:UIControlEventValueChanged];
  } else if([cell.class isSubclassOfClass:[MeasurableValueGoalTableViewCell class]]) {
    [((MeasurableValueGoalTableViewCell*)cell).measurableValueGoalSegmentedControl removeTarget:self action:NULL forControlEvents:UIControlEventValueChanged];
  }
}

- (UITableViewCell*) createMeasurableValueGoalCell {
  
  MeasurableValueGoalTableViewCell* cell = (MeasurableValueGoalTableViewCell*)[MeasurableHelper tableViewCellForMeasurableValueGoalInTableView:self.tableView];
  
  [cell.measurableValueGoalSegmentedControl addTarget:self
                                           action:@selector(changeMeasurableValueGoal:)
                                 forControlEvents:UIControlEventValueChanged];
  return cell;
}

- (UITableViewCell*) createMassUnitCell {
  
  MassUnitTableViewCell* cell = (MassUnitTableViewCell*)[MeasurableHelper tableViewCellForMassUnitInTableView:self.tableView];
  
  [cell.massUnitSegmentedControl addTarget:self
                                    action:@selector(changeMassUnit:)
                          forControlEvents:UIControlEventValueChanged];
  return cell;
}

- (UITableViewCell*) createLengthUnitCell {
  
  LengthUnitTableViewCell* cell = (LengthUnitTableViewCell*)[MeasurableHelper tableViewCellForLengthUnitInTableView: self.tableView];
  
  [cell.lengthUnitSegmentedControl addTarget:self
                                      action:@selector(changeLengthUnit:)
                            forControlEvents:UIControlEventValueChanged];
  return cell;
}

//Actions

- (IBAction) changeMassUnit:(id)sender {
  [self updateUnitWithUnitIndentifier:[MeasurableHelper massUnitForSegmentedControlIndex: ((UISegmentedControl*)sender).selectedSegmentIndex]];
}

- (IBAction) changeLengthUnit:(id)sender {
  [self updateUnitWithUnitIndentifier:[MeasurableHelper lengthUnitForSegmentedControlIndex: ((UISegmentedControl*)sender).selectedSegmentIndex]];
}

- (IBAction) changeMeasurableValueGoal:(id)sender {
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    //1- Update the goal
    self.measurable.metadataProvider.valueGoal = [MeasurableHelper measurableValueGoalForSegmentedControlIndex:((UISegmentedControl*)sender).selectedSegmentIndex];
    
    /////////////////////////////////////////////////////////////////
    //CXB_TEMP_HACK - This force the recomputation of trends
    //This will be replaced with the model update API
    self.measurable.dataProvider.values = self.measurable.dataProvider.values;
    /////////////////////////////////////////////////////////////////
    
    //2- Let the edit delegate know that things changed
    [self.delegate didEditMeasurableInfoForMeasurable:self.measurable];
  });  
}

- (void) updateUnitWithUnitIndentifier:(UnitIdentifier) unitIdentifier {
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    //1- Update the unit itself
    self.measurable.metadataProvider.unit = [Unit unitForUnitIdentifier:unitIdentifier];
    
    /////////////////////////////////////////////////////////////////
    //CXB_TEMP_HACK - This force the recomputation of trends
    //This will be replaced with the model update API
    self.measurable.dataProvider.values = self.measurable.dataProvider.values;
    /////////////////////////////////////////////////////////////////
    
    //2- Let the edit delegate know that things changed
    [self.delegate didEditMeasurableInfoForMeasurable:self.measurable];
  });
}

@end
