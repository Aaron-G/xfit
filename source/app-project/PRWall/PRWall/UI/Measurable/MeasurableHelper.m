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


+ (UITableViewCell *)tableViewCellForMeasurable: (id <Measurable>) measurable inTableView: (UITableView *)tableView {

  MeasurableTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurableTableViewCell"];
  
  BOOL hasValue = (measurable.dataProvider.value != nil);
  
  cell.measurableNameLabel.text = measurable.metadataProvider.name;
  cell.measurableMetadataLabel.text = measurable.metadataProvider.metadataShort;

  [UIHelper adjustImage:cell.measurableTrendImageButton forMeasurable:measurable];
  
  if(hasValue) {
    cell.measurableValueLabel.text = [measurable.metadataProvider.unit.valueFormatter formatValue:measurable.dataProvider.value];

    NSString *dateString = [MeasurableHelper.measurableDateFormat stringFromDate:measurable.dataProvider.date];
    cell.measurableDateLabel.text = dateString;
  } else {
    cell.measurableValueLabel.text = nil;
    cell.measurableDateLabel.text = nil;
  }
  
  return cell;
}

+ (UITableViewCell *)tableViewCellForMeasurableDataEntry: (MeasurableDataEntry*) measurableDataEntry ofMeasurable: (id <Measurable>) measurable inTableView: (UITableView *)tableView {
  
  MeasurableDataEntryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurableDataEntryTableViewCell"];
  cell.measurableDataEntry = measurableDataEntry;
  cell.measurableValueLabel.text = [measurable.metadataProvider.unit.valueFormatter formatValue:measurableDataEntry.value];
  
  NSString *dateString = [MeasurableHelper.measurableDateFormat stringFromDate:measurableDataEntry.date];
  cell.measurableDateLabel.text = dateString;
  
  //Adjust the trend image to tailor to the metric specifics
  [UIHelper adjustImage:cell.measurableTrendImageButton
withMeasurableValueTrend: measurableDataEntry.valueTrend
withMeasurableValueGoal: measurable.metadataProvider.valueGoal];

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

+ (id<MeasurableViewLayoutDelegate>) measurableInfoViewLayoutDelegateForMeasurable: (id<Measurable>) measurable {
  
  MeasurableType* measurableType = measurable.metadataProvider.type;
  
  id<MeasurableViewLayoutDelegate> measurableInfoLayoutDelegate = [[MeasurableHelper measurableInfoLayoutDelegates] objectForKey: measurableType.displayName];
  
  if(!measurableInfoLayoutDelegate) {
    
    if(measurableType.identifier == MeasurableTypeIdentifierBodyMetric) {
      measurableInfoLayoutDelegate  = [[BodyMetricInfoLayoutDelegate alloc] init];
    } else if(measurableType.identifier == MeasurableTypeIdentifierExercise) {
      measurableInfoLayoutDelegate  = [[ExerciseInfoLayoutDelegate alloc] init];
    }
    
    [[MeasurableHelper measurableInfoLayoutDelegates] setObject:measurableInfoLayoutDelegate forKey: measurableType.displayName];
  }
  
  return measurableInfoLayoutDelegate;  
}

+ (id<MeasurableViewLayoutDelegate>) measurableInfoEditViewLayoutDelegate {
  if(!_measurableInfoEditViewLayoutDelegate) {
    _measurableInfoEditViewLayoutDelegate = [[MeasurableInfoEditLayoutDelegateBase alloc] init];

  }
  return _measurableInfoEditViewLayoutDelegate;
}

+ (id<MeasurableViewLayoutDelegate>) measurableInfoEditViewLayoutDelegateForMeasurable: (id<Measurable>) measurable {
  //They all use the same logic - for now
  return [MeasurableHelper measurableInfoEditViewLayoutDelegate];
}

+ (id<MeasurableViewLayoutDelegate>) measurableLogViewLayoutDelegate {
  if(!_measurableLogViewLayoutDelegate) {
    _measurableLogViewLayoutDelegate = [[MeasurableLogLayoutDelegateBase alloc] init];
  }
  return _measurableLogViewLayoutDelegate;
}

+ (id<MeasurableViewLayoutDelegate>) measurableLogViewLayoutDelegateForMeasurable: (id<Measurable>) measurable {
  //They all use the same logic - for now
  return [MeasurableHelper measurableLogViewLayoutDelegate];
}

+ (MeasurableDataEntryViewController*) measurableDataEntryViewController {
  if(!_measurableDataEntryViewController) {
    _measurableDataEntryViewController = (MeasurableDataEntryViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier:@"MeasurableDataEntryViewController"];
  }
  return _measurableDataEntryViewController;
}

+ (MeasurableDataEntry*) createMeasurableDataEntryForMeasurable:(id<Measurable>) measurable {
  
  MeasurableDataEntry* measurableDataEntry = [[MeasurableDataEntry alloc] init];
  measurableDataEntry.value = measurable.dataProvider.value;
  measurableDataEntry.date = [NSDate date];
  
  return measurableDataEntry;
}

+ (MediaHelperPurpose) mediaHelperPurposeForMeasurable:(id<Measurable>)measurable {
  
  MeasurableTypeIdentifier typeIdentifier = measurable.metadataProvider.type.identifier;
  
  if(MeasurableTypeIdentifierBodyMetric == typeIdentifier) {
    return MediaHelperPurposeBodyMetric;
  } else if(MeasurableTypeIdentifierExercise == typeIdentifier) {
    return MediaHelperPurposeExercise;
  } else if(MeasurableTypeIdentifierWorkout == typeIdentifier) {
    return MediaHelperPurposeWorkout;
  } else if(MeasurableTypeIdentifierWOD == typeIdentifier) {
    return MediaHelperPurposeWOD;
  }
  return -1;
}


+ (MeasurableInfoEditViewController*) measurableInfoEditViewControllerForMeasurable:(id<Measurable>)measurable {

  MeasurableTypeIdentifier typeIdentifier = measurable.metadataProvider.type.identifier;
  
  MeasurableInfoEditViewController* measurableInfoEditViewController =
  [MeasurableHelper measurableInfoEditViewControllerForMeasurableTypeIdentifier:typeIdentifier];
  
  measurableInfoEditViewController.measurable = measurable;

  return measurableInfoEditViewController;
}

+ (MeasurableInfoEditViewController*) measurableInfoEditViewControllerForMeasurableTypeIdentifier:(MeasurableTypeIdentifier)typeIdentifier {
  
  NSString* viewControllerName = nil;
  
  if(MeasurableTypeIdentifierBodyMetric == typeIdentifier) {
    viewControllerName = @"BodyMetricInfoEditViewController";
  } else if(MeasurableTypeIdentifierExercise == typeIdentifier) {
    viewControllerName = @"ExerciseInfoEditViewController";
  } else if(MeasurableTypeIdentifierWorkout == typeIdentifier) {
    
  } else if(MeasurableTypeIdentifierWOD == typeIdentifier) {
    
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

+(NSInteger) indexOfMeasurableWithMeasurableIndetifier:(MeasurableIdentifier) identifier inMeasurableArray:(NSArray*) measurableArray {
  
  return [measurableArray indexOfObjectPassingTest: ^(id element, NSUInteger idx, BOOL * stop) {
    
    *stop = (((id<Measurable>)element).metadataProvider.identifier == identifier);
    
    return *stop;
  }];
  
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
  
  if(unit.identifier == UnitIdentifierMeter) {
    index = 0;
  } else if(unit.identifier == UnitIdentifierKilometer) {
    index = 1;
  } else if(unit.identifier == UnitIdentifierInch) {
    index = 2;
  } else if(unit.identifier == UnitIdentifierFoot) {
    index = 3;
  } else if(unit.identifier == UnitIdentifierYard) {
    index = 4;
  } else if(unit.identifier == UnitIdentifierMile) {
    index = 5;
  }
  
  assert(index != -1);
  return index;
}

+ (UnitIdentifier) lengthUnitForSegmentedControlIndex:(NSInteger) index {
  
  UnitIdentifier unitIdentifier = -1;
  
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
  
  assert(unitIdentifier != -1);
  return unitIdentifier;
}

+ (NSInteger) segmentedControlIndexForMassUnit:(Unit*) unit {
  
  NSInteger index = -1;
  
  if(unit.identifier == UnitIdentifierKilogram) {
    index = 0;
  } else if(unit.identifier == UnitIdentifierPound) {
    index = 1;
  } else if(unit.identifier == UnitIdentifierPood) {
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
  
  UnitIdentifier unitIdentifier = -1;
  
  if(index == 0) {
    unitIdentifier = UnitIdentifierKilogram;
  } else if(index == 1) {
    unitIdentifier = UnitIdentifierPound;
  } else if(index == 2) {
    unitIdentifier = UnitIdentifierPood;
  }
  
  assert(unitIdentifier != -1);
  return unitIdentifier;
}

+ (void)updateDataStructureForNewMeasurable:(id<Measurable>)measurable {

  UserProfile* userProfile = [App sharedInstance].userProfile;
  
  if(measurable.metadataProvider.type.identifier == MeasurableTypeIdentifierExercise) {
    [userProfile.exercises setValue:measurable forKey:measurable.metadataProvider.identifier];
  }
}

+ (NSArray*) measurablesWithData:(NSArray*) measurables; {
  return [measurables filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(dataProvider.value != NIL)"]];
}

+ (NSInteger) indexForMeasurableDataEntry:(MeasurableDataEntry*)measurableDataEntry inMeasurable:(id<Measurable>)measurable {

  NSInteger index = 0;
  
  for (MeasurableDataEntry* curMeasurableDataEntry in measurable.dataProvider.values) {
    
    if (measurableDataEntry.date == curMeasurableDataEntry.date) {
      continue;
    }
    
    if(measurableDataEntry.date == [curMeasurableDataEntry.date laterDate:measurableDataEntry.date]) {
      break;
    }
    
    index++;
  }
  return index;
}

+ (NSArray*) sortMeasurables:(NSArray*) measurables byMeasurableSortCriterion:(MeasurableSortCriterion) sortCriterion {
  
  NSComparator comparator = nil;
  
  if(MeasurableSortCriterionName == sortCriterion) {
    
    comparator = ^(id obj1, id obj2) {
      return [((id<Measurable>)obj1).metadataProvider.name compare:((id<Measurable>)obj2).metadataProvider.name];
    };
    
  } else if(MeasurableSortCriterionDate == sortCriterion) {
    comparator = ^(id obj1, id obj2) {
      return [((id<Measurable>)obj2).dataProvider.date compare:((id<Measurable>)obj1).dataProvider.date];
    };
  }
  
  if(comparator) {
    return [measurables sortedArrayUsingComparator: comparator];
  } else {
    return measurables;
  }
}

@end
