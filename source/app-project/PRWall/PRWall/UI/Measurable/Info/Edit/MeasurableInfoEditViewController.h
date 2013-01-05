//
//  MeasurableInfoEditViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/1/12.
//
//

#import <UIKit/UIKit.h>
#import "MeasurableInfoEditViewControllerDelegate.h"
#import "MeasurableValueGoalTableViewCell.h"
#import "MassUnitTableViewCell.h"
#import "LengthUnitTableViewCell.h"
#import "MeasurableLayoutViewController.h"
#import "TableViewCellSubtitle.h"
#import "NameTableViewCell.h"
#import "DescriptionTableViewCell.h"
#import "OnOffTableViewCell.h"
#import "AddMediaTableViewCell.h"
#import "EditMediaTableViewCell.h"
#import "ActivityTagsEditViewController.h"
#import "MediaPickerSupport.h"

typedef enum {
  MeasurableInfoEditViewControllerModeCreate,
  MeasurableInfoEditViewControllerModeEdit
} MeasurableInfoEditViewControllerMode;

@interface MeasurableInfoEditViewController : MeasurableLayoutViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UITextFieldDelegate, ActivityTagsEditViewControllerDelegate, MediaPickerSupportDelegate>

@property id<MeasurableInfoEditViewControllerDelegate> delegate;

@property MeasurableInfoEditViewControllerMode mode;

//Subclasses properties
@property TableViewCellSubtitle* tagsCell;
@property NameTableViewCell* nameCell;
@property DescriptionTableViewCell* descriptionCell;
@property OnOffTableViewCell* favoriteCell;
@property OnOffTableViewCell* prWallCell;
@property AddMediaTableViewCell* addPictureCell;
@property AddMediaTableViewCell* addVideoCell;
@property MediaPickerSupport* mediaPickerSupport;

//Outlets
@property IBOutlet UITableView* tableView;
@property IBOutlet UIToolbar* editToolbar;

@property IBOutlet UIBarButtonItem* doneBarButtonItem;
@property IBOutlet UIBarButtonItem* cancelBarButtonItem;

- (void)createMeasurableInfo;
- (void)createMeasurableInfoFromMeasurable:(id<Measurable>) measurable;

//Subclasses methods

- (UITableViewCell*) createTagsCell;
- (UITableViewCell*) createNameCell;
- (UITableViewCell*) createDescriptionCell;
- (UITableViewCell*) createPRWallCell;
- (UITableViewCell*) createFavoriteCell;
- (UITableViewCell*) createAddPictureCell;
- (UITableViewCell*) createCellForImagesSectionAtIndexPath:(NSIndexPath*) indexPath;
- (UITableViewCell*) createCellForVideosSectionAtIndexPath:(NSIndexPath*) indexPath;
- (UITableViewCell*) createDeleteCell;

- (id<Measurable>) newMeasurableInstance;
- (NSString*) titleForNewScreen;

- (void) deleteMeasurable;
- (void) installMediaPickerSupport;

- (void) editTags;

@end
