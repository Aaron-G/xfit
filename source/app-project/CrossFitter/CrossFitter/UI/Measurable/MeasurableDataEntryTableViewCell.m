//
//  MeasurableDataEntryTableViewCell.m
//  CrossFitter
//
//  Created by Cleo Barretto on 10/8/12.
//
//

#import "MeasurableDataEntryTableViewCell.h"

@implementation MeasurableDataEntryTableViewCell

@synthesize measurableTrendImageButton;
@synthesize measurableValueLabel;
@synthesize measurableDateLabel;

- (void)willTransitionToState:(UITableViewCellStateMask)state {
  
  [super willTransitionToState:state];

  if(UITableViewCellStateEditingMask == state) {
    self.measurableDateLabel.transform = CGAffineTransformMakeTranslation(-31, 0);
  } else if(UITableViewCellStateDefaultMask == state) {
    self.measurableDateLabel.transform = CGAffineTransformIdentity;
  }
}

@end
