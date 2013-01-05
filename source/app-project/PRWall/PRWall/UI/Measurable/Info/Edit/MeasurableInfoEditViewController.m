//
//  MeasurableInfoEditViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/1/12.
//
//

#import "MeasurableInfoEditViewController.h"
#import "UIHelper.h"
#import "MeasurableHelper.h"
#import "DeleteTableViewCell.h"
#import "App.h"
#import "ActivityMetadataProvider.h"

@interface MeasurableInfoEditViewController () <UIActionSheetDelegate>

@property UIView* currentlyEditingView;

- (IBAction)doneEditingField;

@end

@implementation MeasurableInfoEditViewController

@synthesize layoutDelegate;

#pragma mark - Measurable Layout View Controller
@synthesize imagesSection = _imagesSection;
@synthesize videosSection = _videosSection;
@synthesize viewController = _viewController;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];

  if(self) {
    self.mode = MeasurableInfoEditViewControllerModeEdit;
  }
  return self;
}

- (void)loadView {

  [super loadView];
  
  //Register custom table view cells
  [self.tableView registerNib: [UINib nibWithNibName:@"TableViewCellSubtitle" bundle:nil] forCellReuseIdentifier:@"TableViewCellSubtitle"];
  [self.tableView registerNib: [UINib nibWithNibName:@"NameTableViewCell" bundle:nil] forCellReuseIdentifier:@"NameTableViewCell"];
  [self.tableView registerNib: [UINib nibWithNibName:@"DescriptionTableViewCell" bundle:nil] forCellReuseIdentifier:@"DescriptionTableViewCell"];
  [self.tableView registerNib: [UINib nibWithNibName:@"OnOffTableViewCell" bundle:nil] forCellReuseIdentifier:@"OnOffTableViewCell"];
  [self.tableView registerNib: [UINib nibWithNibName:@"AddMediaTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddMediaTableViewCell"];
  [self.tableView registerNib: [UINib nibWithNibName:@"EditMediaTableViewCell" bundle:nil] forCellReuseIdentifier:@"EditMediaTableViewCell"];
  [self.tableView registerNib: [UINib nibWithNibName:@"DeleteTableViewCell" bundle:nil] forCellReuseIdentifier:@"DeleteTableViewCell"];
  
}

- (NSUInteger)supportedInterfaceOrientations {
  return [UIHelper supportedInterfaceOrientations];
}

- (void)exitMeasurableEditInfoScreen {
  
  self.navigationItem.rightBarButtonItem = nil;
  self.navigationItem.leftBarButtonItem = nil;
  
  [[UIHelper appViewController].navigationController popViewControllerAnimated:YES];
}

///////////////////////////////////////////////////////////////////
//CREATE MEASURABLE - START
///////////////////////////////////////////////////////////////////

- (void)createMeasurableInfoFromMeasurable:(id<Measurable>) measurable {
  [self createMeasurableInfoWithMeasurable:[measurable copy]];
}

- (void)createMeasurableInfo {
  [self createMeasurableInfoWithMeasurable:[self newMeasurableInstance]];
}

- (void)createMeasurableInfoWithMeasurable:(id<Measurable>) measurable {

  self.measurable = measurable;
  
  self.title = [self titleForNewScreen];
  
  self.doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneCreateMeasurable)];
  
  self.cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"cancel-label", @"Cancel")
                                                              style:UIBarButtonItemStylePlain target:self action:@selector(cancelCreateMeasurable)];
  self.navigationItem.leftBarButtonItem = self.cancelBarButtonItem;
  self.navigationItem.rightBarButtonItem = self.doneBarButtonItem;
  
  self.navigationItem.hidesBackButton = YES;
  
  self.mode = MeasurableInfoEditViewControllerModeCreate;

  [UIHelper showViewController:self asModal:NO withTransitionTitle:@"To New Measurable"];
}

- (id<Measurable>)newMeasurableInstance {
  return nil;
}

- (NSString *)titleForNewScreen {
  return [NSString stringWithFormat:NSLocalizedString(@"measurable-new-title-format", @""), self.measurable.metadataProvider.type.displayName];
}

- (NSString *)titleForCancelAlert {
  return [NSString stringWithFormat:NSLocalizedString(@"measurable-new-cancel-alert-title-format", @""), self.measurable.metadataProvider.type.displayName];
}

