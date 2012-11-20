//
//  MeasurableLogViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/30/12.
//
//

#import "MeasurableLogViewController.h"
#import "MeasurableHelper.h"
#import "ShareDelegate.h"
#import "MeasurableShareDelegate.h"
#import "MeasurableLogShareDelegate.h"
#import "UIHelper.h"
#import "MeasurableDataEntryAdditionalInfoTableViewCell.h"
#import "AppConstants.h"

@interface MeasurableLogViewController ()

@property MeasurableShareDelegate* shareDelegate;

//A local copy of it is needed so that we can do inline row insertions
//to display Additional Info of Measurable.
@property NSMutableArray* measurableTableLogData;

//Index of the MeasurableDateEntry that has its Additional Info displayed
@property NSInteger indexOfMeasurableDataEntryInAdditionalInfo;

//Index of the row that has the Additional Info
@property NSInteger indexOfAdditionalInfoRow;

//IMPL NOTE
//In order for us to compute the height of a cell from heightForRowAtIndexPath, we
//create a cell before the cell is asked for, compute the height, and then use this
//same cell in the subsequent cellForRowAtIndexPath call.
//
//Once this 2 call sequence (heightForRowAtIndexPath and cellForRowAtIndexPath) has
//completed we reset this variable.
@property MeasurableDataEntryAdditionalInfoTableViewCell* additionalInfoTableViewCell;

@end

@implementation MeasurableLogViewController

@synthesize measurable = _measurable;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    // Custom initialization
    self.shareDelegate = [[MeasurableLogShareDelegate alloc]initWithViewController:self withMeasurableProvider:self];
    self.indexOfMeasurableDataEntryInAdditionalInfo = -1;
    self.indexOfAdditionalInfoRow = -1;
  }
  return self;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.measurableTableLogData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  MeasurableDataEntry* dataEntry = nil;

  if(indexPath.item < self.measurableTableLogData.count) {
    
    dataEntry = [self.measurableTableLogData objectAtIndex:indexPath.item];
    
    //This is the additional info row
    if(indexPath.item == self.indexOfAdditionalInfoRow) {
      
      UITableViewCell* tableViewCell = self.additionalInfoTableViewCell;

      //Reset it
      self.additionalInfoTableViewCell = nil;
      
      //Return it
      return tableViewCell;
    }
    //This is a measurable data entry regular row
    else {      
      return [MeasurableHelper tableViewCellForMeasurableDataEntry: dataEntry ofMeasurable: self.measurable inTableView: tableView];
    }
    
  } else {
    return [super tableView: tableView cellForRowAtIndexPath:indexPath];
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

  if(indexPath.item < self.measurableTableLogData.count) {
  
    if(indexPath.item == self.indexOfAdditionalInfoRow && !self.additionalInfoTableViewCell) {
  
      //Get the target MeasurableDataEntry
      MeasurableDataEntry* dataEntry = [self.measurableTableLogData objectAtIndex:indexPath.item];
      
      //Create a new for it
      self.additionalInfoTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"MeasurableDataEntryAdditionalInfoTableViewCell"];
      
      //This call not only sets the business data on the cell, but also auto computes the minimum height
      self.additionalInfoTableViewCell.measurableDataEntry = dataEntry;
      
      //Return the minimum height
      return self.additionalInfoTableViewCell.minimumHeight;
    }
  }
  
  return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if(section == 0) {
    //Adding this blank header to provide additional enough room between the first row of data and the
    //measurable name above it. If we remove this, the two overlap.
    return TableViewSectionTitleSpacer;
  } else {
    return [super tableView:tableView titleForHeaderInSection:section];
  }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //Prevents the editing control from showing up on the additional info rows
  if(indexPath.item == self.indexOfAdditionalInfoRow) {
    return UITableViewCellEditingStyleNone;
  } else {
    return UITableViewCellEditingStyleDelete;
  }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  /////////////////////////////////////////////////////////////////////////////////////////////////
  //THIS NEEDS TO BE UPDATED TO USE THE PROPER API
  
  //1- Update local data array
  [self.measurableTableLogData removeObjectAtIndex:indexPath.item];
  
  //2- Update Measurable with updated data array
  [self updateMeasurableDataProviderWithLocalMeasurableLogData];
  
  //3- Ensure the Measurable representation is notified of change
  [self invalidateMeasurableRow];
  /////////////////////////////////////////////////////////////////////////////////////////////////
  
  //4- Delete the removed row
  [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation: YES];
  
  //5- Update the adjacent most recent row (ensures the trend value is properly updated)

  //Do not need to update if this is the most recent value or if there are no more items in data array
  //if(indexPath.item > 0 && self.measurableTableLogData.count > 0) {
  //  [self.tableView reloadRowsAtIndexPaths: [NSArray arrayWithObject:[NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section]] withRowAnimation: NO];    
  //}
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //Ignore selection on rows displaying the additional info
  if(indexPath.item == self.indexOfAdditionalInfoRow) {
    return;
  }

  NSArray *indexPathsToInsert;
  NSArray *indexPathsToRemove;

  //This is a new select
  if(indexPath.item != self.indexOfMeasurableDataEntryInAdditionalInfo) {
    
    BOOL removedAdditionalInfoRow = NO;
    
    //The additional info for another row was being displayed, so let's hide it first
    if(self.indexOfMeasurableDataEntryInAdditionalInfo != -1) {
            
      //Update the data structure
      [self.measurableTableLogData removeObjectAtIndex:self.indexOfAdditionalInfoRow];
      
      
      //Update the remove index path array
      indexPathsToRemove = [NSArray arrayWithObjects:
                            [NSIndexPath indexPathForRow:self.indexOfAdditionalInfoRow inSection:indexPath.section],
                            nil];
      
      removedAdditionalInfoRow = YES;
    }

    NSInteger objectIndex = indexPath.item;
    
    //If needed, adjust the object index as the possible removal has an impact on it
    if(removedAdditionalInfoRow) {
    
      if(indexPath.item > self.indexOfMeasurableDataEntryInAdditionalInfo) {
        objectIndex = objectIndex - 1;
      }
    }
    
    MeasurableDataEntry* measurableDataEntry = [self.measurableTableLogData objectAtIndex:objectIndex];
    
    //If the new selected row has additional info let's get it ready to display the new info row
    if(measurableDataEntry.hasAdditionalInfo) {
      
      //Update current selection index
      self.indexOfMeasurableDataEntryInAdditionalInfo = objectIndex;
      self.indexOfAdditionalInfoRow = self.indexOfMeasurableDataEntryInAdditionalInfo + 1;

      //Update the data structure
      [self.measurableTableLogData insertObject:measurableDataEntry atIndex: self.indexOfAdditionalInfoRow];
      

      //Update the insert index path array
      indexPathsToInsert = [NSArray arrayWithObjects:
                             [NSIndexPath indexPathForRow:self.indexOfAdditionalInfoRow inSection:indexPath.section],
                             nil];    
      
    } else {
      
      //Reset current selection index
      self.indexOfMeasurableDataEntryInAdditionalInfo = -1;
      self.indexOfAdditionalInfoRow = -1;
    }
  }
  
  //This is a re-select
  else {
    
    //Just hide the additional info row
    
    //Update the data structure
    [self.measurableTableLogData removeObjectAtIndex:self.indexOfAdditionalInfoRow];
    
    
    //Update the remove index path array
    indexPathsToRemove = [NSArray arrayWithObjects:
                          [NSIndexPath indexPathForRow:self.indexOfAdditionalInfoRow inSection:indexPath.section],
                          nil];
    
    //Reset current selection index
    self.indexOfMeasurableDataEntryInAdditionalInfo = -1;
    self.indexOfAdditionalInfoRow = -1;
  }
  
  //Actually perform the change in unity
  [tableView beginUpdates];
  
  if(indexPathsToRemove) {
    [tableView deleteRowsAtIndexPaths:indexPathsToRemove withRowAnimation:UITableViewRowAnimationFade];
  }

  if(indexPathsToInsert) {
    [tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:UITableViewRowAnimationFade];
  }

  [tableView endUpdates];  
}

