//
//  MeasurableHelper.m
//  CrossFitter
//
//  Created by Cleo Barretto on 10/7/12.
//
//

#import "MeasurableHelper.h"
#import "MeasurableTableViewCell.h"
#import "UIHelper.h"

@interface MeasurableHelper () {
}

@end

@implementation MeasurableHelper

static NSDateFormatter *_measurableDateFormat;

+ (UITableViewCell *)tableViewCellForMeasurable: (id <Measurable>) measurable inTableView: (UITableView *)tableView {

  MeasurableTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurableTableViewCell"];
  
  cell.measurableNameLabel.text = measurable.metadataProvider.name;
  cell.measurableValueLabel.text = [measurable.valueFormatter formatValue:measurable.dataProvider.value];
  cell.measurableMetadataLabel.text = measurable.metadataProvider.metadataShort;
  
  NSString *dateString = [MeasurableHelper.measurableDateFormat stringFromDate:measurable.dataProvider.date];
  cell.measurableDateLabel.text = dateString;
  
  //Adjust the trend image to tailor to the metric specifics
  [UIHelper adjustImage:cell.measurableTrendImageButton forMeasurable:measurable];
  
  return cell;
}

+ (NSDateFormatter *)measurableDateFormat {
  if(!_measurableDateFormat) {
    _measurableDateFormat = [[NSDateFormatter alloc] init];
    _measurableDateFormat.dateFormat = NSLocalizedString(@"measurable-date-format", @"MM/dd/yy ");
  }
  return _measurableDateFormat;
}
@end
