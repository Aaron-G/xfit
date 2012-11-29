//
//  MeasurableViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/29/12.
//
//

#import "MeasurableViewController.h"
#import "MeasurableDetailSwitchViewController.h"
#import "MeasurableUpdateDelegate.h"
#import "UIHelper.h"
#import "MeasurableHelper.h"

@interface MeasurableViewController () {
  
}
@property MeasurableUpdateDelegate* updateDelegate;

- (IBAction)showMeasurableInfo;
- (IBAction)showMeasurableLog;

@end

@implementation MeasurableViewController

@synthesize measurable = _measurable;
@synthesize measurableDetailSwitchViewController = _measurableDetailSwitchViewController;
@synthesize measurableTitleView = _measurableTitleView;

-(id)initWithCoder:(NSCoder *)aDecoder {
  
  self = [super initWithCoder:aDecoder];
  if(self) {
    self.updateDelegate = [[MeasurableUpdateDelegate alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  //The first time around it can happen that we are not completely initialized yet
  //Invoking the getter triggers the re-search" for this property
  if(!_measurableDetailSwitchViewController) {    
    self.measurableDetailSwitchViewController.measurableViewController = self;
  }
  
  //Update the title view
  self.navigationItem.titleView = self.measurableTitleView;
  
  //Localize button labels
  self.barButtonItemLog.title = NSLocalizedString(@"log-label", @"Log");
  self.barButtonItemClearLog.title = NSLocalizedString(@"clear-label", @"Clear");
  self.barButtonItemChartLog.title = NSLocalizedString(@"chart-label", @"Chart");

  //Add the log button
  [self displayStandardButtons];
}

- (void)viewWillAppear:(BOOL)animated {
  
  [self updateView];

  [super viewWillAppear:animated];
}

- (NSUInteger)supportedInterfaceOrientations {
  return [UIHelper supportedInterfaceOrientations];
}

- (MeasurableTitleView *)measurableTitleView {
  if(!_measurableTitleView) {
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"MeasurableTitleView"
                                                         owner:self
                                                       options:nil];
    _measurableTitleView = (MeasurableTitleView *)[nibContents objectAtIndex:0];
  }
  return _measurableTitleView;
}

- (id<Measurable>)measurable {
  return _measurable;
}

- (void)setMeasurable:(id<Measurable>)measurable {
  _measurable = measurable;
  
  self.requiresViewUpdate = YES;
  [self updateView];
  
  //Do this after the previous call so that the location for the components to be
  //positioned is available to the Log and Info View Constrollers
  self.measurableDetailSwitchViewController.measurable = self.measurable;
}

- (MeasurableDetailSwitchViewController *)measurableDetailSwitchViewController {
  if(!_measurableDetailSwitchViewController) {
    for (UIViewController * viewController in self.childViewControllers) {
      if([viewController isKindOfClass: [MeasurableDetailSwitchViewController class]]) {
        _measurableDetailSwitchViewController = (MeasurableDetailSwitchViewController*)viewController;
      }
    }
  }
  return _measurableDetailSwitchViewController;
}

- (void) updateView {
  
  if(self.requiresViewUpdate) {
    
    //Update the view
    [self.updateDelegate updateViewInViewController:self withMeasurable: self.measurable withLayoutPosition: CGPointMake(0, 0)];
  }
}

- (IBAction)copyMeasurableAction:(id)sender {
}

- (IBAction)logMeasurableAction:(id)sender {
  
  MeasurableDataEntryViewController* measurableDataEntryViewController = [MeasurableHelper measurableDataEntryViewController];
  [measurableDataEntryViewController createMeasurableDataEntryInMeasurable:self.measurable withDelegate:self];
}

- (IBAction)chartMeasurableAction:(id)sender {
  
}

- (void)shareMeasurableInfoAction:(id)sender {
  [self.measurableDetailSwitchViewController.infoViewController share];
}

- (void)shareMeasurableLogAction:(id)sender {
  [self.measurableDetailSwitchViewController.logViewController share];
}

//////////////////////////////////////////////////////////////////
//CLEAR MEASURABLE

- (IBAction)clearEditMeasurableLogAction:(id)sender {
  [self.measurableDetailSwitchViewController.logViewController clearLog];  
}

//////////////////////////////////////////////////////////////////
//DONE MEASURABLE

- (IBAction)doneEditMeasurableInfoAction:(id)sender {
  [self doneEditMeasurableAction:self.measurableDetailSwitchViewController.infoViewController toolbarItems:self.measurableDetailSwitchViewController.infoToolbarItems switchButton:self.buttonSwitchToLog];
}

- (IBAction)doneEditMeasurableLogAction:(id)sender {
  [self doneEditMeasurableAction:self.measurableDetailSwitchViewController.logViewController toolbarItems:self.measurableDetailSwitchViewController.logToolbarItems switchButton:self.buttonSwitchToInfo];
}

- (void)doneEditMeasurableAction: (UIViewController*) viewController toolbarItems: (NSArray*) toolbarItems switchButton:(UIButton*) switchButton {
  
  self.measurableDetailSwitchViewController.collectionView.scrollEnabled = YES;
  [self displayStandardButtons];
  [self.toolbar setItems:toolbarItems animated:YES];
  
  switchButton.hidden = NO;

  [viewController setEditing:NO animated:YES];
}
//////////////////////////////////////////////////////////////////
//EDIT MEASURABLE
- (void)editMeasurableInfoAction:(id)sender {
  [self editMeasurableAction:self.measurableDetailSwitchViewController.infoViewController doneButton: self.barButtonItemDoneInfo switchButton:self.buttonSwitchToLog];
}

- (void)editMeasurableLogAction:(id)sender {
  [self editMeasurableAction:self.measurableDetailSwitchViewController.logViewController doneButton: self.barButtonItemDoneLog switchButton:self.buttonSwitchToInfo];
  
  if(self.measurable.dataProvider.values.count > 0) {
    self.barButtonItemClearLog.enabled = YES;
  } else {
    self.barButtonItemClearLog.enabled = NO;
  }
  
  [self.navigationItem setLeftBarButtonItem: self.barButtonItemClearLog animated:YES];
}

- (void)editMeasurableAction:(UIViewController*) viewController doneButton:(UIBarButtonItem*) doneButton switchButton:(UIButton*) switchButton {

  //Needed for Info screen where there is no left button
  self.navigationItem.hidesBackButton = YES;
  
  [self.navigationItem setRightBarButtonItem: doneButton animated:YES];
  
  [self.toolbar setItems: nil animated:YES];
  
  self.measurableDetailPageControl.hidden = YES;
  
  self.measurableDetailSwitchViewController.collectionView.scrollEnabled = NO;
  
  switchButton.hidden = YES;
  
  [viewController setEditing:YES animated:YES];
}

- (void)displayStandardButtons {
  self.navigationItem.hidesBackButton = NO;
  [self.navigationItem setLeftBarButtonItem: nil animated:YES];
  self.navigationItem.rightBarButtonItem = self.barButtonItemLog;
  self.measurableDetailPageControl.hidden = NO;
}

- (IBAction)showMeasurableInfo {
  [self.measurableDetailSwitchViewController showMeasurableInfo];
}
- (IBAction)showMeasurableLog {
  [self.measurableDetailSwitchViewController showMeasurableLog];
}

-(void)didFinishCreatingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (id<Measurable>) measurable {
  [self.measurableDetailSwitchViewController.logViewController logMeasurableDataEntry:measurableDataEntry];
}

-(void)didCancelCreatingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (id<Measurable>) measurable {
}


@end
