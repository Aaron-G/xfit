//
//  MeasurableDataEntryTableViewCell.m
//  PR Wall
//
//  Created by Cleo Barretto on 10/8/12.
//
//

#import "MeasurableDataEntryTableViewCell.h"

@interface MeasurableDataEntryTableViewCell ()

@property CGRect previousMeasurableAdditionalInfoImageButtonFrame;

@end

@implementation MeasurableDataEntryTableViewCell

const NSInteger MeasurableDataEntryTableViewCellHeight = 45;

@synthesize measurableTrendImageButton;
@synthesize measurableValueLabel;
@synthesize measurableDateLabel;
@synthesize measurableAdditionalInfoImageButton;

- (void)prepareForReuse {
  [super prepareForReuse];
  self.measurableTrendImageButton.transform = CGAffineTransformIdentity;  
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
  
  //invoke the super behavior
  [super setEditing:editing animated:animated];

  if(editing) {
    
    //Hide this
    self.measurableAdditionalInfoImageButton.hidden = YES;

  } else {
    
    //Reevaluate this as it may have changed
    self.measurableAdditionalInfoImageButton.hidden = ![self.measurableDataEntry hasAdditionalInfo];
  }
}

@end