//
//  ActivityTagsEditViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/27/12.
//
//

#import "ActivityTagsEditViewController.h"
#import "UIHelper.h"

@interface ActivityTagsEditViewController ()


@property NSMutableArray* selectedTags;

@property NSInteger indexOfTagBeingDeleted;

@end

@implementation ActivityTagsEditViewController

static NSMutableArray* tags;

+ (NSMutableArray*) tags {
  if(!tags) {
    tags = [NSMutableArray arrayWithObjects:@"Heavy", @"Max", @"Unbroken", @"AMRAP", nil];
  }
  return tags;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  
  self = [super initWithCoder:aDecoder];
  if (self) {
    self.title = NSLocalizedString(@"tags-label", @"Tags");
  }
  return self;
}

- (void)viewDidLoad {
  
  [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
  
  for (NSString* tag in self.selectedTags) {
    NSInteger indexOfSelectedTag = [[ActivityTagsEditViewController tags] indexOfObject:tag];
    
    if(indexOfSelectedTag >= 0) {
      [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:indexOfSelectedTag inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
  }
}

- (NSUInteger)supportedInterfaceOrientations {
  return [UIHelper supportedInterfaceOrientations];
}

- (void) editTags:(NSArray*) tags {  
  self.selectedTags = [NSMutableArray arrayWithArray: tags];
  [UIHelper showViewController:self asModal:NO withTransitionTitle:@"To Edit Tags"];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [ActivityTagsEditViewController tags].count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell* cell = nil;
  
  if(indexPath.item <[ActivityTagsEditViewController tags].count) {
    cell = [tableView dequeueReusableCellWithIdentifier:@"TagCell" forIndexPath:indexPath];
    
    NSString* tag = [[ActivityTagsEditViewController tags] objectAtIndex: indexPath.item];
    
    if([self.selectedTags containsObject:tag]) {
      cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
      cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = tag;
  } else {
    cell = [tableView dequeueReusableCellWithIdentifier:@"NewTagCell" forIndexPath:indexPath];
    UITextField* textField = (UITextField*)[cell viewWithTag:1];
    textField.placeholder = NSLocalizedString(@"activity-tags-edit-new-placeholder", @"new tag");
    textField.delegate = self;
  }
  
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString* newSelection = [[ActivityTagsEditViewController tags] objectAtIndex:indexPath.item];
  
  if([self.selectedTags containsObject:newSelection]) {
    [self.selectedTags removeObject:newSelection];
  } else {
    [self.selectedTags addObject:newSelection];
  }
  
  NSArray* indexesToUpdate = [NSArray arrayWithObjects: indexPath, nil];
  
  [self.tableView reloadRowsAtIndexPaths:indexesToUpdate withRowAnimation:NO];
  
  [self.delegate didChangeTags:self.selectedTags];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if(UITableViewCellEditingStyleDelete == editingStyle) {

    self.indexOfTagBeingDeleted = indexPath.item;
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"activity-tags-edit-delete-title", @"Delete Tag")
                                                    message:NSLocalizedString(@"activity-tags-edit-delete-message", @"")
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"cancel-label", @"Cancel")
                                          otherButtonTitles:NSLocalizedString(@"delete-label", @"Delete"), nil];
    [alert show];
  }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  if(indexPath.item <[ActivityTagsEditViewController tags].count) {
    return YES;
  } else {
    return NO;
  }
}

///////////////////////////////////////////////////////////////////
//TEXT FIELD EDITING
///////////////////////////////////////////////////////////////////

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

  if([UIHelper isEmptyString: textField.text]) {
    
    //Hide keyboard
    [textField resignFirstResponder];
    
    //Clear the add tag cell text
    textField.text = nil;

    return NO;
  }
  
  //Save the new tag text
  NSString* newTag = textField.text;
  
  //Find its new index on the current list
  NSMutableArray* indexFindingArray = [NSMutableArray arrayWithArray:[ActivityTagsEditViewController tags]];
  [indexFindingArray addObject: newTag];
  
  NSComparator comparator = ^(id obj1, id obj2) {
    return [((NSString*)obj1) caseInsensitiveCompare:((NSString*)obj2)];
  };
  
  NSInteger newTagIndex = [[indexFindingArray sortedArrayUsingComparator: comparator] indexOfObject:newTag];

  //Update master list
  [[ActivityTagsEditViewController tags] insertObject:newTag atIndex:newTagIndex];

  //Clear the add tag cell text
  textField.text = nil;
  
  //Hide the keyboard
  [textField resignFirstResponder];
  
  //Insert the new tag
  [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject: [NSIndexPath indexPathForItem:newTagIndex inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
  
  return NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  
  if(buttonIndex == 1) {
    
    NSString* tag = [[ActivityTagsEditViewController tags] objectAtIndex:self.indexOfTagBeingDeleted];

    //Update master list
    [[ActivityTagsEditViewController tags] removeObjectAtIndex:self.indexOfTagBeingDeleted];
    
    //Update selected list
    [self.selectedTags removeObject:tag];
    
    //Delete the removed row
    [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: [NSIndexPath indexPathForItem:self.indexOfTagBeingDeleted inSection:0]] withRowAnimation: UITableViewRowAnimationFade];
    
    [self.delegate didChangeTags:self.selectedTags];
  }
}

@end
