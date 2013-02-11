//
//  ExerciseInfoEditViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/25/12.
//
//

#import "ExerciseInfoEditViewController.h"
#import "ExerciseMetadata.h"
#import "UIHelper.h"
#import "MediaHelper.h"
#import "MeasurableHelper.h"
#import "MeasurableTypeEditViewController.h"
#import "MeasurableValueGoalEditViewController.h"
#import "MeasurableUnitEditViewController.h"
#import "ExerciseUnitValueDescriptorEditViewController.h"
#import "Exercise.h"
#import "ModelHelper.h"

@interface ExerciseInfoEditViewController () <MeasurableTypeEditViewControllerDelegate, MeasurableValueGoalEditViewControllerDelegate, MeasurableUnitEditViewControllerDelegate, ExerciseUnitValueDescriptorEditViewControllerDelegate>

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
  
  if (self.measurable.metadata.source == MeasurableSourceUser && self.mode == MeasurableInfoEditViewControllerModeEdit) {
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
    return 1 + self.measurable.metadata.images.count;
  } else if(section == self.videosSection) {
    return 1 + self.measurable.metadata.videos.count;
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

- (Measurable*)newMeasurableInstance {
  Exercise* exercise = [ModelHelper newExercise];
  //CXB REVISE - get a smarter default or leave it blank and enforce save requirements(type, name, )
  exercise.metadata.type = [MeasurableType measurableTypeWithMeasurableTypeIdentifier: ExerciseTypeIdentifierBall];
  exercise.metadata.source = MeasurableSourceUser;
  
  return exercise;
}

- (UITableViewCell*) createKindCell {
  
  TableViewCellSubtitle* cell = [self.tableView dequeueReusableCellWithIdentifier:@"TableViewCellSubtitle"];
  
  cell.textLabel.text = NSLocalizedString(@"measurable-edit-type-label", @"What kind");
  cell.detailTextLabel.text = self.measurable.metadata.type.name;
  
  return cell;
}

- (UITableViewCell*) createGoalCell {
  
  TableViewCellSubtitle* cell = [self.tableView dequeueReusableCellWithIdentifier:@"TableViewCellSubtitle"];
  cell.textLabel.text = NSLocalizedString(@"goal-label", @"Goal");
  
  NSString* goalLabel = nil;

  if(MeasurableValueGoalLess == self.measurable.metadata.valueGoal) {
    goalLabel = NSLocalizedString(@"goal-less-label", @"less");
  } else if(MeasurableValueGoalMore == self.measurable.metadata.valueGoal) {
    goalLabel = NSLocalizedString(@"goal-more-label", @"more");
  } else if(MeasurableValueGoalNone == self.measurable.metadata.valueGoal) {
    goalLabel = @"";
  }
  
  cell.detailTextLabel.text = goalLabel;
  
  return cell;
}

- (UITableViewCell*) createUnitCell {
  UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"TableViewCellSubtitle"];
  cell.textLabel.text = NSLocalizedString(@"unit-edit-title", @"How to track");
  cell.detailTextLabel.text = [UIHelper generalNameForUnitType:self.measurable.metadata.unit.type];
  return cell;
}

