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
      cell.valueTextField.text = [self.measurable.metadataProvider.unit.valueFormatter formatValue: self.measurableDataEntry.value];
    } else {
      cell.valueTextField.text = nil;
    }
    cell.valueTextField.placeholder = [self.measurable.metadataProvider.unit.valueFormatter formatValue: self.measurable.metadataProvider.valueSample];
    
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
      NSString* imagePath = [self.measurableDataEntry.images objectAtIndex:(indexPath.item - 1)];
      cell.mediaImageView.image = [UIImage imageWithContentsOfFile:imagePath];
      return cell;
      
    }
  } else if(indexPath.section == self.videosSection) {
    
    if(indexPath.item == 0) {
      
      AddMediaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddMediaTableViewCell"];
      cell.addMediaLabel.text = NSLocalizedString(@"add-video-label", @"Add Video");
      return cell;
      
    } else {
      
      EditMediaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EditMediaTableViewCell"];
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
  
  if(editingStyle == UITableViewCellEditingStyleInsert) {
    [self.mediaPickerSupport startPickingMediaAtIndexPath:indexPath];
  } else if(UITableViewCellEditingStyleDelete == editingStyle) {

    if(indexPath.section == self.imagesSection || indexPath.section == self.videosSection) {

      NSMutableArray* updatedArray = nil;
      
      if(indexPath.section == self.imagesSection) {
        updatedArray = [NSMutableArray arrayWithArray:self.measurableDataEntry.images];
        self.measurableDataEntry.images = updatedArray;
        
      } else if(indexPath.section == self.videosSection) {
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
  [self.mediaPickerSupport startPickingMediaAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
  if(toIndexPath.section == self.imagesSection || toIndexPath.section == self.videosSection) {

    if(toIndexPath.item == fromIndexPath.item) {
      return;
    }

    NSMutableArray* updatedArray = nil;
    
    if(toIndexPath.section == self.imagesSection) {
      updatedArray = [NSMutableArray arrayWithArray:self.measurableDataEntry.images];
      self.measurableDataEntry.images = updatedArray;
      
    } else if(toIndexPath.section == self.videosSection) {
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
  [UIHelper showViewController:self asModal:NO withTransitionTitle:@"To Measurable Data Entry Edit"];
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
  return self.measurable.metadataProvider.unit;
}

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
- (NSArray *)videos {
  return self.measurableDataEntry.videos;
}

- (void)setVideos:(NSArray *)videos {
  self.measurableDataEntry.videos = videos;
}

- (NSArray *)images {
  return self.measurableDataEntry.images;
}
- (void)setImages:(NSArray *)images {
  self.measurableDataEntry.images = images;
}

@end