- (void)cancelCreateMeasurable {
  
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[self titleForCancelAlert]
                                                  message:[NSString stringWithFormat:NSLocalizedString(@"measurable-new-cancel-alert-message-format", @""), self.measurable.metadataProvider.type.displayName]
                                                 delegate:self
                                        cancelButtonTitle:NSLocalizedString(@"no-label", @"No")
                                        otherButtonTitles:NSLocalizedString(@"yes-label", @"yes"), nil];
  [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  
  if([alertView.title isEqualToString: [self titleForCancelAlert]]) {
    
   if(buttonIndex == 1) {
     
     [self exitMeasurableEditInfoScreen];
    }
  }
}

- (void)doneCreateMeasurable {

  [self.delegate didCreateMeasurableInfoForMeasurable:self.measurable];

  [self exitMeasurableEditInfoScreen];
}


///////////////////////////////////////////////////////////////////
//CREATE MEASURABLE - END
///////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////
//DELTE MEASURABLE - START
///////////////////////////////////////////////////////////////////
- (void) deleteMeasurable {
  
  UIActionSheet* actionSheet =
  [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"measurable-delete-message-format", @""), self.measurable.metadataProvider.type.displayName]
                              delegate:self
                     cancelButtonTitle:NSLocalizedString(@"cancel-label", @"Cancel")
                destructiveButtonTitle:NSLocalizedString(@"delete-label", @"Delete")
                     otherButtonTitles:nil];
  
  actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
  
  [actionSheet showFromToolbar:[UIHelper measurableViewController].toolbar];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
  
  if (buttonIndex == 0) {
    
    UserProfile* userProfile = [[App sharedInstance] userProfile];
    [userProfile.exercises removeObjectForKey:self.measurable.metadataProvider.identifier];
    
    [self.delegate didDeleteMeasurableInfoForMeasurable:self.measurable];
    
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = nil;

    [[UIHelper appViewController].navigationController popToRootViewControllerAnimated:YES];
  }
}

///////////////////////////////////////////////////////////////////
//DELTE MEASURABLE - END
///////////////////////////////////////////////////////////////////

- (void)installMediaPickerSupport {
  
  self.viewController = self;
  
  self.mediaPickerSupport = [[MediaPickerSupport alloc] init];
  self.mediaPickerSupport.delegate = self;
}

#pragma mark - Measurable Layout View Controller

- (id<MeasurableViewLayoutDelegate>) layoutDelegate {
  return [MeasurableHelper measurableInfoEditViewLayoutDelegateForMeasurable:self.measurable];
}

- (UITableViewCell*) createNameCell {
  self.nameCell = [self.tableView dequeueReusableCellWithIdentifier:@"NameTableViewCell"];
  self.nameCell.nameTextField.placeholder = [NSString stringWithFormat:NSLocalizedString(@"measurable-edit-name-placeholder-format", @"%@ name"), self.measurable.metadataProvider.type.displayName];
  
  self.nameCell.nameTextField.delegate = self;
  self.nameCell.nameTextField.text = self.measurable.metadataProvider.name;
  return self.nameCell;
}

- (UITableViewCell*) createDescriptionCell {
  self.descriptionCell = [self.tableView dequeueReusableCellWithIdentifier:@"DescriptionTableViewCell"];
  self.descriptionCell.descriptionTextView.delegate = self;
  self.descriptionCell.descriptionTextView.text = self.measurable.metadataProvider.description;

  return self.descriptionCell;
}

- (UITableViewCell*) createAddPictureCell {
  self.addPictureCell = [self.tableView dequeueReusableCellWithIdentifier:@"AddMediaTableViewCell"];
  self.addPictureCell.addMediaLabel.text = NSLocalizedString(@"add-picture-label", @"Add Picture");
  return self.addPictureCell;
}

- (UITableViewCell*) createAddVideoCell {
  self.addVideoCell = [self.tableView dequeueReusableCellWithIdentifier:@"AddMediaTableViewCell"];
  self.addVideoCell.addMediaLabel.text = NSLocalizedString(@"add-video-label", @"Add Video");
  return self.addVideoCell;
}

- (UITableViewCell*) createEditMediaCell {
  return [self.tableView dequeueReusableCellWithIdentifier:@"EditMediaTableViewCell"];
}

