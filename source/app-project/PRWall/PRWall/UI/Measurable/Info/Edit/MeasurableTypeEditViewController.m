//
//  MeasurableTypeEditViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/27/12.
//
//

#import "MeasurableTypeEditViewController.h"
#import "UIHelper.h"
#import "MeasurableHelper.h"

@interface MeasurableTypeEditViewController ()

@property NSArray* measurableTypes;

@property MeasurableType* selectedMeasurableType;

@end

@implementation MeasurableTypeEditViewController

@synthesize measurableTypes = _measurableTypes;

- (id)initWithCoder:(NSCoder *)aDecoder {
  
  self = [super initWithCoder:aDecoder];
  if (self) {
    self.title = NSLocalizedString(@"measurable-edit-type-label", @"What kind");
  }
  return self;
}

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  NSInteger indexOfSelectedMeasurableType = [self.measurableTypes indexOfObject:self.selectedMeasurableType];
  
  if(indexOfSelectedMeasurableType >= 0) {
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:indexOfSelectedMeasurableType inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
  }
}

- (NSUInteger)supportedInterfaceOrientations {
  return [UIHelper supportedInterfaceOrientations];
}

- (void) editMeasurableType:(MeasurableType*) measurableType {
  
  self.selectedMeasurableType = measurableType;
  self.measurableTypes = [MeasurableHelper arraySortedByName:measurableType.measurableCategory.measurableTypes ascending:YES];
  
  [UIHelper showViewController:self asModal:NO withTransitionTitle:@"To Edit Measurable Type"];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.measurableTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //CXB migrate cell
  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"KindCell" forIndexPath:indexPath];
  
  MeasurableType* measurableType = [self.measurableTypes objectAtIndex: indexPath.item];
  
  if(measurableType == self.selectedMeasurableType) {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
  } else {
    cell.accessoryType = UITableViewCellAccessoryNone;
  }
  
  cell.textLabel.text = measurableType.name;
  cell.detailTextLabel.text = measurableType.info;
  
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  MeasurableType* newSelection = [self.measurableTypes objectAtIndex:indexPath.item];
  
  if(newSelection != self.selectedMeasurableType) {
    
    NSArray* indexesToUpdate = [NSArray arrayWithObjects:[NSIndexPath indexPathForItem: [self.measurableTypes indexOfObject:self.selectedMeasurableType] inSection:0], indexPath, nil];
    
    self.selectedMeasurableType = newSelection;
    
    [self.tableView reloadRowsAtIndexPaths:indexesToUpdate withRowAnimation:NO];
    
    [self.delegate didChangeMeasurableType: self.selectedMeasurableType];
  }
}

@end