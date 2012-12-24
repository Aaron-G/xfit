//
//  MeasurableInfoViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/30/12.
//
//

#import <UIKit/UIKit.h>
#import "MeasurableLayoutViewController.h"

@interface MeasurableInfoViewController : MeasurableLayoutViewController

@property IBOutlet UITextView* descriptionTextView;
@property IBOutlet UIButton* dividerButton;

- (void) share;

@end
