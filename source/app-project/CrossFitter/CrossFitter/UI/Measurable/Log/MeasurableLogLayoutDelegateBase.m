//
//  MeasurableLogLayoutDelegateBase.m
//  CrossFitter
//
//  Created by Cleo Barretto on 11/20/12.
//
//

#import "MeasurableLogLayoutDelegateBase.h"
#import "Measurable.h"
#import "MeasurableLogViewController.h"
#import "UIHelper.h"

@implementation MeasurableLogLayoutDelegateBase

//Vertical spacing between UI component
static CGFloat VERTICAL_LAYOUT_PADDING = 0;

- (void) layoutViewInViewController:(UIViewController*) viewController withMeasurable: (id<Measurable>) measurable withLayoutPosition:(CGPoint) startPosition {
  
  if([[viewController class] isSubclassOfClass: [MeasurableLogViewController class]]) {

    MeasurableLogViewController* measurableLogViewController = (MeasurableLogViewController*)viewController;

    //If we have a measurable and the UI components have been created
    if (measurable && measurableLogViewController.tableView) {
      
      CGFloat layoutYCoordinate = startPosition.y;
      
      //Description View
      [UIHelper moveToYLocation:layoutYCoordinate
                reshapeWithSize:measurableLogViewController.tableView.frame.size
                         orHide:NO
                           view:measurableLogViewController.tableView
            withVerticalSpacing:VERTICAL_LAYOUT_PADDING];
      
      
      //Message view
      [UIHelper moveToYLocation:layoutYCoordinate + 30
                reshapeWithSize:measurableLogViewController.messageTextView.frame.size
                         orHide: NO
                           view:measurableLogViewController.messageTextView
            withVerticalSpacing:VERTICAL_LAYOUT_PADDING];
      
      //The message view is very prominent so let's make a nice animation when showing it
      if(measurable.dataProvider.values.count == 0) {
        
        [UIView animateWithDuration: 0.5
                              delay: 0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                           measurableLogViewController.messageTextView.alpha = 1;
                         }
                         completion: nil];
        
      } else {
        measurableLogViewController.messageTextView.alpha = 0;
      }
      
      measurableLogViewController.needsLayout = NO;
    }
    
  }
}

@end
