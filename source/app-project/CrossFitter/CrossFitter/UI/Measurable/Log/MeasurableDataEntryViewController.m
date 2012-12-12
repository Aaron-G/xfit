//
//  MeasurableDataEntryViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 11/21/12.
//
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "MeasurableDataEntryViewController.h"
#import "MeasurableDataEntryEditValueTableViewCell.h"
#import "MeasurableDataEntryEditDateTableViewCell.h"
#import "MeasurableDataEntryEditCommentTableViewCell.h"
#import "MeasurableDataEntryEditMediaTableViewCell.h"
#import "MeasurableDataEntryAddMediaTableViewCell.h"
#import "UIHelper.h"
#import "MeasurableHelper.h"
#import "AppViewControllerSegue.h"
#import "App.h"
#import "MediaHelper.h"
#import "AppConstants.h"
#import "FootInchFormatter.h"

@interface MeasurableDataEntryViewController ()

typedef enum {
  MeasurableDataEntryViewControllerModeEdit,
  MeasurableDataEntryViewControllerModeCreate
} MeasurableDataEntryViewControllerMode;

//Marks this View Controller as needing to update its view
@property BOOL requiresViewUpdate;

@property MeasurableDataEntry* measurableDataEntry;
@property MeasurableDataEntryViewControllerMode mode;
@property id<MeasurableDataEntryDelegate> delegate;
@property UIImagePickerController *imagePickerController;
@property UIImagePickerController *videoPickerController;

@property BOOL canPickImage;
@property BOOL canPickVideo;

@property UIView* currentlyEditingView;

@property NSMutableDictionary* videoThumbnailGenerators;

- (IBAction)doneEditingMeasurableDataEntry;
- (IBAction)cancelEditingMeasurableDataEntry;
- (IBAction)doneEditingField;
- (IBAction)doneEditingDate;

- (IBAction) startPickingVideo;
- (IBAction) startPickingImage;

@end

@implementation MeasurableDataEntryViewController

static NSInteger VALUE_SECTION = 0;
static NSInteger DATE_SECTION = 1;
static NSInteger COMMENT_SECTION = 2;
static NSInteger IMAGES_SECTION = 3;
static NSInteger VIDEOS_SECTION = 4;

static NSInteger VALUE_TEXTFIELD_TAG = 0;
static NSInteger DATE_TEXTFIELD_TAG = 1;

@synthesize measurableDataEntry = _measurableDataEntry;
@synthesize measurable = _measurable;

///////////////////////////////////////////////////////////////////////////////////////
//Standard View Controller
///////////////////////////////////////////////////////////////////////////////////////

- (id)initWithCoder:(NSCoder *)aDecoder {

  self = [super initWithCoder:aDecoder];
  if(self) {    
    self.videoThumbnailGenerators = [NSMutableDictionary dictionary];
  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Start in editing mode to show the controls we want on the table
  self.editing = YES;

  //Setup buttons
  //
  //Hide the back button so that we have control of when editing is done
  self.navigationItem.hidesBackButton = YES;
  self.navigationItem.rightBarButtonItem = self.doneBarButtonItem;
  
  //Link up the custom title view
  self.navigationItem.titleView = self.titleLabel;
  
  /////////////////////////////////////////////////////////////////
  //Customize the Date Picker Control
  /////////////////////////////////////////////////////////////////
  self.dateDatePicker.maximumDate = [NSDate date];
  
  /////////////////////////////////////////////////////////////////
  //Image Picker
  self.imagePickerController = [[UIImagePickerController alloc] init];
  self.imagePickerController.delegate = self;
  self.imagePickerController.allowsEditing = YES;
  self.imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
  self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  
  //Disable image picking if not available
  self.canPickImage = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];

  /////////////////////////////////////////////////////////////////
  //Video Picker
  self.videoPickerController = [[UIImagePickerController alloc] init];
  self.videoPickerController.delegate = self;
  self.videoPickerController.allowsEditing = YES;
  self.videoPickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
  self.videoPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  
  //Disable video picking if not available
  self.canPickVideo = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
  
}

- (void)setTitle:(NSString *)title {
  [super setTitle:title];
  self.titleLabel.text = title;
}

