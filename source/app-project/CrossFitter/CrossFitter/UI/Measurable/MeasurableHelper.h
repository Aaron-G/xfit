//
//  MeasurableHelper.h
//  CrossFitter
//
//  Created by Cleo Barretto on 10/7/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"
#import "MeasurableViewUpdateDelegate.h"
#import "MeasurableDataEntryViewController.h"
#import "MediaHelper.h"
#import "MeasurableInfoEditViewController.h"

@interface MeasurableHelper : NSObject

+ (UITableViewCell *)tableViewCellForMeasurable: (id <Measurable>) measurable inTableView: (UITableView *)tableView;

+ (UITableViewCell *)tableViewCellForMeasurableDataEntry: (MeasurableDataEntry*) measurableDataEntry ofMeasurable: (id <Measurable>) measurable inTableView: (UITableView *)tableView;

+ (id<MeasurableViewUpdateDelegate>) measurableInfoViewUpdateDelegateForMeasurable: (id<Measurable>) measurable;
+ (id<MeasurableViewUpdateDelegate>) measurableLogViewUpdateDelegateForMeasurable: (id<Measurable>) measurable;

+ (MeasurableDataEntryViewController*) measurableDataEntryViewController;

+ (NSDateFormatter *)measurableDateFormat;

+ (MeasurableDataEntry*) createMeasurableDataEntryForMeasurable:(id<Measurable>) measurable;

+ (MediaHelperPurpose) mediaHelperPurposeForMeasurable:(id<Measurable>)measurable;

+ (MeasurableInfoEditViewController*) measurableInfoEditViewControllerForMeasurable:(id<Measurable>)measurable;

+ (id<MeasurableViewUpdateDelegate>) measurableInfoEditViewUpdateDelegateForMeasurable: (id<Measurable>) measurable;

@end
