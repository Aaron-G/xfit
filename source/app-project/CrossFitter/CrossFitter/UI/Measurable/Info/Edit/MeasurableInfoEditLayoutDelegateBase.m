//
//  MeasurableInfoEditLayoutDelegateBase.m
//  CrossFitter
//
//  Created by Cleo Barretto on 12/2/12.
//
//

#import "MeasurableInfoEditLayoutDelegateBase.h"
#import "MeasurableInfoEditViewController.h"
#import "UIHelper.h"

//Vertical spacing between UI component
static CGFloat VERTICAL_LAYOUT_PADDING = 0;

@implementation MeasurableInfoEditLayoutDelegateBase

- (void) layoutViewInViewController:(UIViewController*) viewController withMeasurable: (id<Measurable>) measurable withLayoutPosition:(CGPoint) startPosition {
  
  if([[viewController class] isSubclassOfClass: [MeasurableInfoEditViewController class]]) {
    
    MeasurableInfoEditViewController* measurableInfoEditViewController = (MeasurableInfoEditViewController*)viewController;
    
    //If we have a measurable and the UI components have been created
    if (measurable && measurableInfoEditViewController.tableView) {
      
      CGFloat layoutYCoordinate = startPosition.y;
      
      //Table View
      [UIHelper moveToYLocation:layoutYCoordinate
                reshapeWithSize:measurableInfoEditViewController.tableView.frame.size
                         orHide:NO
                           view:measurableInfoEditViewController.tableView
            withVerticalSpacing:VERTICAL_LAYOUT_PADDING];
    }
  }
}

@end
