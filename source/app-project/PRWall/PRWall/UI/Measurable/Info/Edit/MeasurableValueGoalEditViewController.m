//
//  MeasurableValueGoalEditViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/28/12.
//
//

#import "MeasurableValueGoalEditViewController.h"
#import "UIHelper.h"
#import "MeasurableHelper.h"

@interface MeasurableValueGoalEditViewController ()

@property MeasurableValueGoal selectedMeasurableValueGoal;

@end

@implementation MeasurableValueGoalEditViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  
  self = [super initWithCoder:aDecoder];
  if (self) {
    self.title = NSLocalizedString(@"goal-label", @"Goal");
  }
  return self;
}

-(void)loadView {
  
  [super loadView];
  
  [self.tableView registerNib: [UINib nibWithNibName:@"MeasurableValueGoalTableViewCell" bundle:nil] forCellReuseIdentifier:@"MeasurableValueGoalTableViewCell"];  
}

- (void) editMeasurableValueGoal:(MeasurableValueGoal) measurableValueGoal {
  self.selectedMeasurableValueGoal = measurableValueGoal;
  [UIHelper showViewController:self asModal:NO withTransitionTitle:@"To Edit Measurable Value Goal"];
}

- (NSUInteger)supportedInterfaceOrientations {
  return [UIHelper supportedInterfaceOrientations];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //Create and assign
  UITableViewCell* cell = [self createMeasurableValueGoalCell];
  
  //Update
  ((MeasurableValueGoalTableViewCell*)cell).measurableValueGoalSegmentedControl.selectedSegmentIndex =
  [MeasurableHelper segmentedControlIndexForMeasurableValueGoal:self.selectedMeasurableValueGoal];
  
  //Hide the cell border
  if(cell) {
    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
  }
  
  return cell;
}

- (UITableViewCell*) createMeasurableValueGoalCell {
  
  MeasurableValueGoalTableViewCell* cell = (MeasurableValueGoalTableViewCell*)[MeasurableHelper tableViewCellForMeasurableValueGoalInTableView:self.tableView];
  
  [cell.measurableValueGoalSegmentedControl addTarget:self
                                           action:@selector(changeMeasurableValueGoal:)
                                 forControlEvents:UIControlEventValueChanged];
  return cell;
}

- (IBAction) changeMeasurableValueGoal:(id)sender {

  self.selectedMeasurableValueGoal = [MeasurableHelper measurableValueGoalForSegmentedControlIndex:((UISegmentedControl*)sender).selectedSegmentIndex];
  
  [self.delegate didChangeMeasurableValueGoal:self.selectedMeasurableValueGoal];  
}

@end
