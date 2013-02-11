//
//  MeasurablePickerTableViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 1/2/13.
//
//

#import "MeasurablePickerTableViewController.h"
#import "MeasurablePickerTableViewCell.h"
#import "App.h"
#import "UIHelper.h"
#import "MeasurableHelper.h"

@interface MeasurablePickerTableViewController ()

@end

@implementation MeasurablePickerTableViewController

@synthesize tablePredicate = _tablePredicate;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView reloadData];
}

- (NSPredicate *)tablePredicate {
  return _tablePredicate;
}

- (void)setTablePredicate:(NSPredicate *)tablePredicate {
  _tablePredicate = tablePredicate;
  self.measurables = [self.measurables filteredArrayUsingPredicate:self.tablePredicate];
  self.measurables = [MeasurableHelper sortMeasurables:self.measurables byMeasurableSortCriterion:MeasurableSortCriterionName];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {  
  return self.measurables.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  MeasurablePickerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurablePickerTableViewCell" forIndexPath:indexPath];
  
  Measurable* measurable = [self.measurables objectAtIndex:indexPath.item];
  
  cell.textLabel.text = measurable.metadata.name;
  cell.detailTextLabel.text = measurable.metadata.metadataFull;
  
  return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.measurablePickerDelegate didPickMeasurable:[self.measurables objectAtIndex:indexPath.item]];

  //Hide it after a bit
  [self clearCurrentSelectionInABitInTableView:tableView];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return self.tableTitle;
}

- (void) clearCurrentSelectionInABitInTableView:(UITableView*) tableView {
  [UIHelper clearSelectionInTableView:tableView afterDelay:0.1];
}

@end
