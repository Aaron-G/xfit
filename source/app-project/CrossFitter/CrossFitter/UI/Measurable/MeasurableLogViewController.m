//
//  MeasurableLogViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/30/12.
//
//

#import "MeasurableLogViewController.h"
#import "MeasurableDataEntryTableViewCell.h"
#import "MeasurableHelper.h"

@interface MeasurableLogViewController ()

@end

@implementation MeasurableLogViewController

@synthesize measurable = _measurable;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    // Custom initialization
  }
  return self;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.measurable.dataProvider.values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  MeasurableDataEntry* dataEntry = nil;

  if(indexPath.item < self.measurable.dataProvider.values.count) {
    
    dataEntry = [self.measurable.dataProvider.values objectAtIndex:indexPath.item];
    
    return [MeasurableHelper tableViewCellForMeasurableDataEntry: dataEntry ofMeasurable: self.measurable inTableView: tableView];
            
  } else {
    return [super tableView: tableView cellForRowAtIndexPath:indexPath];
  }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if(section == 0) {
    //IMPL NOTE
    //Adding this blank header provides enough room between the first for of data and the
    //measurable name above it. If we remove this, the two overlap.
    return @" ";
  } else {
    return [super tableView:tableView titleForHeaderInSection:section];
  }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  /////////////////////////////////////////////////////////////////////////////////////////////////
  //THIS NEEDS TO BE UPDATED TO USE THE PROPER API
  //See 
  NSMutableArray* newValues = [NSMutableArray arrayWithArray: self.measurable.dataProvider.values];
  [newValues removeObjectAtIndex:indexPath.item];
  self.measurable.dataProvider.values = newValues;
  /////////////////////////////////////////////////////////////////////////////////////////////////
  
  [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation: YES];
}

- (id<Measurable>)measurable {
  return _measurable;
}
- (void)setMeasurable:(id<Measurable>)measurable {
  _measurable = measurable;
  
  //Reload the data for this new measurable
  [self.tableView reloadData];
}

@end
