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

+ (id<MeasurableViewLayoutDelegate>) measurableInfoEditViewLayoutDelegateForMeasurable: (id<Measurable>) measurable;

+ (MeasurableChartViewController*) measurableChartViewController;

@end
