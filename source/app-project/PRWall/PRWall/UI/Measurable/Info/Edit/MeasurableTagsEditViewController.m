//
//  MeasurableTagsEditViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/27/12.
//
//

#import "MeasurableTagsEditViewController.h"
#import "UIHelper.h"
#import "MeasurableHelper.h"
#import "ModelHelper.h"

@interface MeasurableTagsEditViewController ()

@property NSArray* tags;

@property NSMutableArray* selectedTags;

@property NSInteger indexOfTagBeingDeleted;

@end

@implementation MeasurableTagsEditViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  
  self = [super initWithCoder:aDecoder];
  if (self) {
    self.title = NSLocalizedString(@"tags-label", @"Tags");
  }
  return self;
}

-(void)viewWillAppear:(BOOL)animated {
  
  for (NSString* tag in self.selectedTags) {
    NSInteger indexOfSelectedTag = [self.tags indexOfObject:tag];
    
    if(indexOfSelectedTag >= 0) {
      [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:indexOfSelectedTag inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
  }
}

- (NSUInteger)supportedInterfaceOrientations {
  return [UIHelper supportedInterfaceOrientations];
}

- (void) editTags:(NSArray*) tags {
  
  self.tags = [MeasurableHelper arraySortedByText:[ModelHelper allTags] ascending: YES];
  
  self.selectedTags = [NSMutableArray arrayWithArray: tags];
  [UIHelper showViewController:self asModal:NO withTransitionTitle:@"To Edit Tags"];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.tags.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell* cell = nil;
  
  if(indexPath.item < self.tags.count) {
    cell = [tableView dequeueReusableCellWithIdentifier:@"TagCell" forIndexPath:indexPath];
    
    Tag* tag = [self.tags objectAtIndex: indexPath.item];
    
    if([self.selectedTags containsObject:tag]) {
      cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
      cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = tag.text;
  } else {
    cell = [tableView dequeueReusableCellWithIdentifier:@"NewTagCell" forIndexPath:indexPath];
    UITextField* textField = (UITextField*)[cell viewWithTag:1];
    textField.placeholder = NSLocalizedString(@"measurable-tags-edit-new-placeholder", @"new tag");
    textField.delegate = self;
  }
  
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  Tag* newSelection = [self.tags objectAtIndex:indexPath.item];
  
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
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"measurable-tags-edit-delete-title", @"Delete Tag")
                                                    message:NSLocalizedString(@"measurable-tags-edit-delete-message", @"")
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"cancel-label", @"Cancel")
                                          otherButtonTitles:NSLocalizedString(@"delete-label", @"Delete"), nil];
    [alert show];
  }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //Not the last row - this is the add tag row
  if(indexPath.item < self.tags.count) {
    
    Tag* tag = [self.tags objectAtIndex: indexPath.item];
    
    //Only if this is a user created tag
    if(tag.source == TagSourceUser) {
      return YES;
    }
  }
  
  return NO;
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
  
  NSString* newTagText = textField.text;
  
  Tag* tagForText = [ModelHelper tagForText: newTagText];
  
  if([self.tags containsObject:tagForText]) {
    //There is a tag with this text so do not allow to be created
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"measurable-tags-edit-create-error-title", @"")
                                                    message:NSLocalizedString(@"measurable-tags-edit-tag-exists-message", @"")
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:NSLocalizedString(@"ok-label", @"OK"), nil];
    [alert show];

    return NO;
  }
  
  else {
    //This is a new tag

    //Ensure to make this a "user tag"
    tagForText.source = TagSourceUser;
    
    //CXB migrate this should not save the entire context - just the new tag
    if(![ModelHelper saveModelChanges]) {
      NSLog(@"MeasurableTagsEditViewController - could not save model changes - trying to create a new tag");
    }
    
    //Update the master list first
    self.tags = [MeasurableHelper arraySortedByText:[ModelHelper allTags] ascending: YES];
    
    //Clear the add tag cell text
    textField.text = nil;
    
    //Hide the keyboard
    [textField resignFirstResponder];
    
    //Insert the new tag
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject: [NSIndexPath indexPathForItem:[self.tags indexOfObject: tagForText] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    
    return NO;
  }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  
  if(buttonIndex == 1) {
    
    Tag* tag = [self.tags objectAtIndex:self.indexOfTagBeingDeleted];

    //CXB migrate this should not save the entire context - just the deleted tag
    if(![ModelHelper deleteModelObject:tag andSave:YES]) {
      NSLog(@"MeasurableTagsEditViewController - could not save model changes - trying to delete a tag");
    }
    
    //Update selected list
    [self.selectedTags removeObject:tag];
    
    //Update the master list first
    self.tags = [MeasurableHelper arraySortedByText:[ModelHelper allTags] ascending: YES];
    
    //Delete the removed row
    [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: [NSIndexPath indexPathForItem:self.indexOfTagBeingDeleted inSection:0]] withRowAnimation: UITableViewRowAnimationFade];
    
    [self.delegate didChangeTags:self.selectedTags];
  }
}

@end
