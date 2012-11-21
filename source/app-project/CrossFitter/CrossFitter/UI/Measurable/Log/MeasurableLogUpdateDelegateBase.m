//
//  MeasurableLogUpdateDelegateBase.m
//  CrossFitter
//
//  Created by Cleo Barretto on 11/20/12.
//
//

#import "MeasurableLogUpdateDelegateBase.h"
#import "Measurable.h"
#import "MeasurableLogViewController.h"
#import "UIHelper.h"

@implementation MeasurableLogUpdateDelegateBase

//Vertical spacing between UI component
static CGFloat VERTICAL_LAYOUT_PADDING = 0;

- (void) updateViewInViewController:(UIViewController*) viewController withMeasurable: (id<Measurable>) measurable withLayoutPosition:(CGPoint) startPosition {
  
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
      
      measurableLogViewController.requiresViewUpdate = NO;
    }
  }
}

@end
