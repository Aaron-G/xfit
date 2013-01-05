//
//  MeasurableHelper.h
//  PR Wall
//
//  Created by Cleo Barretto on 10/7/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"
#import "MeasurableViewLayoutDelegate.h"
#import "MeasurableDataEntryViewController.h"
#import "MediaHelper.h"
#import "MeasurableInfoEditViewController.h"
#import "MeasurableChartViewController.h"
#import "MeasurablePickerContainerViewController.h"

typedef enum {
  MeasurableSortCriterionName,
  MeasurableSortCriterionDate
} MeasurableSortCriterion;

@interface MeasurableHelper : NSObject

+ (UITableViewCell *)tableViewCellForMeasurable: (id <Measurable>) measurable inTableView: (UITableView *)tableView;

+ (UITableViewCell *)tableViewCellForMeasurableDataEntry: (MeasurableDataEntry*) measurableDataEntry ofMeasurable: (id <Measurable>) measurable inTableView: (UITableView *)tableView;

+ (id<MeasurableViewLayoutDelegate>) measurableInfoViewLayoutDelegateForMeasurable: (id<Measurable>) measurable;
+ (id<MeasurableViewLayoutDelegate>) measurableLogViewLayoutDelegateForMeasurable: (id<Measurable>) measurable;

+ (MeasurableDataEntryViewController*) measurableDataEntryViewController;

+ (NSDateFormatter *)measurableDateFormat;

+ (MeasurableDataEntry*) createMeasurableDataEntryForMeasurable:(id<Measurable>) measurable;

+ (MediaHelperPurpose) mediaHelperPurposeForMeasurable:(id<Measurable>)measurable;

+ (MeasurableInfoEditViewController*) measurableInfoEditViewControllerForMeasurable:(id<Measurable>)measurable;
+ (MeasurableInfoEditViewController*) measurableInfoEditViewControllerForMeasurableTypeIdentifier:(MeasurableTypeIdentifier)typeIdentifier;

+ (id<MeasurableViewLayoutDelegate>) measurableInfoEditViewLayoutDelegateForMeasurable: (id<Measurable>) measurable;

+ (MeasurableChartViewController*) measurableChartViewController;

+ (NSInteger) indexOfMeasurableWithMeasurableIndetifier:(MeasurableIdentifier) identifier inMeasurableArray:(NSArray*) measurableArray;

+ (UITableViewCell*) tableViewCellForMeasurableValueGoalInTableView: (UITableView *)tableView;
+ (UITableViewCell*) tableViewCellForMassUnitInTableView: (UITableView *)tableView;
+ (UITableViewCell*) tableViewCellForLengthUnitInTableView: (UITableView *)tableView;

+ (NSInteger) segmentedControlIndexForMeasurableValueGoal:(MeasurableValueGoal) measurableValueGoal;
+ (NSInteger) segmentedControlIndexForLengthUnit:(Unit*) unit;
+ (NSInteger) segmentedControlIndexForMassUnit:(Unit*) unit;

+ (UnitIdentifier) lengthUnitForSegmentedControlIndex:(NSInteger) index;
+ (MeasurableValueGoal) measurableValueGoalForSegmentedControlIndex:(NSInteger) index;
+ (UnitIdentifier) massUnitForSegmentedControlIndex:(NSInteger) index;

+ (void) configureSegmentedControlForLengthUnit: (UISegmentedControl *)segmentedControl;
+ (void) configureSegmentedControlForMassUnit: (UISegmentedControl *)segmentedControl;

+ (void) updateDataStructureForNewMeasurable:(id<Measurable>) measurable;

+ (NSArray*) measurablesWithData:(NSArray*) measurables;

+ (MeasurablePickerContainerViewController*) measurablePickerContainerViewController;

+ (NSInteger) indexForMeasurableDataEntry:(MeasurableDataEntry*)measurableDataEntry inMeasurable:(id<Measurable>)measurable;

+ (NSArray*) sortMeasurables:(NSArray*) measurables byMeasurableSortCriterion:(MeasurableSortCriterion) sortCriterion;

@end
