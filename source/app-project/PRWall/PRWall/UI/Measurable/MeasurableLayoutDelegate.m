//
//  MeasurableLayoutDelegate.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/20/12.
//
//

#import "MeasurableLayoutDelegate.h"
#import "MeasurableViewController.h"
#import "UIHelper.h"

@implementation MeasurableLayoutDelegate

- (void) layoutViewInViewController:(UIViewController*) viewController withMeasurable: (id<Measurable>) measurable withLayoutPosition:(CGPoint) startPosition {
  
  if([[viewController class] isSubclassOfClass: [MeasurableViewController class]]) {
    
    MeasurableViewController* measurableViewController = (MeasurableViewController*)viewController;

    //If we have a measurable and the UI components have been created
    if (measurable && measurableViewController.nameLabel) {
      
      CGFloat newYLocation = measurableViewController.nameLabel.frame.origin.y;
           
      //1- Update UI components content
      
      //Title
      NSString* title = nil;
      if(measurableViewController.editing) {
        
        NSString* titleFormat = nil;
        if(measurableViewController.measurableScreenCollectionViewController.currentViewControllerIndex == MEASURABLE_INFO_SCREEN_INDEX) {
          titleFormat = @"measurable-edit-info-title-format";
        } else {
          titleFormat = @"measurable-edit-log-title-format";
        }
        
        title = NSLocalizedString(titleFormat, @"Edit Info/Log");
      } else {
        title = measurable.metadataProvider.type.displayName;
      }
      measurableViewController.measurableTitleView.titleLabel.text = title;
      
      if(measurableViewController.editing &&
         measurable.metadataProvider.type.identifier != MeasurableTypeIdentifierBodyMetric &&
         measurableViewController.measurableScreenCollectionViewController.currentViewControllerIndex == MEASURABLE_INFO_SCREEN_INDEX) {
        measurableViewController.nameLabel.hidden = YES;
        measurableViewController.metadataTextView.hidden = YES;
      } else {
      
        measurableViewController.nameLabel.hidden = NO;
        measurableViewController.metadataTextView.hidden = NO;
        
        measurableViewController.nameLabel.text = measurable.metadataProvider.name;
        measurableViewController.metadataTextView.text = measurable.metadataProvider.metadataFull;
        
        //2- Update UI components layout
        newYLocation += measurableViewController.nameLabel.frame.size.height;
        
        //Reduce the space between the name and the metadata - too much white space
        if(measurable.metadataProvider.metadataFull != nil) {
          newYLocation-=8;
          
          //Adjust the height of the metadata text field as it can vary considerably
          newYLocation = [UIHelper moveToYLocation:newYLocation
                                   reshapeWithSize:CGSizeMake(measurableViewController.metadataTextView.frame.size.width, measurableViewController.metadataTextView.contentSize.height)
                                            orHide:(measurable.metadataProvider.metadataFull == nil)
                                              view:measurableViewController.metadataTextView
                          //Reduce the space between the metadata and the rest of
                          //the content - too much white space
                               withVerticalSpacing:-5];
        }
        
        newYLocation-=5;
      }
      
      measurableViewController.needsLayout = NO;
      
      //3- Update the Info and Log VCs so that they know where to layout their view
      CGPoint newStartPosition = CGPointMake(startPosition.x, newYLocation);
      
      measurableViewController.measurableScreenCollectionViewController.infoViewController.layoutPosition = newStartPosition;
      measurableViewController.measurableScreenCollectionViewController.logViewController.layoutPosition = newStartPosition;
    }
  }
}
@end
