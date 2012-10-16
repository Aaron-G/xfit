//
//  MeasurableInfoViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/30/12.
//
//

#import "MeasurableInfoViewController.h"
#import "MeasurableShareDelegate.h"
#import "MeasurableInfoShareDelegate.h"

@interface MeasurableInfoViewController ()

@property BOOL needsUIUpdate;
@property MeasurableShareDelegate* shareDelegate;

@end

@implementation MeasurableInfoViewController

@synthesize measurable = _measurable;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    // Custom initialization
    self.shareDelegate = [[MeasurableInfoShareDelegate alloc]initWithViewController:self withMeasurableProvider:self];
  }
  return self;
}

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
    
    if (self.measurable && self.descriptionTextView) {
      
      self.descriptionTextView.text = self.measurable.metadataProvider.description;
      self.metadataTextView.text = self.measurable.metadataProvider.metadataFull;
      
      self.needsUIUpdate = NO;
    }
  }
}

- (void) share {
  [self.shareDelegate share];
}

@end
