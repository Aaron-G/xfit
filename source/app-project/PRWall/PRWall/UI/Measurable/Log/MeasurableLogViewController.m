//
//  MeasurableLogViewController.m
//  PR Wall
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
#import "MeasurableDataEntryTableViewCell.h"
#import "AppViewControllerSegue.h"

@interface MeasurableLogViewController ()

@property MeasurableShareDelegate* shareDelegate;

//A local copy of it is needed so that we can do inline row insertions
//to display Additional Info of Measurable.
@property NSMutableArray* measurableTableLogData;

//Index of the MeasurableDateEntry that has its Additional Info displayed
@property NSInteger indexOfMeasurableDataEntryInAdditionalInfo;

//Index of the row that has the Additional Info
@property NSInteger indexOfAdditionalInfoRow;

@property BOOL listeningToDeviceOrientation;

@end

@implementation MeasurableLogViewController

@synthesize layoutDelegate;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    // Custom initialization
    self.shareDelegate = [[MeasurableLogShareDelegate alloc]initWithViewController:self withMeasurableProvider:self];

    self.indexOfMeasurableDataEntryInAdditionalInfo = -1;
    self.indexOfAdditionalInfoRow = -1;
    self.listeningToDeviceOrientation = NO;
  }
  return self;
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  if(!self.listeningToDeviceOrientation) {
    [self startListeningToDeviceOrientation];
  }
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  
  if(self.listeningToDeviceOrientation) {
    [self stopListeningToDeviceOrientation];
  }
}

- (void) startListeningToDeviceOrientation {
    
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(orientationChanged:)
                                               name:UIDeviceOrientationDidChangeNotification
                                             object:nil];
  self.listeningToDeviceOrientation = YES;
}

- (void) stopListeningToDeviceOrientation {

  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIDeviceOrientationDidChangeNotification
                                                object:nil];
  self.listeningToDeviceOrientation = NO;
}

- (void)orientationChanged:(NSNotification *)notification {
  
  UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
  
  if (UIDeviceOrientationIsLandscape(deviceOrientation)) {
    [[UIHelper measurableViewController] chartMeasurableAction:nil];
  }
}

#pragma mark - Measurable Layout View Controller

- (id<MeasurableViewLayoutDelegate>)layoutDelegate {
  return [MeasurableHelper measurableLogViewLayoutDelegateForMeasurable:self.measurable];
}

- (void) reloadView {
  
  self.measurableTableLogData = [NSMutableArray arrayWithArray: self.measurable.dataProvider.values];
  
  self.indexOfMeasurableDataEntryInAdditionalInfo = -1;
  self.indexOfAdditionalInfoRow = -1;
  
  //Reload the data for this new measurable
  [self.tableView reloadData];
  
  [super forceLayout];
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

      MeasurableDataEntryAdditionalInfoTableViewCell* tableViewCell = [self tableView:tableView additionalInfoCellForRowAtIndexPath:indexPath];
      tableViewCell.measurableDataEntry = dataEntry;
      
      //Return it
      return tableViewCell;
    }
    //This is a measurable data entry regular row
    else {      
      return [MeasurableHelper tableViewCellForMeasurableDataEntry: dataEntry ofMeasurable: self.measurable inTableView: tableView];
    }
    
  }
  
  //Should never reach this 
  return nil;
}