- (UITableViewCell*) createEditMediaCellForImageAtIndex:(NSInteger) index {
    EditMediaTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"EditMediaTableViewCell"];
    NSString* imagePath = [self.measurable.metadataProvider.images objectAtIndex:(index - 1)];
    cell.mediaImageView.image = [UIImage imageWithContentsOfFile:imagePath];
    return cell;
}

- (UITableViewCell*) createEditMediaCellForVideoAtIndex:(NSInteger) index {
  EditMediaTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"EditMediaTableViewCell"];
  NSString* videoThumbnailPath = [MediaHelper thumbnailForVideo:[self.measurable.metadataProvider.videos objectAtIndex:(index - 1)] returnDefaultIfNotAvailable:YES];
  cell.mediaImageView.image = [UIImage imageWithContentsOfFile:videoThumbnailPath];
  return cell;
}

- (UITableViewCell*) createFavoriteCell {
  
  ActivityMetadataProvider* activityMetadataProvider = (ActivityMetadataProvider*)self.measurable.metadataProvider;
  
  self.favoriteCell = [self.tableView dequeueReusableCellWithIdentifier:@"OnOffTableViewCell"];
  self.favoriteCell.onOffLabel.text = NSLocalizedString(@"favorite-label", @"Favorite");
  [self.favoriteCell.onOffButton setImage: [UIImage imageNamed:@"favorite-icon"] forState:UIControlStateNormal];
  [self.favoriteCell.onOffSwitch addTarget:self
                                    action:@selector(changeFavorite)
                          forControlEvents:UIControlEventValueChanged];
  
  self.favoriteCell.onOffSwitch.on = activityMetadataProvider.favorite;
  return self.favoriteCell;
}

- (UITableViewCell*) createPRWallCell {
  
  ActivityMetadataProvider* activityMetadataProvider = (ActivityMetadataProvider*)self.measurable.metadataProvider;
  
  self.prWallCell = [self.tableView dequeueReusableCellWithIdentifier:@"OnOffTableViewCell"];
  self.prWallCell.onOffLabel.text = NSLocalizedString(@"prwall-label", @"PR Wall");
  [self.prWallCell.onOffButton setImage: [UIImage imageNamed:@"prwall-icon"] forState:UIControlStateNormal];
  [self.prWallCell.onOffSwitch addTarget:self
                                  action:@selector(changePRWall)
                        forControlEvents:UIControlEventValueChanged];
  
  self.prWallCell.onOffSwitch.on = activityMetadataProvider.prWall;
  return self.prWallCell;
}

- (UITableViewCell*) createTagsCell {

  ActivityMetadataProvider* activityMetadataProvider = (ActivityMetadataProvider*)self.measurable.metadataProvider;
  
  self.tagsCell = [self.tableView dequeueReusableCellWithIdentifier:@"TableViewCellSubtitle"];
  self.tagsCell.textLabel.text = NSLocalizedString(@"tags-label", @"Tags");
  self.tagsCell.detailTextLabel.text = [activityMetadataProvider.tags componentsJoinedByString:NSLocalizedString(@"value-separator", @", ")];
  
  return self.tagsCell;
}

- (UITableViewCell*) createDeleteCell {
  DeleteTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"DeleteTableViewCell"];
  cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"measurable-delete-label-format", @""), self.measurable.metadataProvider.type.displayName];;
  return cell;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

  if(cell == self.prWallCell || cell == self.favoriteCell) {
    [((OnOffTableViewCell*)cell).onOffSwitch removeTarget:self action:NULL forControlEvents:UIControlEventValueChanged];
  } else if (cell == self.descriptionCell) {
    self.descriptionCell.descriptionTextView.delegate = nil;
  } else if (cell == self.nameCell) {
    self.nameCell.nameTextField.delegate = nil;
  }
}

//Add proper behavior to cell selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //Hide it after a bit
  [self clearCurrentSelectionInABit];
}

- (void) clearCurrentSelectionInABit {
  [UIHelper clearSelectionInTableView:self.tableView afterDelay:0.1];
}

- (void) changeFavorite {

  ActivityMetadataProvider* activityMetadataProvider = (ActivityMetadataProvider*)self.measurable.metadataProvider;
  
  activityMetadataProvider.favorite = self.favoriteCell.onOffSwitch.on;
}

