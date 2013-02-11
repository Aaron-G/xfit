//
//  MeasurableHelper.m
//  PR Wall
//
//  Created by Cleo Barretto on 10/7/12.
//
//

#import "MeasurableHelper.h"
#import "MeasurableTableViewCell.h"
#import "UIHelper.h"
#import "MeasurableDataEntryTableViewCell.h"
#import "MeasurableType.h"
#import "BodyMetricInfoLayoutDelegate.h"
#import "ExerciseInfoLayoutDelegate.h"
#import "MeasurableDataEntryAdditionalInfoTableViewCell.h"
#import "MeasurableViewLayoutDelegate.h"
#import "MeasurableLogLayoutDelegateBase.h"
#import "BodyMetricInfoEditViewController.h"
#import "MeasurableInfoEditLayoutDelegateBase.h"
#import "App.h"
#import "ModelHelper.h"
#import "PersistenceStore.h"
#import "BodyMetric.h"
#import "Workout.h"
#import "Exercise.h"

@interface MeasurableHelper () {
}

@end

@implementation MeasurableHelper

static NSDateFormatter* _measurableDateFormat;
static NSMutableDictionary* _measurableInfoViewLayoutDelegates;
static id<MeasurableViewLayoutDelegate> _measurableInfoEditViewLayoutDelegate;
static id<MeasurableViewLayoutDelegate> _measurableLogViewLayoutDelegate;
static MeasurableDataEntryViewController* _measurableDataEntryViewController;
static MeasurableChartViewController* _measurableChartViewController;


+ (UITableViewCell *)tableViewCellForMeasurable: (Measurable*) measurable inTableView: (UITableView *)tableView {

  MeasurableTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurableTableViewCell"];
  
  BOOL hasValue = (measurable.data.value != nil);
  
  cell.measurableNameLabel.text = measurable.metadata.name;
  cell.measurableMetadataLabel.text = measurable.metadata.metadataShort;

  [UIHelper adjustImage:cell.measurableTrendImageButton forMeasurable:measurable];
  
  if(hasValue) {
    cell.measurableValueLabel.text = [measurable.metadata.unit.valueFormatter formatValue:measurable.data.value];

    NSString *dateString = [MeasurableHelper.measurableDateFormat stringFromDate:measurable.data.date];
    cell.measurableDateLabel.text = dateString;
  } else {
    cell.measurableValueLabel.text = nil;
    cell.measurableDateLabel.text = nil;
  }
  
  return cell;
}

+ (UITableViewCell *)tableViewCellForMeasurableDataEntry: (MeasurableDataEntry*) measurableDataEntry ofMeasurable: (Measurable*) measurable inTableView: (UITableView *)tableView {
  
  MeasurableDataEntryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurableDataEntryTableViewCell"];
  cell.measurableDataEntry = measurableDataEntry;
  cell.measurableValueLabel.text = [measurable.metadata.unit.valueFormatter formatValue:measurableDataEntry.value];
  
  NSString *dateString = [MeasurableHelper.measurableDateFormat stringFromDate:measurableDataEntry.date];
  cell.measurableDateLabel.text = dateString;
  
  //Adjust the trend image to tailor to the metric specifics
  [UIHelper adjustImage:cell.measurableTrendImageButton
withMeasurableValueTrend: measurableDataEntry.valueTrend
withMeasurableValueGoal: measurable.metadata.valueGoal];

  //Show or Hide the Info button/icon
  cell.measurableAdditionalInfoImageButton.hidden = (!measurableDataEntry.hasAdditionalInfo);
  
  return cell;
}

+ (UITableViewCell*) tableViewCellForMeasurableValueGoalInTableView: (UITableView *)tableView {
  
  MeasurableValueGoalTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurableValueGoalTableViewCell"];
  
  [cell.measurableValueGoalSegmentedControl setTitle:NSLocalizedString(@"goal-more-label", @"more") forSegmentAtIndex:0];
  [cell.measurableValueGoalSegmentedControl setTitle:NSLocalizedString(@"goal-less-label", @"less") forSegmentAtIndex:1];
  [cell.measurableValueGoalSegmentedControl setTitle:NSLocalizedString(@"goal-none-label", @"don't track") forSegmentAtIndex:2];
  
  [UIHelper applyFontToSegmentedControl:cell.measurableValueGoalSegmentedControl];

  return cell;
}

