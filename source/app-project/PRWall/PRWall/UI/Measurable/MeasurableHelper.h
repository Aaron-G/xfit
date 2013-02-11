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

+ (UITableViewCell *)tableViewCellForMeasurable: (Measurable*) measurable inTableView: (UITableView *)tableView;

+ (UITableViewCell *)tableViewCellForMeasurableDataEntry: (MeasurableDataEntry*) measurableDataEntry ofMeasurable: (Measurable*) measurable inTableView: (UITableView *)tableView;

+ (id<MeasurableViewLayoutDelegate>) measurableInfoViewLayoutDelegateForMeasurable: (Measurable*) measurable;
+ (id<MeasurableViewLayoutDelegate>) measurableLogViewLayoutDelegateForMeasurable: (Measurable*) measurable;

+ (MeasurableDataEntryViewController*) measurableDataEntryViewController;

+ (NSDateFormatter *)measurableDateFormat;

+ (MeasurableDataEntry*) createMeasurableDataEntryForMeasurable:(Measurable*) measurable;

+ (MediaHelperPurpose) mediaHelperPurposeForMeasurable:(Measurable*)measurable;

+ (MeasurableInfoEditViewController*) measurableInfoEditViewControllerForMeasurable:(Measurable*)measurable;
+ (MeasurableInfoEditViewController*) measurableInfoEditViewControllerForMeasurableCategoryIdentifier:(MeasurableCategoryIdentifier)categoryIdentifier;

+ (id<MeasurableViewLayoutDelegate>) measurableInfoEditViewLayoutDelegateForMeasurable: (Measurable*) measurable;

+ (MeasurableChartViewController*) measurableChartViewController;

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

+ (BOOL)updateDataStructureForNewMeasurable:(Measurable*)measurable;

+ (NSArray*) measurablesWithData:(NSArray*) measurables;

+ (MeasurablePickerContainerViewController*) measurablePickerContainerViewController;

//+ (NSInteger) indexForMeasurableDataEntry:(MeasurableDataEntry*)measurableDataEntry inMeasurable:(Measurable*)measurable;

+ (NSArray*) sortMeasurables:(NSArray*) measurables byMeasurableSortCriterion:(MeasurableSortCriterion) sortCriterion;

+ (NSArray*) arrayUnsorted:(NSSet*) set;

+ (NSArray*) arraySortedByIndex:(NSSet*) set;

+ (NSArray*) arraySortedByDate:(NSSet*) set ascending:(BOOL)ascending;

+ (NSArray*) arraySortedByText:(NSSet*) set ascending:(BOOL)ascending;

+ (NSArray*) arraySortedByName:(NSSet*) set ascending:(BOOL)ascending;

+ (NSString *) tagsStringForMeasurableMetadata:(MeasurableMetadata*) measurableMetadata;

@end
