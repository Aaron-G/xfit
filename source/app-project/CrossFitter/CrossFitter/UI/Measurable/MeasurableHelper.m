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
#import "MeasurableDataEntryTableViewCell.h"
#import "MeasurableType.h"
#import "BodyMetricInfoUpdateDelegate.h"

@interface MeasurableHelper () {
}

@end

@implementation MeasurableHelper

static NSDateFormatter* _measurableDateFormat;
static NSMutableDictionary* _measurableInfoUpdateDelegates;

+ (UITableViewCell *)tableViewCellForMeasurable: (id <Measurable>) measurable inTableView: (UITableView *)tableView {

  MeasurableTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurableTableViewCell"];
  
  BOOL hasValue = (measurable.dataProvider.value != nil);
  
  cell.measurableNameLabel.text = measurable.metadataProvider.name;
  cell.measurableMetadataLabel.text = measurable.metadataProvider.metadataShort;

  [UIHelper adjustImage:cell.measurableTrendImageButton forMeasurable:measurable];
  
  if(hasValue) {
    cell.measurableValueLabel.text = [measurable.valueFormatter formatValue:measurable.dataProvider.value];

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

  cell.measurableValueLabel.text = [measurable.valueFormatter formatValue:measurableDataEntry.value];
  
  NSString *dateString = [MeasurableHelper.measurableDateFormat stringFromDate:measurableDataEntry.date];
  cell.measurableDateLabel.text = dateString;
  
  //Adjust the trend image to tailor to the metric specifics
  [UIHelper adjustImage:cell.measurableTrendImageButton
withMeasurableValueTrend: measurableDataEntry.valueTrend
withMeasurableValueTrendBetterDirection: measurable.metadataProvider.valueTrendBetterDirection];

  return cell;
}

+ (NSDateFormatter *)measurableDateFormat {
  if(!_measurableDateFormat) {
    _measurableDateFormat = [[NSDateFormatter alloc] init];
    _measurableDateFormat.dateFormat = NSLocalizedString(@"measurable-date-format", @"MM/dd/yy ");
  }
  return _measurableDateFormat;
}

+ (NSMutableDictionary*) measurableInfoUpdateDelegates {
  if(!_measurableInfoUpdateDelegates) {
    _measurableInfoUpdateDelegates = [NSMutableDictionary dictionary];
  }
  return _measurableInfoUpdateDelegates;
}

+ (id<MeasurableInfoUpdateDelegate>)measurableInfoUpdateDelegateForMeasurable:(id<Measurable>)measurable {

  MeasurableType* measurableType = measurable.metadataProvider.type;
  
  id<MeasurableInfoUpdateDelegate> measurableInfoUpdateDelegate = [[MeasurableHelper measurableInfoUpdateDelegates] objectForKey: measurableType.displayName];
  
  if(!measurableInfoUpdateDelegate) {
    
    if(measurableType.identifier == MeasurableTypeIdentifierBodyMetric) {
      measurableInfoUpdateDelegate  = [[BodyMetricInfoUpdateDelegate alloc] init];
    }
    
    [[MeasurableHelper measurableInfoUpdateDelegates] setObject:measurableInfoUpdateDelegate forKey: measurableType.displayName];
  }
  
  return measurableInfoUpdateDelegate;  
}

@end
