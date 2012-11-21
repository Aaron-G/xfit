//
//  MeasurableUpdateDelegate.m
//  CrossFitter
//
//  Created by Cleo Barretto on 11/20/12.
//
//

#import "MeasurableUpdateDelegate.h"
#import "MeasurableViewController.h"
#import "UIHelper.h"

@implementation MeasurableUpdateDelegate

- (void) updateViewInViewController:(UIViewController*) viewController withMeasurable: (id<Measurable>) measurable withLayoutPosition:(CGPoint) startPosition {
  
  if([[viewController class] isSubclassOfClass: [MeasurableViewController class]]) {
    
    MeasurableViewController* measurableViewController = (MeasurableViewController*)viewController;

    //If we have a measurable and the UI components have been created
    if (measurable && measurableViewController.nameLabel) {
      
      //1- Update UI components content
      measurableViewController.nameLabel.text = measurable.metadataProvider.name;
      measurableViewController.measurableTitleView.titleLabel.text = measurable.metadataProvider.type.displayName;
      measurableViewController.metadataTextView.text = measurable.metadataProvider.metadataFull;
      
      //2- Update UI components layout
      CGFloat newYLocation = (measurableViewController.nameLabel.frame.origin.y + measurableViewController.nameLabel.frame.size.height);
      
      //Reduce the space between the name and the metadata - too much white space
      newYLocation-=5;
      
      //Adjust the height of the metadata text field as it can vary considerably
      newYLocation = [UIHelper moveToYLocation:newYLocation
                               reshapeWithSize:CGSizeMake(measurableViewController.metadataTextView.frame.size.width, measurableViewController.metadataTextView.contentSize.height)
                                        orHide:(measurable.metadataProvider.metadataFull == nil)
                                          view:measurableViewController.metadataTextView
                      //Reduce the space between the metadata and the rest of
                      //the content - too much white space
                           withVerticalSpacing:-10];
      
      measurableViewController.requiresViewUpdate = NO;
      
      //3- Update the Info and Log VCs so that they know where to layout their view
      CGPoint newStartPosition = CGPointMake(startPosition.x, newYLocation);
      
      measurableViewController.measurableDetailSwitchViewController.infoViewController.viewLayoutPosition = newStartPosition;
      measurableViewController.measurableDetailSwitchViewController.logViewController.viewLayoutPosition = newStartPosition;      
    }
  }
}
@end