- (void) changePRWall {
  
  ActivityMetadataProvider* activityMetadataProvider = (ActivityMetadataProvider*)self.measurable.metadataProvider;
  
  activityMetadataProvider.prWall = self.prWallCell.onOffSwitch.on;
}

- (void) editTags {
 
  ActivityMetadataProvider* activityMetadataProvider = (ActivityMetadataProvider*)self.measurable.metadataProvider;
  
  ActivityTagsEditViewController* tagsEditViewController =
  (ActivityTagsEditViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier: @"ActivityTagsEditViewController"];
  tagsEditViewController.delegate = self;
  [tagsEditViewController editTags:activityMetadataProvider.tags];
}

- (void)didChangeTags:(NSArray *)tags {
  ActivityMetadataProvider* activityMetadataProvider = (ActivityMetadataProvider*)self.measurable.metadataProvider;
  activityMetadataProvider.tags = tags;
}

///////////////////////////////////////////////////////////////////
//TEXT FIELD EDITING
///////////////////////////////////////////////////////////////////

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  
  [self startEditingView:textField];
  
  return YES;
}


///////////////////////////////////////////////////////////////////
//TEXT VIEW EDITING
///////////////////////////////////////////////////////////////////

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
  
  [self startEditingView:textView];
  
  return YES;
}


///////////////////////////////////////////////////////////////////
//COMMON EDITING
///////////////////////////////////////////////////////////////////
- (IBAction)doneEditingField {
  [self.currentlyEditingView resignFirstResponder];
  
  [self endEditingView];
}

- (void) startEditingView:(UIView*) view {
  
  if(self.currentlyEditingView) {
    [self endEditingView];
  }
  
  //Hide navigation bar buttons
  UIViewController* viewController = nil;
  
  if(self.mode == MeasurableInfoEditViewControllerModeEdit) {
    viewController = [UIHelper measurableViewController];
  } else {
    viewController = self;
  }
  
  viewController.navigationItem.rightBarButtonItem = nil;
  viewController.navigationItem.leftBarButtonItem = nil;
  
  self.currentlyEditingView = view;
  
  if([view.class isSubclassOfClass:[UITextField class]]) {
    ((UITextField*)view).inputAccessoryView = self.editToolbar;    
  } else if([view.class isSubclassOfClass:[UITextView class]]) {
    ((UITextView*)view).inputAccessoryView = self.editToolbar;
  }
}

- (void) endEditingView {
  
  //Reset input/accessory views
  if([self.currentlyEditingView.class isSubclassOfClass:[UITextField class]]) {
    UITextField* textField = (UITextField*)self.currentlyEditingView;
    
    self.measurable.metadataProvider.name = ([UIHelper isEmptyString: textField.text] ? nil : textField.text);
    
    textField.inputAccessoryView = nil;
    textField.inputView = nil;
    
    
  } else if([self.currentlyEditingView.class isSubclassOfClass:[UITextView class]]) {
    UITextView* textView = (UITextView*)self.currentlyEditingView;
    
    self.measurable.metadataProvider.description = ([UIHelper isEmptyString: textView.text] ? nil : textView.text);
    
    textView.inputAccessoryView = nil;
    textView.inputView = nil;
  }
  
  //Restore navigation buttons
  if(self.mode == MeasurableInfoEditViewControllerModeEdit) {
    MeasurableViewController* measurableViewController = [UIHelper measurableViewController];
    measurableViewController.navigationItem.rightBarButtonItem = measurableViewController.barButtonItemDoneInfo;
  } else {
    self.navigationItem.rightBarButtonItem = self.doneBarButtonItem;
    self.navigationItem.leftBarButtonItem = self.cancelBarButtonItem;
  }

  //2- Let the delegate know the measurable was edited
  [self.delegate didEditMeasurableInfoForMeasurable:self.measurable];
  
  self.currentlyEditingView = nil;
}

///////////////////////////////////////////////////////////////////
//Media Picker Support Delegate
///////////////////////////////////////////////////////////////////

- (NSArray *)videos {
  return self.measurable.metadataProvider.videos;
}

- (void)setVideos:(NSArray *)videos {
  self.measurable.metadataProvider.videos = videos;
}

