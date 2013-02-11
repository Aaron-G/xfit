//
//  MeasurableViewController.m
//  PR Wall
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

@interface MeasurableViewController ()

@property BOOL measurableInfoEdited;

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
    self.layoutAsynchronous = NO;
  }
  return self;
}

#pragma mark - Measurable Layout View Controller
- (id<MeasurableViewLayoutDelegate>)layoutDelegate {
  return _layoutDelegate;
}

- (void)setMeasurable:(Measurable*)measurable {
  super.measurable = measurable;
  
  //Do this after the previous call so that the location for the components to be
  //positioned is available to the Log and Info View Constrollers
  self.measurableScreenCollectionViewController.measurable = self.measurable;
  
  self.measurableInfoEdited = NO;
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
  self.barButtonItemChartLog.image = [UIImage imageNamed: @"chart-bar-icon"];
  self.barButtonItemCopyMeasurable.image = [UIImage imageNamed: @"copy-icon"];
  
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
  
  MeasurableInfoEditViewController* measurableInfoEditViewController
    = [MeasurableHelper measurableInfoEditViewControllerForMeasurableCategoryIdentifier:MeasurableCategoryIdentifierExercise];
  measurableInfoEditViewController.delegate = self;
  
  [measurableInfoEditViewController createMeasurableInfoFromMeasurable:self.measurable];
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

- (void)doneEditMeasurableAction: (MeasurableLayoutViewController*) viewController toolbarItems: (NSArray*) toolbarItems switchButton:(UIButton*) switchButton {
  
  self.measurableScreenCollectionViewController.collectionView.scrollEnabled = YES;
  [self displayStandardButtons];
  [self.toolbar setItems:toolbarItems animated:YES];

  //CXB NOTE
  //Commented out now because not sure we want to have this
  //switchButton.hidden = NO;

  //Track it locally
  self.editing = NO;
  
  //Update UI
  [self forceLayout];

  [viewController setEditing:NO animated:YES];
  
  //Re-layout both so that things look updated 
  if(self.measurableInfoEdited) {
    [self fireDidEditMeasurableInfoForMeasurable:self.measurable];
    
    self.measurableInfoEdited = NO;
  } else {
    [self.measurableScreenCollectionViewController.logViewController forceLayout];
    [self.measurableScreenCollectionViewController.infoViewController forceLayout];
  }
}

//////////////////////////////////////////////////////////////////
//EDIT MEASURABLE
- (void)editMeasurableInfoAction:(id)sender {  
  [self editMeasurableAction:self.measurableScreenCollectionViewController.infoViewController doneButton: self.barButtonItemDoneInfo switchButton:self.buttonSwitchToLog];
}

- (void)editMeasurableLogAction:(id)sender {
  [self editMeasurableAction:self.measurableScreenCollectionViewController.logViewController doneButton: self.barButtonItemDoneLog switchButton:self.buttonSwitchToInfo];
  
  if(self.measurable.data.values.count > 0) {
    self.barButtonItemClearLog.enabled = YES;
  } else {
    self.barButtonItemClearLog.enabled = NO;
  }
  
  [self.navigationItem setLeftBarButtonItem: self.barButtonItemClearLog animated:YES];
}

- (void)editMeasurableAction:(MeasurableLayoutViewController*) viewController doneButton:(UIBarButtonItem*) doneButton switchButton:(UIButton*) switchButton {

  //Needed for Info screen where there is no left button
  self.navigationItem.hidesBackButton = YES;
  
  [self.navigationItem setRightBarButtonItem: doneButton animated:YES];
  
  [self.toolbar setItems: nil animated:YES];
  
  self.measurableDetailPageControl.hidden = YES;
  
  self.measurableScreenCollectionViewController.collectionView.scrollEnabled = NO;
  
  //CXB NOTE
  //Commented out now because not sure we want to have this
  //switchButton.hidden = YES;

  //Track it locally
  self.editing = YES;
  
  //Update UI
  [self forceLayout];

  [viewController setEditing:YES animated:YES];
  
  [viewController forceLayout];
}

- (void) changeToolbarVisibility: (BOOL) visible {

  [UIView animateWithDuration: 0.3
                        delay: 0
                      options: 0
                   animations:^{
                     self.toolbar.alpha = (visible) ? 1 : 0;
                   }
                   completion: nil];
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

-(void)didFinishCreatingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (Measurable*) measurable {
  [self.measurableScreenCollectionViewController.logViewController logMeasurableDataEntry:measurableDataEntry];

  //Update the MeasurableViewControllerDelegate
  [self.delegate didChangeMeasurable:measurable];
}

-(void)didCancelCreatingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable: (Measurable*) measurable {
}

- (void)didFinishEditingMeasurableDataEntry:(MeasurableDataEntry *)measurableDataEntry inMeasurable:(Measurable*)measurable {
}

- (void)didEditMeasurableInfoForMeasurable:(Measurable*)measurable {
  
  //Mark the measurable as edited so that we can fire this even only 1 time
  self.measurableInfoEdited = YES;
}

- (void) fireDidEditMeasurableInfoForMeasurable:(Measurable*)measurable {
  
  //Update the info VC
  [self.measurableScreenCollectionViewController.infoViewController reloadView];
  
  //Update the log VC
  [self.measurableScreenCollectionViewController.logViewController reloadView];
  
  //Update the MeasurableViewControllerDelegate
  [self.delegate didChangeMeasurable:measurable];
}

- (void)didDeleteMeasurableInfoForMeasurable:(Measurable*) measurable {
  [self.delegate didDeleteMeasurable:measurable];
}

- (void)didCreateMeasurableInfoForMeasurable:(Measurable*)measurable {    
  [self.delegate didCreateMeasurable:measurable];
}

@end