+ (UITableViewCell*) tableViewCellForMassUnitInTableView: (UITableView *)tableView {
  
  MassUnitTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MassUnitTableViewCell"];
  
  [MeasurableHelper configureSegmentedControlForMassUnit:cell.massUnitSegmentedControl];
  
  return cell;
}

+ (void) configureSegmentedControlForMassUnit: (UISegmentedControl *)segmentedControl {
  
  [segmentedControl setTitle:NSLocalizedString(@"kilogram-suffix", @"kg") forSegmentAtIndex:0];
  [segmentedControl setTitle:NSLocalizedString(@"pound-suffix", @"lb") forSegmentAtIndex:1];
  [segmentedControl setTitle:NSLocalizedString(@"pood-suffix", @"pu") forSegmentAtIndex:2];
  
  [UIHelper applyFontToSegmentedControl:segmentedControl];
}

+ (UITableViewCell*) tableViewCellForLengthUnitInTableView: (UITableView *)tableView {
  
  LengthUnitTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"LengthUnitTableViewCell"];
  
  [MeasurableHelper configureSegmentedControlForLengthUnit:cell.lengthUnitSegmentedControl];
  
  return cell;
}

+ (void) configureSegmentedControlForLengthUnit: (UISegmentedControl *)segmentedControl {
  
  [segmentedControl setTitle:NSLocalizedString(@"meter-suffix", @"m") forSegmentAtIndex:0];
  [segmentedControl setTitle:NSLocalizedString(@"kilometer-suffix", @"km") forSegmentAtIndex:1];
  [segmentedControl setTitle:NSLocalizedString(@"inch-suffix-word", @"in") forSegmentAtIndex:2];
  [segmentedControl setTitle:NSLocalizedString(@"foot-suffix-word", @"ft") forSegmentAtIndex:3];
  [segmentedControl setTitle:NSLocalizedString(@"yard-suffix", @"yd") forSegmentAtIndex:4];
  [segmentedControl setTitle:NSLocalizedString(@"mile-suffix", @"mi") forSegmentAtIndex:5];
  
  [UIHelper applyFontToSegmentedControl:segmentedControl];
}

+ (NSDateFormatter *)measurableDateFormat {
  if(!_measurableDateFormat) {
    _measurableDateFormat = [[NSDateFormatter alloc] init];
    _measurableDateFormat.dateFormat = NSLocalizedString(@"measurable-date-format", @"MM/dd/yy ");
  }
  return _measurableDateFormat;
}

+ (NSMutableDictionary*) measurableInfoLayoutDelegates {
  if(!_measurableInfoViewLayoutDelegates) {
    _measurableInfoViewLayoutDelegates = [NSMutableDictionary dictionary];
  }
  return _measurableInfoViewLayoutDelegates;
}

+ (id<MeasurableViewLayoutDelegate>) measurableInfoViewLayoutDelegateForMeasurable: (Measurable*) measurable {
  
  MeasurableCategory* measurableCategory = measurable.metadata.category;
  
  id<MeasurableViewLayoutDelegate> measurableInfoLayoutDelegate = [[MeasurableHelper measurableInfoLayoutDelegates] objectForKey: measurableCategory.name];
  
  if(!measurableInfoLayoutDelegate) {
    
    if([measurableCategory.identifier isEqualToString: MeasurableCategoryIdentifierBodyMetric]) {
      measurableInfoLayoutDelegate  = [[BodyMetricInfoLayoutDelegate alloc] init];
    } else if([measurableCategory.identifier isEqualToString: MeasurableCategoryIdentifierExercise]) {
      measurableInfoLayoutDelegate  = [[ExerciseInfoLayoutDelegate alloc] init];
    }
    
    [[MeasurableHelper measurableInfoLayoutDelegates] setObject:measurableInfoLayoutDelegate forKey: measurableCategory.name];
  }
  
  return measurableInfoLayoutDelegate;  
}

