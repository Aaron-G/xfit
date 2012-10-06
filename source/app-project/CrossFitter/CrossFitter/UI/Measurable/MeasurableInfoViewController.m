//
//  MeasurableInfoViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/30/12.
//
//

#import "MeasurableInfoViewController.h"

@interface MeasurableInfoViewController () {
  
}
@property BOOL needsUIUpdate;

@end

@implementation MeasurableInfoViewController

@synthesize measurable = _measurable;

- (void)setMeasurable:(id<Measurable>)measurable {
  _measurable = measurable;
  self.needsUIUpdate = YES;
  [self updateUI];
}

-(void)viewDidLoad {
  [super viewDidLoad];
  
  [self updateUI];
}
- (id<Measurable>)measurable {
  return _measurable;
}

- (void)viewWillAppear:(BOOL)animated {
  [self updateUI];
  
  [super viewWillAppear:animated];
}
- (void) updateUI {
  
  if(self.needsUIUpdate) {
    
    if (self.measurable && self.nameLabel) {
      
      self.nameLabel.text = self.measurable.metadataProvider.name;
      self.descriptionTextView.text = self.measurable.metadataProvider.description;
      self.metadataTextView.text = self.measurable.metadataProvider.metadataFull;
      
      self.needsUIUpdate = NO;
    }
  }
}

@end
