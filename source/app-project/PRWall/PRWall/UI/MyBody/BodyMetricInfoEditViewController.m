//
//  BodyMetricInfoEditViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import "BodyMetricInfoEditViewController.h"

@interface BodyMetricInfoEditViewController ()


@end

@implementation BodyMetricInfoEditViewController

#pragma mark - Table view data source

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
    return NSLocalizedString(@"better-direction-title", @"Your goal");
  } else if (section == 1) {
    return NSLocalizedString(@"unit-title", @"Unit");
  }
  
  return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = nil;
  
  if(indexPath.section == 0) {
    
    //Create if needed
    if(!self.betterDirectionCell) {
      [self createBetterDirectionCell];
    }
    
    //Assign
    cell = self.betterDirectionCell;
    
    //Update
    self.betterDirectionCell.betterDirectionSegmentedControl.selectedSegmentIndex = [self segmentedControlIndexForBetterDirection:self.measurable.metadataProvider.valueTrendBetterDirection];
    
  } else if (indexPath.section == 1) {
    
    if(self.measurable.metadataProvider.unit.type == UnitTypeLength) {
      
      //Create if needed
      if(!self.lengthUnitCell) {
        [self createLengthUnitCell];
      }
      
      //Assign
      cell = self.lengthUnitCell;
      
      //Update
      self.lengthUnitCell.lengthUnitSegmentedControl.selectedSegmentIndex = [self segmentedControlIndexForLengthUnit:self.measurable.metadataProvider.unit];
      
    } else if(self.measurable.metadataProvider.unit.type == UnitTypeMass) {
      
      //Create if needed
      if(!self.massUnitCell) {
        [self createMassUnitCell];
      }
      
      //Assign
      cell = self.massUnitCell;
      
      //Update
      self.massUnitCell.massUnitSegmentedControl.selectedSegmentIndex = [self segmentedControlIndexForMassUnit:self.measurable.metadataProvider.unit];
    }
  }
  
  //Hide the cell border
  if(cell) {
    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
 }
  
  return cell;
}

@end
