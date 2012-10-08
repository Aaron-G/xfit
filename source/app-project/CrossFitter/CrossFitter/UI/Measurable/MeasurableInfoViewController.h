//
//  MeasurableInfoViewController.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/30/12.
//
//

#import <UIKit/UIKit.h>
#import "Measurable.h"

@interface MeasurableInfoViewController : UIViewController

@property id<Measurable> measurable;
@property IBOutlet UITextView* metadataTextView;
@property IBOutlet UITextView* descriptionTextView;

@end