-(void)viewWillAppear:(BOOL)animated {
  
  if(self.requiresViewUpdate) {

    //Reload the data
    [self.tableView reloadData];
    
    //Reset the scrolling
    [self.tableView scrollToRowAtIndexPath: [NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    self.requiresViewUpdate = NO;
  }
  
  [super viewWillAppear:animated];
  
}

///////////////////////////////////////////////////////////////////////////////////////
//Table View Controller
///////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  if(section < IMAGES_SECTION) {
    return 1;
  } else if (section == IMAGES_SECTION) {
    return self.measurableDataEntry.images.count + 1;
  } else if (section == VIDEOS_SECTION) {
    return self.measurableDataEntry.videos.count + 1;
  }
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  BOOL hasValue = (self.measurableDataEntry.value != nil);

  if(indexPath.section == VALUE_SECTION && indexPath.item == 0) {
    
    MeasurableDataEntryEditValueTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurableDataEntryEditValueTableViewCell"];

    if(hasValue) {
      cell.valueTextField.text = [self.measurable.metadataProvider.unit.valueFormatter formatValue: self.measurableDataEntry.value];
    } else {
      cell.valueTextField.text = nil;
    }
    cell.valueTextField.placeholder = [self.measurable.metadataProvider.unit.valueFormatter formatValue: self.measurable.dataProvider.sampleValue];
    
    return cell;
    
  } else if(indexPath.section == DATE_SECTION && indexPath.item == 0) {
    
    MeasurableDataEntryEditDateTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurableDataEntryEditDateTableViewCell"];
    NSString *dateString = [MeasurableHelper.measurableDateFormat stringFromDate:self.measurableDataEntry.date];
    cell.dateTextField.text = dateString;
    
    return cell;
    
  } else if(indexPath.section == COMMENT_SECTION && indexPath.item == 0) {
    
    MeasurableDataEntryEditCommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurableDataEntryEditCommentTableViewCell"];
    cell.commentTextView.text = self.measurableDataEntry.comment;
    
    return cell;
    
  } else if(indexPath.section == IMAGES_SECTION) {
    
    if(indexPath.item == 0) {
      
      MeasurableDataEntryAddMediaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurableDataEntryAddMediaTableViewCell"];
      cell.addMediaLabel.text = NSLocalizedString(@"measurable-data-entry-add-picture-label", @"Add Picture");
      return cell;
      
    } else {
      
      MeasurableDataEntryEditMediaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurableDataEntryEditMediaTableViewCell"];
      NSString* imagePath = [self.measurableDataEntry.images objectAtIndex:(indexPath.item - 1)];
      cell.mediaImageView.image = [UIImage imageWithContentsOfFile:imagePath];
      return cell;
    }
  } else if(indexPath.section == VIDEOS_SECTION) {
    
    if(indexPath.item == 0) {
      
      MeasurableDataEntryAddMediaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurableDataEntryAddMediaTableViewCell"];
      cell.addMediaLabel.text = NSLocalizedString(@"measurable-data-entry-add-video-label", @"Add Video");
      return cell;
      
    } else {
      
      MeasurableDataEntryEditMediaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurableDataEntryEditMediaTableViewCell"];
      NSString* videoThumbnailPath = [MediaHelper thumbnailForVideo:[self.measurableDataEntry.videos objectAtIndex:(indexPath.item - 1)] returnDefaultIfNotAvailable:YES];
      cell.mediaImageView.image = [UIImage imageWithContentsOfFile:videoThumbnailPath];
      
      return cell;
    }
  }
    
  //Should never reach this
  return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  
  if(section == VALUE_SECTION) {
    return @"Your result";
  } else if (section == DATE_SECTION) {
    return NSLocalizedString(@"measurable-data-entry-date-section-title", @"When");
  } else if (section == COMMENT_SECTION) {
    return NSLocalizedString(@"measurable-data-entry-comment-section-title", @"Note");
  } else if (section == IMAGES_SECTION) {
    return NSLocalizedString(@"measurable-data-entry-images-section-title", @"Pictures");
  } else if (section == VIDEOS_SECTION) {
    return NSLocalizedString(@"measurable-data-entry-videos-section-title", @"Videos");
  }
  
  return [super tableView:tableView titleForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.section == COMMENT_SECTION && indexPath.item == 0) {
    return MeasurableDataEntryEditCommentTableViewCellHeight;
  } else if ((indexPath.section == IMAGES_SECTION || indexPath.section == VIDEOS_SECTION) && indexPath.item > 0) {
    return MeasurableDataEntryEditMediaTableViewCellHeight;
  } else {
   return [super tableView:tableView heightForRowAtIndexPath:indexPath];
  }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section >= IMAGES_SECTION) {
    return YES;
  } else {
    return NO;
  }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.section >= IMAGES_SECTION) {
    if (indexPath.item == 0) {
      return UITableViewCellEditingStyleInsert;
    } else {
      return UITableViewCellEditingStyleDelete;
    }
  }
  return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section >= IMAGES_SECTION) {
    if (indexPath.item > 0) {
      return YES;
    }
  }
  return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if(editingStyle == UITableViewCellEditingStyleInsert) {
    [self startPickingMediaAtIndexPath:indexPath];
  } else if(UITableViewCellEditingStyleDelete == editingStyle) {

    if(indexPath.section == IMAGES_SECTION || indexPath.section == VIDEOS_SECTION) {

      NSMutableArray* updatedArray = nil;
      
      if(indexPath.section == IMAGES_SECTION) {
        updatedArray = [NSMutableArray arrayWithArray:self.measurableDataEntry.images];
        self.measurableDataEntry.images = updatedArray;
        
      } else if(indexPath.section == VIDEOS_SECTION) {
        updatedArray = [NSMutableArray arrayWithArray:self.measurableDataEntry.videos];
        self.measurableDataEntry.videos = updatedArray;
      }
      
      //Update data array
      [updatedArray removeObjectAtIndex:(indexPath.item - 1)];

      //Delete the removed row
      [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation: YES];
    }
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self startPickingMediaAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
  if(toIndexPath.section == IMAGES_SECTION || toIndexPath.section == VIDEOS_SECTION) {

    if(toIndexPath.item == fromIndexPath.item) {
      return;
    }

    NSMutableArray* updatedArray = nil;
    
    if(toIndexPath.section == IMAGES_SECTION) {
      updatedArray = [NSMutableArray arrayWithArray:self.measurableDataEntry.images];
      self.measurableDataEntry.images = updatedArray;
      
    } else if(toIndexPath.section == VIDEOS_SECTION) {
      updatedArray = [NSMutableArray arrayWithArray:self.measurableDataEntry.videos];
      self.measurableDataEntry.videos = updatedArray;
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

///////////////////////////////////////////////////////////////////////////////////////
//Editing API
///////////////////////////////////////////////////////////////////////////////////////


-(void)editMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (id<Measurable>) measurable withDelegate:(id<MeasurableDataEntryDelegate>) delegate {  
  [self prepareAndShowMeasurableDataEntry: measurableDataEntry inMeasurable: measurable withDelegate: delegate inMode: MeasurableDataEntryViewControllerModeEdit];
}

-(void)createMeasurableDataEntryInMeasurable: (id<Measurable>) measurable withDelegate:(id<MeasurableDataEntryDelegate>) delegate {
  MeasurableDataEntry* measurableDataEntry = [MeasurableHelper createMeasurableDataEntryForMeasurable:measurable];
  [self prepareAndShowMeasurableDataEntry: measurableDataEntry inMeasurable: measurable withDelegate: delegate inMode: MeasurableDataEntryViewControllerModeCreate];
}

- (void) prepareAndShowMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable:(id<Measurable>) measurable withDelegate:(id<MeasurableDataEntryDelegate>) delegate inMode: (MeasurableDataEntryViewControllerMode) mode {
  
  //Update Mode
  self.mode = mode;
  
  //Update delegate
  self.delegate = delegate;
  
  //Update data points
  [self setMeasurableDataEntry: measurableDataEntry inMeasurable:measurable];
  
  NSString* titleFormat = nil;
  
  if (self.mode == MeasurableDataEntryViewControllerModeCreate) {
    titleFormat = NSLocalizedString(@"measurable-data-entry-screen-log-title-format", @"Log %@");
    
    self.navigationItem.leftBarButtonItem = self.cancelBarButtonItem;
    
  } else {
    titleFormat = NSLocalizedString(@"measurable-data-entry-screen-edit-title-format", @"Edit %@");
    self.navigationItem.leftBarButtonItem = nil;
  }
  
  //Updade the title
  self.title = [NSString stringWithFormat:titleFormat, self.measurable.metadataProvider.name];

  //Only allow to complete if we have data
  self.doneBarButtonItem.enabled = (measurableDataEntry.value != nil);

  //Show this VC
  AppViewControllerSegue* appViewControllerSegue =
  [[AppViewControllerSegue alloc] initWithIdentifier:@"To Measurable Data Entry Edit"
                                              source: [[UIHelper appViewController] navigationController].topViewController
                                         destination:self];
  [appViewControllerSegue perform];
  
}

-(void)setMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (id<Measurable>) measurable {
  
  _measurableDataEntry = measurableDataEntry;
  _measurable = measurable;
  self.requiresViewUpdate = YES;
}

- (IBAction)doneEditingMeasurableDataEntry {
  
  if(self.mode == MeasurableDataEntryViewControllerModeCreate) {
    [self.delegate didFinishCreatingMeasurableDataEntry:self.measurableDataEntry inMeasurable:self.measurable];
  } else if(self.mode == MeasurableDataEntryViewControllerModeEdit) {
    [self.delegate didFinishEditingMeasurableDataEntry:self.measurableDataEntry inMeasurable:self.measurable];
  }
  
  [[[UIHelper appViewController] navigationController] popViewControllerAnimated:YES];
}

- (IBAction)cancelEditingMeasurableDataEntry {
  
  if(self.mode == MeasurableDataEntryViewControllerModeCreate) {
    [self.delegate didCancelCreatingMeasurableDataEntry:self.measurableDataEntry inMeasurable:self.measurable];
  }
  
  [[[UIHelper appViewController] navigationController] popViewControllerAnimated:YES];
}

///////////////////////////////////////////////////////////////////
//COMMON EDITING
///////////////////////////////////////////////////////////////////
- (void)doneEditingField {
  [self endEditingView];
}

- (void) startEditingView:(UIView*) view {
  
  //Hide navigation bar buttons
  self.navigationItem.rightBarButtonItem = nil;
  self.navigationItem.leftBarButtonItem = nil;
  
  self.currentlyEditingView = view;
  
  if([view.class isSubclassOfClass:[UITextField class]]) {
    
    UITextField* textField = (UITextField*)view;
                                 
    textField.inputAccessoryView = self.editToolbar;
    
    if(view.tag == VALUE_TEXTFIELD_TAG) {

      MeasurableValueType valueType = self.measurable.metadataProvider.valueType;
      
      MeasurableValuePickerView* measurableValuePickerView = nil;
      
      //Adjust the input view
      if(valueType == MeasurableValueTypeNumber) {
        measurableValuePickerView = self.valueTypeNumberPickerView;
      } else if(valueType == MeasurableValueTypeNumberWithDecimal) {
        measurableValuePickerView = self.valueTypeNumberWithDecimalPickerView;
      } else if(valueType == MeasurableValueTypePercent) {
        measurableValuePickerView = self.valueTypePercentPickerView;
      } else if(valueType == MeasurableValueTypeTime) {
        measurableValuePickerView = self.valueTypeTimePickerView;
      }

      //Special case
      if(self.measurable.metadataProvider.unit.identifier == UnitIdentifierFoot) {
        measurableValuePickerView = self.valueTypeFootInchPickerView;
      }

      //Update the value
      measurableValuePickerView.value = self.measurableDataEntry.value;
      
      //Hook it as the input view
      textField.inputView = measurableValuePickerView;      
    }
    
  } else if([view.class isSubclassOfClass:[UITextView class]]) {
    ((UITextView*)view).inputAccessoryView = self.editToolbar;
  }
}

- (void) endEditingView {
  
  [self.currentlyEditingView resignFirstResponder];
  
  //Reset input/accessory views
  if([self.currentlyEditingView.class isSubclassOfClass:[UITextField class]]) {
    UITextField* textField = (UITextField*)self.currentlyEditingView;
    textField.inputAccessoryView = nil;
    textField.inputView = nil;
  } else if([self.currentlyEditingView.class isSubclassOfClass:[UITextView class]]) {
    UITextView* textView = (UITextView*)self.currentlyEditingView;
    textView.inputAccessoryView = nil;
    textView.inputView = nil;
  }  
  
  //Restore navigation buttons
  self.navigationItem.rightBarButtonItem = self.doneBarButtonItem;
  if(self.mode == MeasurableDataEntryViewControllerModeCreate) {
    self.navigationItem.leftBarButtonItem = self.cancelBarButtonItem;
  }

  self.currentlyEditingView = nil;
}

///////////////////////////////////////////////////////////////////
//TEXT VIEW EDITING
///////////////////////////////////////////////////////////////////
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {

  [self startEditingView:textView];
  
  return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
  self.measurableDataEntry.comment = ([UIHelper isEmptyString: textView.text] ? nil : textView.text);
}

///////////////////////////////////////////////////////////////////
//TEXT FIELD EDITING
///////////////////////////////////////////////////////////////////

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  
  [self startEditingView:textField];
  
  if(textField.tag == DATE_TEXTFIELD_TAG) {
    textField.inputView = self.dateDatePicker;
    self.dateDatePicker.date = self.measurableDataEntry.date; //cleo
  }
  
  return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  //Prevents the value and date fields from being manually edited
  return NO;
}

- (IBAction)doneEditingDate {
  
  //Update data model
  self.measurableDataEntry.date = self.dateDatePicker.date;
  
  //Update UI
  ((UITextField*)self.currentlyEditingView).text = [UIHelper.appDateFormat stringFromDate:self.dateDatePicker.date];  
}

///////////////////////////////////////////////////////////////////
//VALUE FIELD EDITING
///////////////////////////////////////////////////////////////////

-(void)valueSelectionChangedInMeasurableValuePickerView:(MeasurableValuePickerView*) measurableValuePickerView {

  //Only allow to be done with we have a value
  self.doneBarButtonItem.enabled = (measurableValuePickerView.value != nil);
  
  //Update data model
  self.measurableDataEntry.value = measurableValuePickerView.value;

  //Update UI
  ((UITextField*)self.currentlyEditingView).text = [self.measurable.metadataProvider.unit.valueFormatter formatValue: self.measurableDataEntry.value];
}

///////////////////////////////////////////////////////////////////
//MEDIA PICKING
///////////////////////////////////////////////////////////////////
- (void)startPickingMediaAtIndexPath:(NSIndexPath *)indexPath {
  
  if(indexPath.section == IMAGES_SECTION && indexPath.item == 0) {
    
    if(self.canPickImage) {
      [self startPickingImage];
    } else {
      [UIHelper showMessage:NSLocalizedString(@"no-image-support-message", @"Your device does not support images.")
                  withTitle:NSLocalizedString(@"measurable-data-entry-cannot-add-picture-title", "Cannot Add Picture")];
    }
  } else if(indexPath.section == VIDEOS_SECTION && indexPath.item == 0) {
    if(self.canPickVideo) {
      [self startPickingVideo];
    } else {
      [UIHelper showMessage:NSLocalizedString(@"no-video-support-message", @"Your device does not support videos.")
                  withTitle:NSLocalizedString(@"measurable-data-entry-cannot-add-video-title", "Cannot Add Video")];
    }
  }
}

- (void) addImage:(UIImage*) image orVideo:(NSURL*) video inSection:(NSInteger) section {
  
  //1- Check if there is enough space
  NSString* errorMessageTitleKey = nil;
  
  if(image && ![MediaHelper enoughSpaceForImage:image]) {
    errorMessageTitleKey = @"measurable-data-entry-cannot-add-picture-title";
  }

  if(video && ![MediaHelper enoughSpaceForVideo:video]) {
    errorMessageTitleKey = @"measurable-data-entry-cannot-add-video-title";
  }
  
  if(errorMessageTitleKey) {
    [UIHelper showMessage:NSLocalizedString(@"no-space-in-device-message", @"Your device does not have enough space.")
                withTitle:NSLocalizedString(errorMessageTitleKey, "")];
    return;
  }

  NSArray* mediaArray = nil;
  NSURL* mediaURL = nil;
  
  MediaHelperPurpose mediaHelperPurpose = [MeasurableHelper mediaHelperPurposeForMeasurable:self.measurable];
  
  if(image) {
    
    mediaURL = [MediaHelper saveImage:image forPurpose:mediaHelperPurpose];
    if(mediaURL) {
      mediaArray = self.measurableDataEntry.images;
    } else {
      errorMessageTitleKey = @"measurable-data-entry-cannot-add-picture-title";
    }
  } else if(video) {
    mediaURL = [MediaHelper saveVideo:video forPurpose:mediaHelperPurpose];
    
    if(mediaURL) {
      mediaArray = self.measurableDataEntry.videos;
      
      //Start loading the thumbnail
      //This seems to be the only way this works
      dispatch_async(dispatch_get_main_queue(), ^{
        VideoThumbnailGenerator* thumbnailGenerator = [[VideoThumbnailGenerator alloc] init];
        thumbnailGenerator.delegate = self;
        [thumbnailGenerator generateThumbnailForVideo:mediaURL.path];
        [self.videoThumbnailGenerators setObject:thumbnailGenerator forKey:mediaURL.path];
      });
      
    } else {
      errorMessageTitleKey = @"measurable-data-entry-cannot-add-video-title";
    }
  }
  
  if(errorMessageTitleKey) {
    [UIHelper showMessage:NSLocalizedString(@"unexpected-problem-message", "There was an unexpected problem. If the problem persists, please contact us.")
                withTitle:NSLocalizedString(errorMessageTitleKey, "")];
    return;
  }
  
  //Find current number of images or videos
  NSInteger numberOfMedia = [self tableView:self.tableView numberOfRowsInSection:section];
  
  //Update the data model
  NSMutableArray* updateArray = [NSMutableArray arrayWithArray:mediaArray];
  
  [updateArray addObject:mediaURL.path];
  
  //Update the appropriate data structure
  if(image) {
    self.measurableDataEntry.images = updateArray;
  } else if (video) {
    self.measurableDataEntry.videos = updateArray;
  }
  
  //Trigger UI update
  //
  //Update the insert index path array
  NSArray* indexPathsToInsert = [NSArray arrayWithObjects: [NSIndexPath indexPathForRow: numberOfMedia inSection:section], nil];
  
  //Actually perform the change
  [self.tableView beginUpdates];
  [self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:UITableViewRowAnimationFade];
  [self.tableView endUpdates];
}

///////////////////////////////////////////////////////////////////
//IMAGE PICKING
///////////////////////////////////////////////////////////////////
- (IBAction) startPickingImage {
  [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  
  if(picker == self.imagePickerController) {
    [self addImage:[info valueForKey:UIImagePickerControllerEditedImage] orVideo:nil inSection:IMAGES_SECTION];
  } else if(picker == self.videoPickerController) {
    [self addImage:nil orVideo:[info valueForKey:UIImagePickerControllerMediaURL] inSection:VIDEOS_SECTION];
  }
  
  [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self dismissViewControllerAnimated:NO completion:nil];
}

///////////////////////////////////////////////////////////////////
//VIDEO PICKING
///////////////////////////////////////////////////////////////////
- (IBAction) startPickingVideo {
  [self presentViewController:self.videoPickerController animated:YES completion:nil];
}

- (void)didGenerateThumbnailForVideo:(NSString *)video {
  
  NSInteger rowForVideo = [self.measurableDataEntry.videos indexOfObject:video];
    
  [self.videoThumbnailGenerators removeObjectForKey:video];
  
  [self.tableView reloadRowsAtIndexPaths: [NSArray arrayWithObject:[NSIndexPath indexPathForItem:(rowForVideo + 1) inSection:VIDEOS_SECTION]] withRowAnimation: NO];
}

- (void)didNotGenerateThumbnailForVideo:(NSString*) video {
    
}
@end