- (MeasurableDataEntryAdditionalInfoTableViewCell *)tableView:(UITableView *)tableView additionalInfoCellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //Get the target MeasurableDataEntry
  MeasurableDataEntry* dataEntry = [self.measurableTableLogData objectAtIndex:indexPath.item];
  
  //Create a new cell for it
  MeasurableDataEntryAdditionalInfoTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"MeasurableDataEntryAdditionalInfoTableViewCell"];
  
  //This call not only sets the business data on the cell, but also auto computes the minimum height
  cell.measurableDataEntry = dataEntry;
  
  //Return the cell
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

  if(indexPath.item < self.measurableTableLogData.count) {
    
    if(indexPath.item == self.indexOfAdditionalInfoRow) {
      return [self tableView:tableView additionalInfoCellForRowAtIndexPath:indexPath].minimumHeight;
    }
    //Height of MeasurableDataEntryTableViewCell
    else {
      return MeasurableDataEntryTableViewCellHeight;
    }
  }
  
  //Should never reach this
  return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return nil;
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
  
  if(UITableViewCellEditingStyleDelete ==  editingStyle) {
    /////////////////////////////////////////////////////////////////////////////////////////////////
    //THIS NEEDS TO BE UPDATED TO USE THE PROPER API
    
    //1- Update local data array
    [self.measurableTableLogData removeObjectAtIndex:indexPath.item];
    
    //2- Update Measurable with updated data array
    [self updateMeasurableDataProviderWithLocalMeasurableLogData];
    
    /////////////////////////////////////////////////////////////////////////////////////////////////
    
    //3- Delete the removed row
    [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation: YES];
    
    //4- Update the adjacent most recent row (ensures the trend value is properly updated)
    //Do not need to update if this is the most recent value or if there are no more items in data array
    if(indexPath.item > 0 && self.measurableTableLogData.count > 0) {
      [self.tableView reloadRowsAtIndexPaths: [NSArray arrayWithObject:[NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section]] withRowAnimation: NO];
    }
    
    //If there are no more data on the table, simply revert back to non-editing mode
    if(self.measurableTableLogData.count == 0) {
      [[UIHelper measurableViewController] doneEditMeasurableLogAction:nil];
    }

    //Enable the propagation of change by the MeasurableViewController
    [[UIHelper measurableViewController].delegate didChangeMeasurable:self.measurable];
    
    [self forceLayout];
  }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if(self.editing) {
    [self editMeasurableDataEntryAtIndexPath:indexPath];
  } else {
    [self showOrHideMeasurableDataEntryAdditionalInfoAtIndexPath:indexPath];
  }
}

- (void) editMeasurableDataEntryAtIndexPath:(NSIndexPath *)indexPath {
  
  MeasurableDataEntryViewController* measurableDataEntryViewController = [MeasurableHelper measurableDataEntryViewController];
  
  [measurableDataEntryViewController editMeasurableDataEntry:[self.measurableTableLogData
                                                              objectAtIndex:indexPath.item]
                                                inMeasurable:self.measurable withDelegate:self];
}

- (void)didFinishEditingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable:(id<Measurable>)measurable {
  
  NSInteger currentIndex = [self.measurable.dataProvider.values indexOfObject:measurableDataEntry];  
  NSInteger newIndex = [self findIndexForMeasurableDataEntry:measurableDataEntry];

  if(newIndex != currentIndex) {
    
    //Update local data array
    [self.measurableTableLogData removeObjectAtIndex:currentIndex];
    [self.measurableTableLogData insertObject:measurableDataEntry atIndex:newIndex];
    
    //Update Measurable with updated data array
    [self updateMeasurableDataProviderWithLocalMeasurableLogData];
    
    //Reload the data
    [self.tableView reloadData];
    
  } else {
    
    //Simply update the row itself and the related most recent adjacent row
    NSMutableArray* indexesToUpdateArray = [NSMutableArray arrayWithCapacity:2];
    
    if(newIndex >= 0) {
      
      if(newIndex > 0) {
        [indexesToUpdateArray addObject:[NSIndexPath indexPathForItem:(newIndex-1) inSection:0]];
      }
      
      [indexesToUpdateArray addObject:[NSIndexPath indexPathForItem:(newIndex) inSection:0]];      
    }

    //Update Measurable with updated data array
    [self updateMeasurableDataProviderWithLocalMeasurableLogData];
    
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths: indexesToUpdateArray withRowAnimation: NO];
    [self.tableView endUpdates];
  }

  //Ensure the Measurable representation is notified of change
  [self notifyMeasurableViewControllerDelegate];
}

