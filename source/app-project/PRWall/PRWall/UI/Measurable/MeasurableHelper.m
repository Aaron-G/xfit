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
#import "MeasurableDataEntryAdditionalInfoTableViewCell.h"
#import "MeasurableViewLayoutDelegate.h"
#import "MeasurableLogLayoutDelegateBase.h"
#import "BodyMetricInfoEditViewController.h"
#import "MeasurableInfoEditLayoutDelegateBase.h"

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
withMeasurableValueTrendBetterDirection: measurable.metadataProvider.valueTrendBetterDirection];

  //Show or Hide the Info button/icon
  cell.measurableAdditionalInfoImageButton.hidden = (!measurableDataEntry.hasAdditionalInfo);
  
  return cell;
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
  } else if(MeasurableTypeIdentifierMove == typeIdentifier) {
    return MediaHelperPurposeMove;
  } else if(MeasurableTypeIdentifierWorkout == typeIdentifier) {
    return MediaHelperPurposeWorkout;
  } else if(MeasurableTypeIdentifierWOD == typeIdentifier) {
    return MediaHelperPurposeWOD;
  }
  return -1;
}


+ (MeasurableInfoEditViewController*) measurableInfoEditViewControllerForMeasurable:(id<Measurable>)measurable {

  MeasurableTypeIdentifier typeIdentifier = measurable.metadataProvider.type.identifier;
  
  NSString* viewControllerName = nil;
  
  if(MeasurableTypeIdentifierBodyMetric == typeIdentifier) {
    viewControllerName = @"BodyMetricInfoEditViewController";    
  } else if(MeasurableTypeIdentifierMove == typeIdentifier) {
    
  } else if(MeasurableTypeIdentifierWorkout == typeIdentifier) {
    
  } else if(MeasurableTypeIdentifierWOD == typeIdentifier) {
    
  }

  MeasurableInfoEditViewController* measurableInfoEditViewController = nil;
  
  if(viewControllerName) {
    measurableInfoEditViewController = (MeasurableInfoEditViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier:viewControllerName];
    measurableInfoEditViewController.measurable = measurable;
  }

  return measurableInfoEditViewController;
}

+ (MeasurableChartViewController*) measurableChartViewController {
  if(!_measurableChartViewController) {
    _measurableChartViewController = (MeasurableChartViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier:@"MeasurableChartViewController"];
  }
  return _measurableChartViewController;
}

@end