- (void) removeAdditionalInfoRow {

  if(self.indexOfAdditionalInfoRow > 0) {
    
    //Update the data structure
    [self.measurableTableLogData removeObjectAtIndex:self.indexOfAdditionalInfoRow];
    
    //Update the remove index path array
    NSArray *indexPathsToRemove = [NSArray arrayWithObjects:
                                   [NSIndexPath indexPathForRow:self.indexOfAdditionalInfoRow inSection:0],
                                   nil];
    
    //Reset current selection index
    self.indexOfMeasurableDataEntryInAdditionalInfo = -1;
    self.indexOfAdditionalInfoRow = -1;
    
    //Actually perform the change in unity
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToRemove withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
  }
}
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
//  return NO;
//}

//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
//  NSLog(@"Edit will start at %i", indexPath.item);
//}
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
//  NSLog(@"Edit did complete at %i", indexPath.item);
//}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
  
  //Ensure that the additional info row is not present during editing
  [self removeAdditionalInfoRow];
  
  [super setEditing:editing animated:animated];
}

- (id<Measurable>)measurable {
  return _measurable;
}
- (void)setMeasurable:(id<Measurable>)measurable {
  _measurable = measurable;
  
  self.measurableTableLogData = [NSMutableArray arrayWithArray: measurable.dataProvider.values];
  
  self.indexOfMeasurableDataEntryInAdditionalInfo = -1;
  self.indexOfAdditionalInfoRow = -1;
  
  //Reload the data for this new measurable
  [self.tableView reloadData];
}

- (void) share {
  [self.shareDelegate shareFromToolBar:[UIHelper measurableViewController].toolbar];
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
    self.measurableTableLogData = [NSMutableArray array];
    [self updateMeasurableDataProviderWithLocalMeasurableLogData];
    [self.tableView reloadData];
    
    [self invalidateMeasurableRow];
    
    /////////////////////////////////////////////////////////////////////////////////////////////////

    [UIHelper measurableViewController].barButtonItemClearLog.enabled = NO;
  }
}

-(void) updateMeasurableDataProviderWithLocalMeasurableLogData {
  self.measurable.dataProvider.values = self.measurableTableLogData;
}

- (void) invalidateMeasurableRow {
  
  dispatch_async(dispatch_get_main_queue(), ^{    
    //Tell the associated Measurable Collection Display that this measurable has changed
    [[UIHelper measurableViewController].measurableCollectionDisplay updateMeasurable: self.measurable.metadataProvider.identifier];
  });
  
}

@end