- (NSArray *)images {
  return self.measurable.metadataProvider.images;
}
- (void)setImages:(NSArray *)images {
  self.measurable.metadataProvider.images = images;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
  
  //Ensures users cannot move image and video rows outside their respective sections
  if (sourceIndexPath.section != proposedDestinationIndexPath.section) {
    NSInteger row = 1;
    if (sourceIndexPath.section < proposedDestinationIndexPath.section) {
      row = [tableView numberOfRowsInSection:sourceIndexPath.section] - 1;
    }
    return [NSIndexPath indexPathForRow:row inSection:sourceIndexPath.section];
  } else {
    
    if(proposedDestinationIndexPath.item == 0) {
      return [NSIndexPath indexPathForRow:1 inSection:sourceIndexPath.section];
    }
  }
  
  return proposedDestinationIndexPath;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
  if(toIndexPath.section == self.imagesSection || toIndexPath.section == self.videosSection) {
    
    if(toIndexPath.item == fromIndexPath.item) {
      return;
    }
    
    NSMutableArray* updatedArray = nil;
    
    if(toIndexPath.section == self.imagesSection) {
      updatedArray = [NSMutableArray arrayWithArray:self.measurable.metadataProvider.images];
      self.measurable.metadataProvider.images = updatedArray;
      
    } else if(toIndexPath.section == self.videosSection) {
      updatedArray = [NSMutableArray arrayWithArray:self.measurable.metadataProvider.videos];
      self.measurable.metadataProvider.videos = updatedArray;
    }
    
    //Update data array
    NSString* mediaPath = [updatedArray objectAtIndex:(fromIndexPath.item - 1)];
    
    [updatedArray removeObjectAtIndex:(fromIndexPath.item - 1)];
    
    if(fromIndexPath.item > toIndexPath.item) {
      [updatedArray insertObject:mediaPath atIndex:(toIndexPath.item - 1)];
    } else {
      [updatedArray insertObject:mediaPath atIndex:(toIndexPath.item - 1 - 1)];
    }
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if(indexPath.section == 0) {
    
    if(indexPath.item == 1) {
      return DescriptionTableViewCellHeight;
    }
    
  } else if (indexPath.section == self.imagesSection || indexPath.section == self.videosSection) {
    
    if(indexPath.item > 0) {
      return EditMediaTableViewCellHeight;
    }
  }
  
  return self.tableView.rowHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == self.imagesSection || indexPath.section == self.videosSection) {
    return YES;
  }
  return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if(editingStyle == UITableViewCellEditingStyleInsert) {
    [self.mediaPickerSupport startPickingMediaAtIndexPath:indexPath];
  } else if(UITableViewCellEditingStyleDelete == editingStyle) {
    
    if(indexPath.section == self.imagesSection || indexPath.section == self.videosSection) {
      
      NSMutableArray* updatedArray = nil;
      
      if(indexPath.section == self.imagesSection) {
        updatedArray = [NSMutableArray arrayWithArray:self.measurable.metadataProvider.images];
        self.measurable.metadataProvider.images = updatedArray;
        
      } else if(indexPath.section == self.videosSection) {
        updatedArray = [NSMutableArray arrayWithArray:self.measurable.metadataProvider.videos];
        self.measurable.metadataProvider.videos = updatedArray;
      }
      
      //Update data array
      [updatedArray removeObjectAtIndex:(indexPath.item - 1)];
      
      //Delete the removed row
      [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation: YES];
    }
  }
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.section == self.imagesSection || indexPath.section == self.videosSection) {
    if (indexPath.item == 0) {
      return UITableViewCellEditingStyleInsert;
    } else {
      return UITableViewCellEditingStyleDelete;
    }
  }
  return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == self.imagesSection || indexPath.section == self.videosSection) {
    if (indexPath.item > 0) {
      return YES;
    }
  }
  return NO;
}

- (UITableViewCell*) createCellForImagesSectionAtIndexPath:(NSIndexPath*) indexPath {

  UITableViewCell* cell = nil;
  
  if(indexPath.item == 0) {
    cell = [self createAddPictureCell];
  } else {
    cell = [self createEditMediaCellForImageAtIndex:indexPath.item];
  }
  return cell;
}

- (UITableViewCell*) createCellForVideosSectionAtIndexPath:(NSIndexPath*) indexPath {
  
  UITableViewCell* cell = nil;
  
  if(indexPath.item == 0) {
    cell = [self createAddVideoCell];
  } else {
    cell = [self createEditMediaCellForVideoAtIndex:indexPath.item];
  }
  return cell;
}
@end


