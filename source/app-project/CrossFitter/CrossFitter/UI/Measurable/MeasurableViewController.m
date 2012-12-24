//
//  MeasurableViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/29/12.
//
//

#import "MeasurableViewController.h"
#import "MeasurableScreenCollectionViewController.h"
#import "UIHelper.h"
#import "MeasurableHelper.h"
#import "MeasurableLayoutDelegate.h"
#import "MeasurableChartViewController.h"

@interface MeasurableViewController () {  
}

- (IBAction)displayMeasurableInfo;
- (IBAction)displayMeasurableLog;

@end

@implementation MeasurableViewController

@synthesize measurableScreenCollectionViewController = _measurableScreenCollectionViewController;
@synthesize measurableTitleView = _measurableTitleView;

@synthesize layoutDelegate = _layoutDelegate;

-(id)initWithCoder:(NSCoder *)aDecoder {
  
  self = [super initWithCoder:aDecoder];
  if(self) {
    _layoutDelegate = [[MeasurableLayoutDelegate alloc] init];
    self.layoutPosition = CGPointMake(0, 0);
  }
  return self;
}

#pragma mark - Measurable Layout View Controller
- (id<MeasurableViewLayoutDelegate>)layoutDelegate {
  return _layoutDelegate;
}

- (void)setMeasurable:(id<Measurable>)measurable {
  super.measurable = measurable;
  
  //Do this after the previous call so that the location for the components to be
  //positioned is available to the Log and Info View Constrollers
  self.measurableScreenCollectionViewController.measurable = self.measurable;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Pas along the measurable when the view is first loaded
  self.measurableScreenCollectionViewController.measurable = self.measurable;
  
  //Update the title view
  self.navigationItem.titleView = self.measurableTitleView;
  
  //Localize button labels
  self.barButtonItemLog.title = NSLocalizedString(@"log-label", @"Log");
  self.barButtonItemClearLog.title = NSLocalizedString(@"clear-label", @"Clear");
  self.barButtonItemChartLog.image = [UIImage imageNamed: @"chart-bar-icon.png"];

  //Add the log button
  [self displayStandardButtons];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
  return UIInterfaceOrientationPortrait;
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

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  //We need to propagate this so that the measurable screens can properly prepare and cleanup things when being hidden/shown
  [self.measurableScreenCollectionViewController.displayedMeasurableScreen viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];

  //We need to propagate this so that the measurable screens can properly prepare and cleanup things when being hidden/shown
  [self.measurableScreenCollectionViewController.displayedMeasurableScreen viewDidDisappear:animated];
}

- (MeasurableScreenCollectionViewController *)measurableScreenCollectionViewController {
  if(!_measurableScreenCollectionViewController) {
    for (UIViewController * viewController in self.childViewControllers) {
      if([viewController isKindOfClass: [MeasurableScreenCollectionViewController class]]) {
        _measurableScreenCollectionViewController = (MeasurableScreenCollectionViewController*)viewController;
      }
    }
  }
  return _measurableScreenCollectionViewController;
}


- (IBAction)copyMeasurableAction:(id)sender {
}

- (IBAction)logMeasurableAction:(id)sender {
  
  MeasurableDataEntryViewController* measurableDataEntryViewController = [MeasurableHelper measurableDataEntryViewController];
  [measurableDataEntryViewController createMeasurableDataEntryInMeasurable:self.measurable withDelegate:self];
}

- (IBAction)chartMeasurableAction:(id)sender {
  
  if(self.barButtonItemChartLog.enabled && !self.editing) {
    MeasurableChartViewController* measurableChartViewController = [MeasurableHelper measurableChartViewController];
    [measurableChartViewController displayChartForMeasurable:self.measurable];
  }
}

- (void)shareMeasurableInfoAction:(id)sender {
  [self.measurableScreenCollectionViewController.infoViewController share];
}

- (void)shareMeasurableLogAction:(id)sender {
  [self.measurableScreenCollectionViewController.logViewController share];
}

//////////////////////////////////////////////////////////////////
//CLEAR MEASURABLE

- (IBAction)clearEditMeasurableLogAction:(id)sender {
  [self.measurableScreenCollectionViewController.logViewController clearLog];
}

//////////////////////////////////////////////////////////////////
//DONE MEASURABLE

- (IBAction)doneEditMeasurableInfoAction:(id)sender {
  [self doneEditMeasurableAction:self.measurableScreenCollectionViewController.infoViewController toolbarItems:self.measurableScreenCollectionViewController.infoToolbarItems switchButton:self.buttonSwitchToLog];
}

- (IBAction)doneEditMeasurableLogAction:(id)sender {
  [self doneEditMeasurableAction:self.measurableScreenCollectionViewController.logViewController toolbarItems:self.measurableScreenCollectionViewController.logToolbarItems switchButton:self.buttonSwitchToInfo];
}

- (void)doneEditMeasurableAction: (UIViewController*) viewController toolbarItems: (NSArray*) toolbarItems switchButton:(UIButton*) switchButton {
  
  self.measurableScreenCollectionViewController.collectionView.scrollEnabled = YES;
  [self displayStandardButtons];
  [self.toolbar setItems:toolbarItems animated:YES];
  
  //CXB NOTE
  //Commented out now because not sure we want to have this
  //switchButton.hidden = NO;

  [viewController setEditing:NO animated:YES];

  //Track it locally
  self.editing = NO;
}
//////////////////////////////////////////////////////////////////
//EDIT MEASURABLE
- (void)editMeasurableInfoAction:(id)sender {
  [self editMeasurableAction:self.measurableScreenCollectionViewController.infoViewController doneButton: self.barButtonItemDoneInfo switchButton:self.buttonSwitchToLog];
}

- (void)editMeasurableLogAction:(id)sender {
  [self editMeasurableAction:self.measurableScreenCollectionViewController.logViewController doneButton: self.barButtonItemDoneLog switchButton:self.buttonSwitchToInfo];
  
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
  
  self.measurableScreenCollectionViewController.collectionView.scrollEnabled = NO;
  
  //CXB NOTE
  //Commented out now because not sure we want to have this
  //switchButton.hidden = YES;
  
  [viewController setEditing:YES animated:YES];
  
  //Track it locally
  self.editing = YES;
}

- (void)displayStandardButtons {
  self.navigationItem.hidesBackButton = NO;
  [self.navigationItem setLeftBarButtonItem: nil animated:YES];
  self.navigationItem.rightBarButtonItem = self.barButtonItemLog;
  self.measurableDetailPageControl.hidden = NO;
}

- (IBAction)displayMeasurableInfo {
  [self.measurableScreenCollectionViewController displayMeasurableInfo];
}
- (IBAction)displayMeasurableLog {
  [self.measurableScreenCollectionViewController displayMeasurableLog];
}

-(void)didFinishCreatingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (id<Measurable>) measurable {
  [self.measurableScreenCollectionViewController.logViewController logMeasurableDataEntry:measurableDataEntry];

  //Update the MeasurableViewControllerDelegate
  [self.delegate didChangeMeasurable:self.measurable];
}

-(void)didCancelCreatingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (id<Measurable>) measurable {
}

- (void)didEditMeasurableInfoForMeasurable:(id<Measurable>)measurable {

  //Update the info VC
  [self.measurableScreenCollectionViewController.infoViewController reloadView];

  //Update the log VC
  [self.measurableScreenCollectionViewController.logViewController reloadView];
  
  //Update the MeasurableViewControllerDelegate
  [self.delegate didChangeMeasurable:self.measurable];
}

@end