+ (id<MeasurableViewLayoutDelegate>) measurableInfoEditViewLayoutDelegate {
  if(!_measurableInfoEditViewLayoutDelegate) {
    _measurableInfoEditViewLayoutDelegate = [[MeasurableInfoEditLayoutDelegateBase alloc] init];

  }
  return _measurableInfoEditViewLayoutDelegate;
}

+ (id<MeasurableViewLayoutDelegate>) measurableInfoEditViewLayoutDelegateForMeasurable: (Measurable*) measurable {
  //They all use the same logic - for now
  return [MeasurableHelper measurableInfoEditViewLayoutDelegate];
}

+ (id<MeasurableViewLayoutDelegate>) measurableLogViewLayoutDelegate {
  if(!_measurableLogViewLayoutDelegate) {
    _measurableLogViewLayoutDelegate = [[MeasurableLogLayoutDelegateBase alloc] init];
  }
  return _measurableLogViewLayoutDelegate;
}

+ (id<MeasurableViewLayoutDelegate>) measurableLogViewLayoutDelegateForMeasurable: (Measurable*) measurable {
  //They all use the same logic - for now
  return [MeasurableHelper measurableLogViewLayoutDelegate];
}

+ (MeasurableDataEntryViewController*) measurableDataEntryViewController {
  if(!_measurableDataEntryViewController) {
    _measurableDataEntryViewController = (MeasurableDataEntryViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier:@"MeasurableDataEntryViewController"];
  }
  return _measurableDataEntryViewController;
}

+ (MeasurableDataEntry*) createMeasurableDataEntryForMeasurable:(Measurable*) measurable {

  MeasurableDataEntry* measurableDataEntry = [ModelHelper newMeasurableDataEntry];
  
  measurableDataEntry.date = [NSDate date];
  
  //Default to the very latest value logged
  NSNumber* defaultValue = measurable.data.value;
  
  //If not available use the sample value from the metadata object
  if(!defaultValue) {
    defaultValue = measurable.metadata.valueSample;
  }
  measurableDataEntry.value = defaultValue;
  
  return measurableDataEntry;
}

+ (MediaHelperPurpose) mediaHelperPurposeForMeasurable:(Measurable*)measurable {
  
  MeasurableCategoryIdentifier categoryIdentifier = measurable.metadata.category.identifier;
  
  if([categoryIdentifier isEqualToString: MeasurableCategoryIdentifierBodyMetric]) {
    return MediaHelperPurposeBodyMetric;
  } else if([categoryIdentifier isEqualToString: MeasurableCategoryIdentifierExercise]) {
    return MediaHelperPurposeExercise;
  } else if([categoryIdentifier isEqualToString: MeasurableCategoryIdentifierWorkout]) {
    return MediaHelperPurposeWorkout;
  } else if([categoryIdentifier isEqualToString: MeasurableCategoryIdentifierWOD]) {
    return MediaHelperPurposeWOD;
  }
  return -1;
}

+ (MeasurableInfoEditViewController*) measurableInfoEditViewControllerForMeasurable:(Measurable*)measurable {

  MeasurableCategoryIdentifier categoryIdentifier = measurable.metadata.category.identifier;
  
  MeasurableInfoEditViewController* measurableInfoEditViewController =
  [MeasurableHelper measurableInfoEditViewControllerForMeasurableCategoryIdentifier:categoryIdentifier];
  
  measurableInfoEditViewController.measurable = measurable;

  return measurableInfoEditViewController;
}

