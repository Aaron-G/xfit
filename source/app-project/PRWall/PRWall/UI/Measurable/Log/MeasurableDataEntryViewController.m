//
//  MeasurableDataEntryViewController.m
//  PR Wall
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
#import "UIHelper.h"
#import "MeasurableHelper.h"
#import "AppViewControllerSegue.h"
#import "App.h"
#import "MediaHelper.h"
#import "AppConstants.h"
#import "FootInchFormatter.h"
#import "AddMediaTableViewCell.h"
#import "EditMediaTableViewCell.h"
#import "MediaPickerSupport.h"
#import "ModelHelper.h"
#import "Media.h"

@interface MeasurableDataEntryViewController () <MediaPickerSupportDelegate>

typedef enum {
  MeasurableDataEntryViewControllerModeEdit,
  MeasurableDataEntryViewControllerModeCreate
} MeasurableDataEntryViewControllerMode;

//Marks this View Controller as needing to update its view
@property BOOL requiresViewUpdate;

@property MeasurableDataEntry* measurableDataEntry;
@property MeasurableDataEntryViewControllerMode mode;
@property id<MeasurableDataEntryDelegate> delegate;

@property MediaPickerSupport* mediaPickerSupport;

@property UIView* currentlyEditingView;

- (IBAction)doneEditingMeasurableDataEntry;
- (IBAction)cancelEditingMeasurableDataEntry;
- (IBAction)doneEditingField;
- (IBAction)doneEditingDate;

@end

@implementation MeasurableDataEntryViewController

static NSInteger VALUE_SECTION = 0;
static NSInteger DATE_SECTION = 1;
static NSInteger COMMENT_SECTION = 2;

static NSInteger VALUE_TEXTFIELD_TAG = 0;
static NSInteger DATE_TEXTFIELD_TAG = 1;

@synthesize measurableDataEntry = _measurableDataEntry;
@synthesize measurable = _measurable;

@synthesize imagesSection = _imagesSection;
@synthesize videosSection = _videosSection;
@synthesize viewController = _viewController;

///////////////////////////////////////////////////////////////////////////////////////
//Standard View Controller
///////////////////////////////////////////////////////////////////////////////////////

