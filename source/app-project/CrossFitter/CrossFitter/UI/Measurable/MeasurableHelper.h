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

@interface MeasurableHelper : NSObject

+ (UITableViewCell *)tableViewCellForMeasurable: (id <Measurable>) measurable inTableView: (UITableView *)tableView;

+ (UITableViewCell *)tableViewCellForMeasurableDataEntry: (MeasurableDataEntry*) measurableDataEntry ofMeasurable: (id <Measurable>) measurable inTableView: (UITableView *)tableView;

+ (UITableViewCell *)tableViewCellWithAdditionalInfoForMeasurableDataEntry: (MeasurableDataEntry*) measurableDataEntry ofMeasurable: (id <Measurable>) measurable inTableView: (UITableView *)tableView;

+ (id<MeasurableViewUpdateDelegate>) measurableInfoViewUpdateDelegateForMeasurable: (id<Measurable>) measurable;
+ (id<MeasurableViewUpdateDelegate>) measurableLogViewUpdateDelegateForMeasurable: (id<Measurable>) measurable;

@end