+ (MeasurableInfoEditViewController*) measurableInfoEditViewControllerForMeasurableCategoryIdentifier:(MeasurableCategoryIdentifier)categoryIdentifier {
  
  NSString* viewControllerName = nil;
  
  if([categoryIdentifier isEqualToString: MeasurableCategoryIdentifierBodyMetric]) {
    viewControllerName = @"BodyMetricInfoEditViewController";
  } else if([categoryIdentifier isEqualToString: MeasurableCategoryIdentifierExercise]) {
    viewControllerName = @"ExerciseInfoEditViewController";
  } else if([categoryIdentifier isEqualToString: MeasurableCategoryIdentifierWorkout]) {
    
  } else if([categoryIdentifier isEqualToString: MeasurableCategoryIdentifierWOD]) {
    
  }
  
  MeasurableInfoEditViewController* measurableInfoEditViewController = nil;
  
  if(viewControllerName) {
    measurableInfoEditViewController = (MeasurableInfoEditViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier:viewControllerName];
  }
  
  return measurableInfoEditViewController;
}


+ (MeasurableChartViewController*) measurableChartViewController {
  if(!_measurableChartViewController) {
    _measurableChartViewController = (MeasurableChartViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier:@"MeasurableChartViewController"];
  }
  return _measurableChartViewController;
}

+ (MeasurablePickerContainerViewController*) measurablePickerContainerViewController {
  return (MeasurablePickerContainerViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier:@"MeasurablePickerContainerViewController"];
}

+ (NSInteger) segmentedControlIndexForMeasurableValueGoal:(MeasurableValueGoal) measurableValueGoal {
  
  NSInteger index = -1;
  
  if(measurableValueGoal == MeasurableValueGoalMore) {
    index = 0;
  } else if(measurableValueGoal == MeasurableValueGoalLess) {
    index = 1;
  } else if(measurableValueGoal == MeasurableValueGoalNone) {
    index = 2;
  }
  
  assert(index != -1);
  return index;
}

+ (NSInteger) segmentedControlIndexForLengthUnit:(Unit*) unit {
  
  NSInteger index = -1;
  
  if([unit.identifier isEqualToString: UnitIdentifierMeter]) {
    index = 0;
  } else if([unit.identifier isEqualToString: UnitIdentifierKilometer]) {
    index = 1;
  } else if([unit.identifier isEqualToString: UnitIdentifierInch]) {
    index = 2;
  } else if([unit.identifier isEqualToString: UnitIdentifierFoot]) {
    index = 3;
  } else if([unit.identifier isEqualToString: UnitIdentifierYard]) {
    index = 4;
  } else if([unit.identifier isEqualToString: UnitIdentifierMile]) {
    index = 5;
  }
  
  assert(index != -1);
  return index;
}

+ (UnitIdentifier) lengthUnitForSegmentedControlIndex:(NSInteger) index {
  
  UnitIdentifier unitIdentifier = nil;
  
  if(index == 0) {
    unitIdentifier = UnitIdentifierMeter;
  } else if(index == 1) {
    unitIdentifier = UnitIdentifierKilometer;
  } else if(index == 2) {
    unitIdentifier = UnitIdentifierInch;
  } else if(index == 3) {
    unitIdentifier = UnitIdentifierFoot;
  } else if(index == 4) {
    unitIdentifier = UnitIdentifierYard;
  } else if(index == 5) {
    unitIdentifier = UnitIdentifierMile;
  }
  
  assert(unitIdentifier != nil);
  return unitIdentifier;
}

+ (NSInteger) segmentedControlIndexForMassUnit:(Unit*) unit {
  
  NSInteger index = -1;
  
  if([unit.identifier isEqualToString: UnitIdentifierKilogram]) {
    index = 0;
  } else if([unit.identifier isEqualToString: UnitIdentifierPound]) {
    index = 1;
  } else if([unit.identifier isEqualToString: UnitIdentifierPood]) {
    index = 2;
  }
  
  assert(index != -1);
  return index;
}

+ (MeasurableValueGoal) measurableValueGoalForSegmentedControlIndex:(NSInteger) index {
  
  MeasurableValueGoal measurableValueGoal = -1;
  
  if(index == 0) {
    measurableValueGoal = MeasurableValueGoalMore;
  } else if(index == 1) {
    measurableValueGoal = MeasurableValueGoalLess;
  } else if(index == 2) {
    measurableValueGoal = MeasurableValueGoalNone;
  }
  
  assert(measurableValueGoal != -1);
  return measurableValueGoal;
}

