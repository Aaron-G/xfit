//
//  MeasurableViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/29/12.
//
//

#import "MeasurableViewController.h"
#import "MeasurableDetailSwitchViewController.h"
#import "UIHelper.h"

@interface MeasurableViewController () {
  
}
@property BOOL needsUIUpdate;

@end

@implementation MeasurableViewController

@synthesize measurable = _measurable;
@synthesize measurableDetailSwitchViewController = _measurableDetailSwitchViewController;
@synthesize measurableTitleView = _measurableTitleView;

-(id)initWithCoder:(NSCoder *)aDecoder {
  
  self = [super initWithCoder:aDecoder];
  if(self) {
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
  
  //Add the log button
  self.barButtonItemLog.title = NSLocalizedString(@"log-label", @"Log");
  [self displayStandardButtons];
}

- (void)viewWillAppear:(BOOL)animated {
  
  [self updateUI];

  [super viewWillAppear:animated];
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
  
  self.measurableDetailSwitchViewController.measurable = self.measurable;
  
  self.needsUIUpdate = YES;
  [self updateUI];  
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

- (void) updateUI {
  
  if(self.needsUIUpdate) {
    
    if (self.measurable && self.nameLabel) {
      
      self.nameLabel.text = self.measurable.metadataProvider.name;
      self.measurableTitleView.titleLabel.text = self.measurable.metadataProvider.type.displayName;
      self.needsUIUpdate = NO;
    }
  }
}

- (IBAction)copyMeasurableAction:(id)sender {
}

- (IBAction)logMeasurableAction:(id)sender {
}

- (void)shareMeasurableInfoAction:(id)sender {
  
}
- (void)shareMeasurableLogAction:(id)sender {
  
}
- (IBAction)chartMeasurableAction:(id)sender {
  
}

- (IBAction)doneEditMeasurableInfoAction:(id)sender {
  [self doneEditMeasurableAction:self.measurableDetailSwitchViewController.infoViewController toolbarItems:self.measurableDetailSwitchViewController.infoToolbarItems];
}

- (IBAction)doneEditMeasurableLogAction:(id)sender {
  [self doneEditMeasurableAction:self.measurableDetailSwitchViewController.logViewController toolbarItems:self.measurableDetailSwitchViewController.logToolbarItems];
}

- (void)doneEditMeasurableAction: (UIViewController*) viewController toolbarItems: (NSArray*) toolbarItems {
  
  self.measurableDetailSwitchViewController.collectionView.scrollEnabled = YES;
  [self displayStandardButtons];
  [self.toolbar setItems:toolbarItems animated:YES];
  
  [viewController setEditing:NO animated:YES];
}

- (void)editMeasurableInfoAction:(id)sender {
  [self editMeasurableAction:self.measurableDetailSwitchViewController.infoViewController doneButton: self.barButtonItemDoneInfo];
}

- (void)editMeasurableLogAction:(id)sender {
  [self editMeasurableAction:self.measurableDetailSwitchViewController.logViewController doneButton: self.barButtonItemDoneLog];
}

- (void)editMeasurableAction:(UIViewController*) viewController doneButton:(UIBarButtonItem*) doneButton {

  self.navigationItem.hidesBackButton = YES;
  [self.navigationItem setRightBarButtonItem: doneButton animated:YES];
  [self.toolbar setItems:nil animated:YES];
  
  self.measurableDetailPageControl.hidden = YES;
  
  self.measurableDetailSwitchViewController.collectionView.scrollEnabled = NO;
  
  [viewController setEditing:YES animated:YES];
}

- (void)displayStandardButtons {
  self.navigationItem.hidesBackButton = NO;
  self.navigationItem.rightBarButtonItem = self.barButtonItemLog;
  self.measurableDetailPageControl.hidden = NO;
}


@end
