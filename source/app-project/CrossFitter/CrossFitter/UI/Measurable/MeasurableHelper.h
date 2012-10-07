//
//  MeasurableHelper.h
//  CrossFitter
//
//  Created by Cleo Barretto on 10/7/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"

@interface MeasurableHelper : NSObject


+ (UITableViewCell *)tableViewCellForMeasurable: (id <Measurable>) measurable inTableView: (UITableView *)tableView;

@end