- (void) showOrHideMeasurableDataEntryAdditionalInfoAtIndexPath:(NSIndexPath *)indexPath {

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
      
      //Hide it after a bit
      [self clearCurrentSelectionInABit];
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
    
    //Clear the selection after a bit
    [self clearCurrentSelectionInABit];

  }
  
  //Actually perform the change in unity
  [self.tableView beginUpdates];
  
  if(indexPathsToRemove) {
    [self.tableView deleteRowsAtIndexPaths:indexPathsToRemove withRowAnimation:UITableViewRowAnimationFade];
  }

  if(indexPathsToInsert) {
    [self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:UITableViewRowAnimationFade];
  }

  [self.tableView endUpdates];
  
  [self forceLayout];
}

- (void) clearCurrentSelectionInABit {
  [UIHelper clearSelectionInTableView:self.tableView afterDelay:0.1];
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

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
  
  //Ensure that the additional info row is not present during editing
  [self removeAdditionalInfoRow];
  
  [super setEditing:editing animated:animated];
  
  [self.tableView setEditing:editing animated:animated];
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
    
    [self notifyMeasurableViewControllerDelegate];
    
    [self forceLayout];
    
    /////////////////////////////////////////////////////////////////////////////////////////////////

    [[UIHelper measurableViewController] doneEditMeasurableLogAction:nil];
  }
}

-(void) updateMeasurableDataProviderWithLocalMeasurableLogData {
  self.measurable.dataProvider.values = self.measurableTableLogData;
}

- (void) notifyMeasurableViewControllerDelegate {
  dispatch_async(dispatch_get_main_queue(), ^{
    [[UIHelper measurableViewController].delegate didChangeMeasurable:self.measurable];
  });  
}


- (void) logMeasurableDataEntry:(MeasurableDataEntry*)measurableDataEntry {
  
  //Find the correct index based on the date
  NSInteger indexToInsert = [self findIndexForMeasurableDataEntry:measurableDataEntry];
  
  NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow: indexToInsert inSection:0];
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    //Hide the additional info row if shown
    if(self.indexOfAdditionalInfoRow > 0) {
      [self showOrHideMeasurableDataEntryAdditionalInfoAtIndexPath:[NSIndexPath indexPathForRow: self.indexOfMeasurableDataEntryInAdditionalInfo inSection:0]];
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////
    //THIS NEEDS TO BE UPDATED TO USE THE PROPER API
    
    //1- Update local data array
    [self.measurableTableLogData insertObject:measurableDataEntry atIndex:indexPathToInsert.item];
    
    //2- Update Measurable with updated data array
    [self updateMeasurableDataProviderWithLocalMeasurableLogData];
    
    //3- Ensure the Measurable representation is notified of change
    [self notifyMeasurableViewControllerDelegate];
    /////////////////////////////////////////////////////////////////////////////////////////////////
    
    //4- Delete the removed row
    NSArray* indexPathsToInsert = [NSArray arrayWithObjects: indexPathToInsert, nil];
    [self.tableView insertRowsAtIndexPaths: indexPathsToInsert withRowAnimation: NO];

    //5- Update the adjacent most recent row (ensures the trend value is properly updated)
    //Do not need to update if this is the most recent value or if there are no more items in data array
    if(indexPathToInsert.item > 0 && self.measurableTableLogData.count > 0) {
      [self.tableView reloadRowsAtIndexPaths: [NSArray arrayWithObject:[NSIndexPath indexPathForItem:indexPathToInsert.item - 1 inSection:indexPathToInsert.section]] withRowAnimation: NO];
    }
    
    //Re evaluate the state of the toolbar buttons
    [[UIHelper measurableViewController] doneEditMeasurableLogAction:nil];
    
    [self forceLayout];
  });
}

- (NSInteger) findIndexForMeasurableDataEntry:(MeasurableDataEntry*)measurableDataEntry {
  
  NSInteger index = 0;
  for (MeasurableDataEntry* curMeasurableDataEntry in self.measurable.dataProvider.values) {
    
    if (measurableDataEntry.date == curMeasurableDataEntry.date) {
      continue;
    }
        
    if(measurableDataEntry.date == [curMeasurableDataEntry.date laterDate:measurableDataEntry.date]) {
      break;
    }
    
    index++;
  }
  return index;
}

@end