//
//  MeasurableInfoViewController.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/30/12.
//
//

#import <UIKit/UIKit.h>
#import "Measurable.h"
#import "MeasurableProvider.h"

@interface MeasurableInfoViewController : UIViewController <MeasurableProvider>

@property id<Measurable> measurable;
@property IBOutlet UITextView* metadataTextView;
@property IBOutlet UITextView* descriptionTextView;

- (void) share;

@end