+ (UnitIdentifier) massUnitForSegmentedControlIndex:(NSInteger) index {
  
  UnitIdentifier unitIdentifier = nil;
  
  if(index == 0) {
    unitIdentifier = UnitIdentifierKilogram;
  } else if(index == 1) {
    unitIdentifier = UnitIdentifierPound;
  } else if(index == 2) {
    unitIdentifier = UnitIdentifierPood;
  }
  
  assert(unitIdentifier != nil);
  return unitIdentifier;
}

+ (BOOL)updateDataStructureForNewMeasurable:(Measurable*)measurable {

  UserProfile* userProfile = [App sharedInstance].userProfile;
  
  if([measurable.metadata.category.identifier isEqualToString: MeasurableCategoryIdentifierExercise]) {
    measurable.userProfile = userProfile;
  }
  
  return [[PersistenceStore sharedInstance] save];
}

+ (NSArray*) measurablesWithData:(NSArray*) measurables {
  
  //Filter
  return [measurables filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(data.value != NIL)"]];
}

+ (NSArray*) measurablesArray:(NSSet*) measurables {
  
  //No sorting at this level
  return [measurables sortedArrayUsingDescriptors:nil];
}

//+ (NSInteger) indexForMeasurableDataEntry:(MeasurableDataEntry*)measurableDataEntry inMeasurable:(Measurable*)measurable {
//  
//  NSInteger index = 0;
//  
//  for (MeasurableDataEntry* curMeasurableDataEntry in measurable.data.values) {
//    
//    if (measurableDataEntry.date == curMeasurableDataEntry.date) {
//      continue;
//    }
//    
//    if(measurableDataEntry.date == [curMeasurableDataEntry.date laterDate:measurableDataEntry.date]) {
//      break;
//    }
//    
//    index++;
//  }
//  return index;
//}

+ (NSArray*) sortMeasurables:(NSArray*) measurables byMeasurableSortCriterion:(MeasurableSortCriterion) sortCriterion {
  
  NSComparator comparator = nil;
  
  if(MeasurableSortCriterionName == sortCriterion) {
    
    comparator = ^(id obj1, id obj2) {
      return [((Measurable*)obj1).metadata.name compare:((Measurable*)obj2).metadata.name];
    };
    
  } else if(MeasurableSortCriterionDate == sortCriterion) {
    comparator = ^(id obj1, id obj2) {
      return [((Measurable*)obj2).data.date compare:((Measurable*)obj1).data.date];
    };
  }
  
  if(comparator) {
    return [measurables sortedArrayUsingComparator: comparator];
  } else {
    return measurables;
  }
}

+ (NSArray*) arrayUnsorted:(NSSet*) set {
  return [set sortedArrayUsingDescriptors: [NSArray array]];
}

+ (NSArray*) arraySortedByIndex:(NSSet*) set {
  NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
  return [set sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
}

+ (NSArray*) arraySortedByText:(NSSet*) set ascending:(BOOL)ascending {
  NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"text" ascending:ascending];
  return [set sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
}

+ (NSArray*) arraySortedByDate:(NSSet*) set ascending:(BOOL)ascending {
  NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:ascending];
  return [set sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
}

+ (NSArray*) arraySortedByName:(NSSet*) set ascending:(BOOL)ascending {
  NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:ascending];
  return [set sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
}

+ (NSString *) tagsStringForMeasurableMetadata:(MeasurableMetadata*) measurableMetadata {
  
  NSMutableArray* tagsTextArray = [NSMutableArray arrayWithCapacity:measurableMetadata.tags.count];
  
  for (Tag* tag in measurableMetadata.tags) {
    [tagsTextArray addObject:tag.text];
  }
  
  return [tagsTextArray componentsJoinedByString:NSLocalizedString(@"value-separator", @", ")];;
}

@end