- (UITableViewCell*) createMoreInfoCell {
  TableViewCellSubtitle*  cell = [self.tableView dequeueReusableCellWithIdentifier:@"TableViewCellSubtitle"];
  cell.textLabel.text = NSLocalizedString(@"more-label", @"More");
  cell.detailTextLabel.text = [UIHelper stringForExerciseUnitValueDescriptors:((ExerciseMetadata*)self.measurable.metadata).unitValueDescriptors
                                                                withSeparator: NSLocalizedString(@"value-separator", @", ")];
  
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
      [measurableUnitEditViewController editUnit:self.measurable.metadata.unit];
    } else if(indexPath.item == 1) {
      MeasurableTypeEditViewController* measurableTypeEditViewController =
        (MeasurableTypeEditViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier: @"MeasurableTypeEditViewController"];
      measurableTypeEditViewController.delegate = self;
      [measurableTypeEditViewController editMeasurableType:self.measurable.metadata.type];
    } else if(indexPath.item == 2) {
      MeasurableValueGoalEditViewController* measurableValueGoalEditViewController =
      (MeasurableValueGoalEditViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier: @"MeasurableValueGoalEditViewController"];
      measurableValueGoalEditViewController.delegate = self;
      [measurableValueGoalEditViewController editMeasurableValueGoal:self.measurable.metadata.valueGoal];
    } else if(indexPath.item == 3) {
      [self editTags];
    }
  } else if(indexPath.section == 5) {
      if(indexPath.item == 0) {
        ExerciseUnitValueDescriptorEditViewController* exerciseUnitValueDescriptorEditViewController =
        (ExerciseUnitValueDescriptorEditViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier: @"ExerciseUnitValueDescriptorEditViewController"];
        exerciseUnitValueDescriptorEditViewController.delegate = self;
        [exerciseUnitValueDescriptorEditViewController editExerciseUnitValueDescriptors: ((ExerciseMetadata*)self.measurable.metadata).unitValueDescriptors];
      }
  } else if(indexPath.section == 6) {
    if(indexPath.item == 0) {
      [self deleteMeasurable];
    }
  }
  else {
    
    //This means the user clicked on an Add row.
    //So add the new media as the last entry of the repective media
    NSArray* mediaArray = nil;
    
    if(indexPath.section == self.imagesSection) {
      mediaArray = self.measurable.metadata.images;;
    } else if (indexPath.section == self.videosSection) {
      mediaArray = self.measurable.metadata.videos;
    }
    
    if(!mediaArray) {
      return;
    }
    
    [self.mediaPickerSupport startPickingMediaAtIndexPath: [NSIndexPath indexPathForItem:mediaArray.count inSection:indexPath.section]];
  }
}

- (void)didChangeUnit:(Unit *)unit {
  
  if([self.measurable.metadata.unit isEqual:unit]) {
    return;
  }
  
  //Update the model
  self.measurable.metadata.unit = unit;
  
  [self saveChangesWithMessage: [NSString stringWithFormat:@"MeasurableInfoEditViewController - could not save model changes - trying to change the unit of the %@ metadata", self.measurable.metadata.name]];

  //Update the UI
  [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:1]]  withRowAnimation:NO];

  //Let the delegate know the measurable was edited
  [self.delegate didEditMeasurableInfoForMeasurable:self.measurable];
}

- (void)didChangeMeasurableType:(MeasurableType *)measurableType{
  
  if([self.measurable.metadata.type isEqual:measurableType]) {
    return;
  }

  //Update the model
  self.measurable.metadata.type = measurableType;

  [self saveChangesWithMessage: [NSString stringWithFormat:@"MeasurableInfoEditViewController - could not save model changes - trying to change the type of the %@ metadata", self.measurable.metadata.name]];

  //Update the UI
  [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:1 inSection:1]]  withRowAnimation:NO];
  
  //Let the delegate know the measurable was edited
  [self.delegate didEditMeasurableInfoForMeasurable:self.measurable];
}

- (void)didChangeMeasurableValueGoal:(MeasurableValueGoal)measurableValueGoal {
  
  if(self.measurable.metadata.valueGoal == measurableValueGoal) {
    return;
  }
  
  //Update the model
  self.measurable.metadata.valueGoal = measurableValueGoal;
  
  [self saveChangesWithMessage: [NSString stringWithFormat:@"MeasurableInfoEditViewController - could not save model changes - trying to change the value goal of the %@ metadata", self.measurable.metadata.name]];

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

- (void)didChangeExerciseUnitValueDescriptors:(NSArray *)unitValueDescriptors {
  
  ExerciseMetadata* exerciseMetadata = (ExerciseMetadata*)self.measurable.metadata;
  
  NSArray* existingDescriptors = exerciseMetadata.unitValueDescriptors;
  
  //Remove the descriptors that have been removed by the user
  for (ExerciseUnitValueDescriptor* existingDescriptor in existingDescriptors) {
    if(![unitValueDescriptors containsObject:existingDescriptor]) {
      [exerciseMetadata removeUnitValueDescriptor:existingDescriptor];
    }
  }
  
  //Add the descriptors that have been added by the user
  for (ExerciseUnitValueDescriptor* newDescriptor in unitValueDescriptors) {
    if(![existingDescriptors containsObject:newDescriptor]) {
      [exerciseMetadata addUnitValueDescriptor:newDescriptor];
    }
  }
  
  [self saveChangesWithMessage: [NSString stringWithFormat:@"MeasurableInfoEditViewController - could not save model changes - trying to change the unit value descriptors of the %@ metadata", self.measurable.metadata.name]];

  //Update the UI
  [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:5]]  withRowAnimation:NO];
  
  //Let the delegate know the measurable was edited
  [self.delegate didEditMeasurableInfoForMeasurable:self.measurable];
}

@end
