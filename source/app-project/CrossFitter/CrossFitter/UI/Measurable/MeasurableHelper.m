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
#import "MeasurableDataEntryAdditionalInfoTableViewCell.h"
#import "MeasurableViewUpdateDelegate.h"
#import "MeasurableLogUpdateDelegateBase.h"
#import "BodyMetricInfoEditViewController.h"
#import "MeasurableInfoEditUpdateDelegateBase.h"

@interface MeasurableHelper () {
}

@end

@implementation MeasurableHelper

static NSDateFormatter* _measurableDateFormat;
static NSMutableDictionary* _measurableInfoViewUpdateDelegates;
static id<MeasurableViewUpdateDelegate> _measurableInfoEditViewUpdateDelegate;
static id<MeasurableViewUpdateDelegate> _measurableLogViewUpdateDelegate;
static MeasurableDataEntryViewController* _measurableDataEntryViewController;

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

+ (NSMutableDictionary*) measurableInfoUpdateDelegates {
  if(!_measurableInfoViewUpdateDelegates) {
    _measurableInfoViewUpdateDelegates = [NSMutableDictionary dictionary];
  }
  return _measurableInfoViewUpdateDelegates;
}

+ (id<MeasurableViewUpdateDelegate>) measurableInfoViewUpdateDelegateForMeasurable: (id<Measurable>) measurable {
  
  MeasurableType* measurableType = measurable.metadataProvider.type;
  
  id<MeasurableViewUpdateDelegate> measurableInfoUpdateDelegate = [[MeasurableHelper measurableInfoUpdateDelegates] objectForKey: measurableType.displayName];
  
  if(!measurableInfoUpdateDelegate) {
    
    if(measurableType.identifier == MeasurableTypeIdentifierBodyMetric) {
      measurableInfoUpdateDelegate  = [[BodyMetricInfoUpdateDelegate alloc] init];
    }
    
    [[MeasurableHelper measurableInfoUpdateDelegates] setObject:measurableInfoUpdateDelegate forKey: measurableType.displayName];
  }
  
  return measurableInfoUpdateDelegate;  
}

+ (id<MeasurableViewUpdateDelegate>) measurableInfoEditViewUpdateDelegate {
  if(!_measurableInfoEditViewUpdateDelegate) {
    _measurableInfoEditViewUpdateDelegate = [[MeasurableInfoEditUpdateDelegateBase alloc] init];

  }
  return _measurableInfoEditViewUpdateDelegate;
}

+ (id<MeasurableViewUpdateDelegate>) measurableInfoEditViewUpdateDelegateForMeasurable: (id<Measurable>) measurable {
  //They all use the same logic - for now
  return [MeasurableHelper measurableInfoEditViewUpdateDelegate];
}

+ (id<MeasurableViewUpdateDelegate>) measurableLogViewUpdateDelegate {
  if(!_measurableLogViewUpdateDelegate) {
    _measurableLogViewUpdateDelegate = [[MeasurableLogUpdateDelegateBase alloc] init];
  }
  return _measurableLogViewUpdateDelegate;
}

+ (id<MeasurableViewUpdateDelegate>) measurableLogViewUpdateDelegateForMeasurable: (id<Measurable>) measurable {
  //They all use the same logic - for now
  return [MeasurableHelper measurableLogViewUpdateDelegate];
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

@end
