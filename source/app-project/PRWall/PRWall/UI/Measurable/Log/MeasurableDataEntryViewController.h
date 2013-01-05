//
//  MeasurableDataEntryViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 11/21/12.
//
//

#import <UIKit/UIKit.h>
#import "MeasurableDataEntry.h"
#import "Measurable.h"
#import "MeasurableValuePickerView.h"
#import "MeasurableNumberValuePickerView.h"
#import "MeasurableNumberWithDecimalValuePickerView.h"
#import "MeasurablePercentValuePickerView.h"
#import "MeasurableTimeValuePickerView.h"
#import "MeasurableFootInchValuePickerView.h"

//Define it before the class definition as it is reference below
@protocol MeasurableDataEntryDelegate <NSObject>

-(void)didFinishCreatingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (id<Measurable>) measurable;
-(void)didCancelCreatingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (id<Measurable>) measurable;
-(void)didFinishEditingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (id<Measurable>) measurable;

@end

@interface MeasurableDataEntryViewController : UITableViewController <UITextViewDelegate, UITextFieldDelegate, MeasurableValuePickerViewDelegate>

@property IBOutlet UIBarButtonItem* doneBarButtonItem;
@property IBOutlet UIBarButtonItem* cancelBarButtonItem;

@property IBOutlet UIToolbar* editToolbar;

@property IBOutlet UIDatePicker* dateDatePicker;

@property IBOutlet UILabel* titleLabel;

//Value Edit Pickers
@property IBOutlet MeasurableNumberValuePickerView* valueTypeNumberPickerView;
@property IBOutlet MeasurableNumberWithDecimalValuePickerView* valueTypeNumberWithDecimalPickerView;
@property IBOutlet MeasurablePercentValuePickerView* valueTypePercentPickerView;
@property IBOutlet MeasurableTimeValuePickerView* valueTypeTimePickerView;
@property IBOutlet MeasurableFootInchValuePickerView* valueTypeFootInchPickerView;

@property id<Measurable> measurable;

-(void)editMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (id<Measurable>) measurable withDelegate:(id<MeasurableDataEntryDelegate>) delegate;

-(void)createMeasurableDataEntryInMeasurable: (id<Measurable>) measurable withDelegate:(id<MeasurableDataEntryDelegate>) delegate;

@end

