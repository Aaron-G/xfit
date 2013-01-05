//
//  ExerciseInfoEditViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/25/12.
//
//

#import "ExerciseInfoEditViewController.h"
#import "ExerciseKind.h"
#import "ExerciseMetadataProvider.h"
#import "UIHelper.h"
#import "MediaHelper.h"
#import "MeasurableHelper.h"
#import "ExerciseKindEditViewController.h"
#import "MeasurableValueGoalEditViewController.h"
#import "MeasurableUnitEditViewController.h"
#import "ExerciseMoreInfoEditViewController.h"
#import "ExerciseMoreInfo.h"
#import "Exercise.h"

@interface ExerciseInfoEditViewController () <ExerciseKindEditViewControllerDelegate, MeasurableValueGoalEditViewControllerDelegate, MeasurableUnitEditViewControllerDelegate, ExerciseMoreInfoEditViewControllerDelegate>

@end

@implementation ExerciseInfoEditViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  
  self = [super initWithCoder:aDecoder];
  if(self) {
    self.imagesSection = 2;
    self.videosSection = 3;
  }
  
  return self;
}

- (void)viewDidLoad {

  [super viewDidLoad];
  
  self.tableView.editing = YES;

  //Enable MediaPickerSupport
  [self installMediaPickerSupport];  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
  NSInteger numberOfSections = 6;
  
  if (self.measurable.metadataProvider.source == MeasurableSourceUser && self.mode == MeasurableInfoEditViewControllerModeEdit) {
    numberOfSections++;
  }
  
  return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  if(section == 0) {
    return 2;
  } else if(section == 1) {
    return 4;
  } else if(section == self.imagesSection) {
    return 1 + self.measurable.metadataProvider.images.count;
  } else if(section == self.videosSection) {
    return 1 + self.measurable.metadataProvider.videos.count;
  } else if(section == 4) {
    return 2;
  } else if(section == 5) {
    return 1;
  } else if(section == 6) {
    return 1;
  } else {
    return 0;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell* cell = nil;
  
  if(indexPath.section == 0) {
    
    if(indexPath.item == 0) {
      cell = [self createNameCell];
    } else if(indexPath.item == 1) {
      cell = [self createDescriptionCell];
    }
  } else if(indexPath.section == 1) {

    if(indexPath.item == 0) {
      cell = [self createUnitCell];
    } else if(indexPath.item == 1) {
      cell = [self createKindCell];
    } else if(indexPath.item == 2) {
      cell = [self createGoalCell];
    } else if(indexPath.item == 3) {
      cell = [self createTagsCell];
    }
  } else if(indexPath.section == self.imagesSection) {
    cell = [self createCellForImagesSectionAtIndexPath:indexPath];
  } else if(indexPath.section == self.videosSection) {
    cell = [self createCellForVideosSectionAtIndexPath:indexPath];
  } else if(indexPath.section == 4) {
    
    if(indexPath.item == 0) {
      cell = [self createFavoriteCell];
    } else if(indexPath.item == 1) {
      cell = [self createPRWallCell];
    }
  } else if(indexPath.section == 5) {
    
    if(indexPath.item == 0) {
      cell = [self createMoreInfoCell];
    }
  } else if(indexPath.section == 6) {
    
    if(indexPath.item == 0) {
      cell = [self createDeleteCell];
    }
  }
  
  return cell;
}

- (UITableViewCell*) createKindCell {
  
  TableViewCellSubtitle* cell = [self.tableView dequeueReusableCellWithIdentifier:@"TableViewCellSubtitle"];
  
  cell.textLabel.text = NSLocalizedString(@"exercise-edit-kind-label", @"What kind");
  cell.detailTextLabel.text = ((ExerciseMetadataProvider*)self.measurable.metadataProvider).kind.name;
  
  return cell;
}

- (UITableViewCell*) createGoalCell {
  
  TableViewCellSubtitle* cell = [self.tableView dequeueReusableCellWithIdentifier:@"TableViewCellSubtitle"];
  cell.textLabel.text = NSLocalizedString(@"goal-label", @"Goal");
  
  NSString* goalLabel = nil;

  if(MeasurableValueGoalLess == self.measurable.metadataProvider.valueGoal) {
    goalLabel = NSLocalizedString(@"goal-less-label", @"less");
  } else if(MeasurableValueGoalMore == self.measurable.metadataProvider.valueGoal) {
    goalLabel = NSLocalizedString(@"goal-more-label", @"more");
  } else if(MeasurableValueGoalNone == self.measurable.metadataProvider.valueGoal) {
    goalLabel = @"";
  }
  
  cell.detailTextLabel.text = goalLabel;
  
  return cell;
}

- (UITableViewCell*) createUnitCell {
  UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"TableViewCellSubtitle"];
  cell.textLabel.text = NSLocalizedString(@"unit-edit-title", @"How to track");
  cell.detailTextLabel.text = [UIHelper generalNameForUnitType:self.measurable.metadataProvider.unit.type];
  return cell;
}

