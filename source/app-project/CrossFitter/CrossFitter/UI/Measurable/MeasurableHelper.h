//
//  MeasurableHelper.h
//  CrossFitter
//
//  Created by Cleo Barretto on 10/7/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"
#import "MeasurableInfoUpdateDelegate.h"

@interface MeasurableHelper : NSObject

+ (UITableViewCell *)tableViewCellForMeasurable: (id <Measurable>) measurable inTableView: (UITableView *)tableView;

+ (UITableViewCell *)tableViewCellForMeasurableDataEntry: (MeasurableDataEntry*) measurableDataEntry ofMeasurable: (id <Measurable>) measurable inTableView: (UITableView *)tableView;

+ (id<MeasurableInfoUpdateDelegate>) measurableInfoUpdateDelegateForMeasurable: (id<Measurable>) measurable;

@end
