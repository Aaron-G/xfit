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
#import "ShareDelegate.h"
#import "MeasurableShareDelegate.h"
#import "MeasurableLogShareDelegate.h"
#import "UIHelper.h"

@interface MeasurableLogViewController ()

@property MeasurableShareDelegate* shareDelegate;

@end

@implementation MeasurableLogViewController

@synthesize measurable = _measurable;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    // Custom initialization
    self.shareDelegate = [[MeasurableLogShareDelegate alloc]initWithViewController:self withMeasurableProvider:self];
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

- (void) share {
  [self.shareDelegate share];
}

- (void) clearLog {
  
  UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"measurable-clear-log-title", @"Clear Log?")
                                                      message:NSLocalizedString(@"measurable-clear-log-message", @"This will delete all the entries in your log permanently")
                                                     delegate:self
                                            cancelButtonTitle:NSLocalizedString(@"cancel-label", @"Cancel")
                                            otherButtonTitles:NSLocalizedString(@"delete-label", @"Delete"), nil];
  [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

  if(buttonIndex == 1) {
    /////////////////////////////////////////////////////////////////////////////////////////////////
    //THIS NEEDS TO BE UPDATED TO USE THE PROPER API
    self.measurable.dataProvider.values = [NSMutableArray array];
    [self.tableView reloadData];
    /////////////////////////////////////////////////////////////////////////////////////////////////

    [UIHelper measurableViewController].barButtonItemClearLog.enabled = NO;
  }

}

@end