- (UITableViewCell*) createMoreInfoCell {
  TableViewCellSubtitle*  cell = [self.tableView dequeueReusableCellWithIdentifier:@"TableViewCellSubtitle"];
  cell.textLabel.text = NSLocalizedString(@"exercise-edit-more-info-label", @"More Info");
  
  cell.detailTextLabel.text = [UIHelper stringForExerciseMoreInfos:self.measurable.metadataProvider.moreInfo withSeparator: NSLocalizedString(@"value-separator", @", ")];
  
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [super tableView:tableView didSelectRowAtIndexPath:indexPath];
  
  if(indexPath.section == 1) {
    if(indexPath.item == 0) {
      MeasurableUnitEditViewController* measurableUnitEditViewController =
      (MeasurableUnitEditViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier: @"MeasurableUnitEditViewController"];
      measurableUnitEditViewController.delegate = self;
      [measurableUnitEditViewController editUnit:self.measurable.metadataProvider.unit];
    } else if(indexPath.item == 1) {
      ExerciseKindEditViewController* exerciseKindEditViewController =
        (ExerciseKindEditViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier: @"ExerciseKindEditViewController"];
      exerciseKindEditViewController.delegate = self;
      [exerciseKindEditViewController editExerciseKind:((ExerciseMetadataProvider*)self.measurable.metadataProvider).kind];
    } else if(indexPath.item == 2) {
      MeasurableValueGoalEditViewController* measurableValueGoalEditViewController =
      (MeasurableValueGoalEditViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier: @"MeasurableValueGoalEditViewController"];
      measurableValueGoalEditViewController.delegate = self;
      [measurableValueGoalEditViewController editMeasurableValueGoal:self.measurable.metadataProvider.valueGoal];
    } else if(indexPath.item == 3) {
      [self editTags];
    }
  } else if(indexPath.section == 5) {
      if(indexPath.item == 0) {
        ExerciseMoreInfoEditViewController* exerciseMoreInfoEditViewController =
        (ExerciseMoreInfoEditViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier: @"ExerciseMoreInfoEditViewController"];
        exerciseMoreInfoEditViewController.delegate = self;
        [exerciseMoreInfoEditViewController editExerciseMoreInfo:self.measurable.metadataProvider.moreInfo];
      }
  } else if(indexPath.section == 6) {
    if(indexPath.item == 0) {
      [self deleteMeasurable];
    }
  } else {
    [self.mediaPickerSupport startPickingMediaAtIndexPath:indexPath];
  }
}

///////////////////////////////////////////////////////////////////
//New Exercise
///////////////////////////////////////////////////////////////////

- (id<Measurable>)newMeasurableInstance {
  return [Exercise new];
}

///////////////////////////////////////////////

- (void)didChangeUnit:(Unit *)unit {
  
  //Update the model
  self.measurable.metadataProvider.unit = unit;
  
  //Update the UI
  [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:1]]  withRowAnimation:NO];

  //Let the delegate know the measurable was edited
  [self.delegate didEditMeasurableInfoForMeasurable:self.measurable];
}

- (void)didChangeExerciseKind:(ExerciseKind *)exerciseKind {
  
  //Update the model
  ((ExerciseMetadataProvider*)self.measurable.metadataProvider).kind = exerciseKind;
  
  //Update the UI
  [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:1 inSection:1]]  withRowAnimation:NO];
  
  //Let the delegate know the measurable was edited
  [self.delegate didEditMeasurableInfoForMeasurable:self.measurable];
}

- (void)didChangeMeasurableValueGoal:(MeasurableValueGoal)measurableValueGoal {
  
  //Update the model
  self.measurable.metadataProvider.valueGoal = measurableValueGoal;
  
  //Update the UI
  [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:2 inSection:1]]  withRowAnimation:NO];
  
  //Let the delegate know the measurable was edited
  [self.delegate didEditMeasurableInfoForMeasurable:self.measurable];
}

- (void)didChangeTags:(NSArray *)tags {
  
  //Update the model
  [super didChangeTags:tags];
  
  //Update the UI
  [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:3 inSection:1]]  withRowAnimation:NO];
  
  //Let the delegate know the measurable was edited
  [self.delegate didEditMeasurableInfoForMeasurable:self.measurable];
}

- (void)didChangeExerciseMoreInfo:(NSDictionary *)moreInfo {
  
  //Update the model
  self.measurable.metadataProvider.moreInfo = moreInfo;
  
  //Update the UI
  [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:5]]  withRowAnimation:NO];
  
  //Let the delegate know the measurable was edited
  [self.delegate didEditMeasurableInfoForMeasurable:self.measurable];
}


@end