- (id)initWithCoder:(NSCoder *)aDecoder {

  self = [super initWithCoder:aDecoder];
  if(self) {    
    self.imagesSection = 3;
    self.videosSection = 4;
    self.viewController = self;
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
  //Media Picker
  self.mediaPickerSupport = [[MediaPickerSupport alloc] init];
  self.mediaPickerSupport.delegate = self;

  [self.tableView registerNib: [UINib nibWithNibName:@"AddMediaTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddMediaTableViewCell"];
  [self.tableView registerNib: [UINib nibWithNibName:@"EditMediaTableViewCell" bundle:nil] forCellReuseIdentifier:@"EditMediaTableViewCell"];

}

- (NSUInteger)supportedInterfaceOrientations {
  return [UIHelper supportedInterfaceOrientations];
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

  if(section < self.imagesSection) {
    return 1;
  } else if (section == self.imagesSection) {
    return self.measurableDataEntry.images.count + 1;
  } else if (section == self.videosSection) {
    return self.measurableDataEntry.videos.count + 1;
  }
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  BOOL hasValue = (self.measurableDataEntry.value != nil);

  if(indexPath.section == VALUE_SECTION && indexPath.item == 0) {
    
    MeasurableDataEntryEditValueTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurableDataEntryEditValueTableViewCell"];

    if(hasValue) {
      cell.valueTextField.text = [self.measurable.metadata.unit.valueFormatter formatValue: self.measurableDataEntry.value];
    } else {
      cell.valueTextField.text = nil;
    }
    cell.valueTextField.placeholder = [self.measurable.metadata.unit.valueFormatter formatValue: self.measurable.metadata.valueSample];
    
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
    
  } else if(indexPath.section == self.imagesSection) {
    
    if(indexPath.item == 0) {

      AddMediaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddMediaTableViewCell"];
      cell.addMediaLabel.text = NSLocalizedString(@"add-picture-label", @"Add Picture");
      return cell;
      
    } else {
      
      EditMediaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EditMediaTableViewCell"];
      Media* media = [self.measurableDataEntry.images objectAtIndex:(indexPath.item - 1)];
      cell.mediaImageView.image = [UIImage imageWithContentsOfFile:media.path];
      return cell;
      
    }
  } else if(indexPath.section == self.videosSection) {
    
    if(indexPath.item == 0) {
      
      AddMediaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddMediaTableViewCell"];
      cell.addMediaLabel.text = NSLocalizedString(@"add-video-label", @"Add Video");
      return cell;
      
    } else {
      
      EditMediaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EditMediaTableViewCell"];
      Media* media = [self.measurableDataEntry.videos objectAtIndex:(indexPath.item - 1)];
      NSString* videoThumbnailPath = [MediaHelper thumbnailForVideo: media.path returnDefaultIfNotAvailable:YES];
      cell.mediaImageView.image = [UIImage imageWithContentsOfFile:videoThumbnailPath];
      
      return cell;
    }
  }
    
  //Should never reach this
  return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  
  if(section == VALUE_SECTION) {
    return nil;
  } else if (section == DATE_SECTION) {
    return NSLocalizedString(@"measurable-data-entry-date-section-title", @"When");
  } else if (section == COMMENT_SECTION) {
    return NSLocalizedString(@"measurable-data-entry-comment-section-title", @"Note");
  } else if (section == self.imagesSection) {
    return NSLocalizedString(@"images-label", @"Pictures");
  } else if (section == self.videosSection) {
    return NSLocalizedString(@"videos-label", @"Videos");
  }
  
  return [super tableView:tableView titleForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if(indexPath.section == VALUE_SECTION && indexPath.item == 0) {
    return MeasurableDataEntryEditValueTableViewCellHeight;
  } else if (indexPath.section == COMMENT_SECTION && indexPath.item == 0) {
    return MeasurableDataEntryEditCommentTableViewCellHeight;
  } else if ((indexPath.section == self.imagesSection || indexPath.section == self.videosSection) && indexPath.item > 0) {
    return EditMediaTableViewCellHeight;
  } else {
   return [super tableView:tableView heightForRowAtIndexPath:indexPath];
  }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section >= self.imagesSection) {
    return YES;
  } else {
    return NO;
  }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.section >= self.imagesSection) {
    if (indexPath.item == 0) {
      return UITableViewCellEditingStyleInsert;
    } else {
      return UITableViewCellEditingStyleDelete;
    }
  }
  return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section >= self.imagesSection) {
    if (indexPath.item > 0) {
      return YES;
    }
  }
  return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if(UITableViewCellEditingStyleDelete == editingStyle) {

    if(indexPath.section == self.imagesSection || indexPath.section == self.videosSection) {
      
      if(indexPath.section == self.imagesSection) {
        [self.measurableDataEntry removeImage: [self.measurableDataEntry.images objectAtIndex:indexPath.item - 1]];        
      } else if(indexPath.section == self.videosSection) {
        [self.measurableDataEntry removeVideo: [self.measurableDataEntry.videos objectAtIndex:indexPath.item - 1]];
      }
      
      //Delete the removed row
      [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation: YES];
    }
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //This means the user clicked on an Add row.
  //So add the new media as the last entry of the repective media
  
  NSArray* mediaArray = nil;
  
  if(indexPath.section == self.imagesSection) {
    mediaArray = self.measurableDataEntry.images;;
  } else if (indexPath.section == self.videosSection) {
    mediaArray = self.measurableDataEntry.videos;
  }
  
  if(!mediaArray) {
    return;
  }
  
  [self.mediaPickerSupport startPickingMediaAtIndexPath: [NSIndexPath indexPathForItem:mediaArray.count inSection:indexPath.section]];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
  
  [MediaHelper moveMediaAtIndexPath:fromIndexPath
                        toIndexPath:toIndexPath
                           inVideos:self.measurableDataEntry.videos
                    inVideosSection:self.videosSection
                         orInImages:self.measurableDataEntry.images
                    inImagesSection:self.imagesSection];
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


-(void)editMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (Measurable*) measurable withDelegate:(id<MeasurableDataEntryDelegate>) delegate {  
  [self prepareAndShowMeasurableDataEntry: measurableDataEntry inMeasurable: measurable withDelegate: delegate inMode: MeasurableDataEntryViewControllerModeEdit];
}

-(void)createMeasurableDataEntryInMeasurable: (Measurable*) measurable withDelegate:(id<MeasurableDataEntryDelegate>) delegate {
  [self prepareAndShowMeasurableDataEntry: nil inMeasurable: measurable withDelegate: delegate inMode: MeasurableDataEntryViewControllerModeCreate];
}

- (void) prepareAndShowMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable:(Measurable*) measurable withDelegate:(id<MeasurableDataEntryDelegate>) delegate inMode: (MeasurableDataEntryViewControllerMode) mode {

  if([ModelHelper hasUnsavedModelChanges]) {
    NSLog(@"MeasurableDataEntryViewController - model changes pending - trying to edit/create a measurable data entry");
    return;
  }
  
  //Create one if this is a new entry
  if(!measurableDataEntry) {
    measurableDataEntry = [MeasurableHelper createMeasurableDataEntryForMeasurable:measurable];
  }
  
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
  self.title = [NSString stringWithFormat:titleFormat, self.measurable.metadata.name];

  //Only allow to complete if we have data
  self.doneBarButtonItem.enabled = (measurableDataEntry.value != nil);

  //Show this VC
  [UIHelper showViewController:self asModal:NO withTransitionTitle:@"To Measurable Data Entry Edit"];
}

-(void)setMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (Measurable*) measurable {
  
  _measurableDataEntry = measurableDataEntry;
  _measurable = measurable;
  self.requiresViewUpdate = YES;
}

- (IBAction)doneEditingMeasurableDataEntry {
  
  if(self.mode == MeasurableDataEntryViewControllerModeCreate) {
    
    //Add the data entry to the measurable data
    [self.measurable.data addValue: self.measurableDataEntry];
  
    if(![ModelHelper saveModelChanges]) {
      NSLog(@"MeasurableDataEntryViewController - could not save model changes - trying to add a measurable data entry");
    }

    [self.delegate didFinishCreatingMeasurableDataEntry:self.measurableDataEntry inMeasurable:self.measurable];
  } else if(self.mode == MeasurableDataEntryViewControllerModeEdit) {
    
    if(![ModelHelper saveModelChanges]) {
      NSLog(@"MeasurableDataEntryViewController - could not save model changes - trying to edit a measurable data entry");
    }

    [self.delegate didFinishEditingMeasurableDataEntry:self.measurableDataEntry inMeasurable:self.measurable];
  }
  
  [[[UIHelper appViewController] navigationController] popViewControllerAnimated:YES];
}

- (IBAction)cancelEditingMeasurableDataEntry {
  
  if(self.mode == MeasurableDataEntryViewControllerModeCreate) {
    
    //Revert all unsaved model changes
    [ModelHelper cancelModelChanges];

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

      MeasurableValueType valueType = self.measurable.metadata.valueType;
      
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
      if([self.measurable.metadata.unit.identifier isEqualToString: UnitIdentifierFoot]) {
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
    self.dateDatePicker.date = self.measurableDataEntry.date;
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

- (Unit *)unit {
  return self.measurable.metadata.unit;
}

-(void)valueSelectionChangedInMeasurableValuePickerView:(MeasurableValuePickerView*) measurableValuePickerView {

  //Only allow to be done with we have a value
  self.doneBarButtonItem.enabled = (measurableValuePickerView.value != nil);
  
  //Update data model
  self.measurableDataEntry.value = measurableValuePickerView.value;

  //Update UI
  ((UITextField*)self.currentlyEditingView).text = [self.measurable.metadata.unit.valueFormatter formatValue: self.measurableDataEntry.value];
}


///////////////////////////////////////////////////////////////////
//MEDIA PICKING
///////////////////////////////////////////////////////////////////
- (NSArray *)videos {
  return self.measurableDataEntry.videos;
}

- (NSArray *)images {
  return self.measurableDataEntry.images;
}

- (void)pickedImage:(NSString*) path atIndexPath:(NSIndexPath *)indexPath {
  
  //Create image
  MeasurableDataEntryImage* dataEntryImage = [ModelHelper newMeasurableDataEntryImage];
  dataEntryImage.index = [NSNumber numberWithInt:indexPath.item];
  dataEntryImage.path = path;
  [self.measurableDataEntry addImage:dataEntryImage];
}

- (void)pickedVideo:(NSString*) path atIndexPath:(NSIndexPath *)indexPath {
  
  //Create video
  MeasurableDataEntryVideo* dataEntryVideo = [ModelHelper newMeasurableDataEntryVideo];
  dataEntryVideo.index = [NSNumber numberWithInt:indexPath.item];
  dataEntryVideo.path = path;
  [self.measurableDataEntry addVideo:dataEntryVideo];
}

@end
