//
//  MeasurableDataEntryTableViewCell.m
//  CrossFitter
//
//  Created by Cleo Barretto on 10/8/12.
//
//

#import "MeasurableDataEntryTableViewCell.h"

@interface MeasurableDataEntryTableViewCell ()

@property CGRect previousMeasurableAdditionalInfoImageButtonFrame;

@end

@implementation MeasurableDataEntryTableViewCell

@synthesize measurableTrendImageButton;
@synthesize measurableValueLabel;
@synthesize measurableDateLabel;
@synthesize measurableAdditionalInfoImageButton;

- (void)prepareForReuse {
  
  [super prepareForReuse];
  
  //In case the cell was deleted from the table and never got a change to reset to its non editing state
  if(!CGRectIsEmpty(self.previousMeasurableAdditionalInfoImageButtonFrame)) {
    [self moveMeasurableAdditionalInfoImageButtonFrameAnimated: CGAffineTransformTranslate (self.measurableDateLabel.transform, -23, 0)];
  }
  self.measurableDateLabel.hidden = NO;
  
  //Reset this control variable
  self.previousMeasurableAdditionalInfoImageButtonFrame = CGRectMake(0, 0, 0, 0);  
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
  
  if(editing) {
    
    //This means that we are edting a given row specifically - ignore this
    if(!CGRectIsEmpty(self.previousMeasurableAdditionalInfoImageButtonFrame)) {
      [super setEditing:editing animated:animated];
    } else {
      //Change to non editing look
      self.measurableAdditionalInfoImageButton.hidden = YES;
      
      //Save the hidden state
      self.previousMeasurableAdditionalInfoImageButtonFrame = self.measurableDateLabel.frame;
      
      //invoke the super behavior
      [super setEditing:editing animated:animated];
      
      //Restore the position of the date label
      self.measurableDateLabel.frame = self.previousMeasurableAdditionalInfoImageButtonFrame;
      
      //Translate a bit so that it does not overalp with the editing control
      //Animate it so that it looks smooth
      [self moveMeasurableAdditionalInfoImageButtonFrameAnimated: CGAffineTransformTranslate (self.measurableDateLabel.transform, -30, 0)];
    }
  } else {
    
    //Invoke the super behavior first
    [super setEditing:editing animated:animated];
    
    //Reevaluate this as it may have changed
    self.measurableAdditionalInfoImageButton.hidden = ![self.measurableDataEntry hasAdditionalInfo];
    
    //Restore the non-editing look - if appropriate
    if(!CGRectIsEmpty(self.previousMeasurableAdditionalInfoImageButtonFrame)) {
      
      self.measurableDateLabel.frame = self.previousMeasurableAdditionalInfoImageButtonFrame;
      self.previousMeasurableAdditionalInfoImageButtonFrame = CGRectMake(0, 0, 0, 0);
    }
  }
}

- (void) moveMeasurableAdditionalInfoImageButtonFrameAnimated: (CGAffineTransform) transform {
  
  [UIView animateWithDuration: 0.3
                        delay: 0
                      options: 0
                   animations:^{
                     self.measurableDateLabel.transform = transform;
                   }
                   completion: nil];
}

- (void)willTransitionToState:(UITableViewCellStateMask)state {
  
  [super willTransitionToState:state];
  
  if ((state & UITableViewCellStateShowingDeleteConfirmationMask) == UITableViewCellStateShowingDeleteConfirmationMask) {
    self.measurableDateLabel.hidden = YES;
  } else {
    self.measurableDateLabel.hidden = NO;
  }
}

@end