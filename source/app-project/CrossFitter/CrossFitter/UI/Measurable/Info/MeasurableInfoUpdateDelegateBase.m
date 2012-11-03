//
//  MeasurableInfoUpdateDelegateBase.m
//  CrossFitter
//
//  Created by Cleo Barretto on 11/2/12.
//
//

#import "MeasurableInfoUpdateDelegateBase.h"
#import "Measurable.h"
#import "MeasurableInfoViewController.h"

@implementation MeasurableInfoUpdateDelegateBase

//Vertical spacing between UI component
static CGFloat LAYOUT_VERTICAL_SPACING = 0;

//Vertical position where to start to layout the UI components
//
//This is the bottom of the of the "divider" under the measurable names
static CGFloat LAYOUT_VERTICAL_START_POSITION = 36;

- (void) updateUIWithMeasurable: (id<Measurable>) measurable inMeasurableInfoViewController:(MeasurableInfoViewController*) measurableInfoViewController {
  [self updateUIContentWithMeasurable:measurable inMeasurableInfoViewController:measurableInfoViewController];
  [self layoutUIForMeasurable:measurable inMeasurableInfoViewController:measurableInfoViewController];
}

- (void)updateUIContentWithMeasurable:(id<Measurable>)measurable inMeasurableInfoViewController:(MeasurableInfoViewController *)measurableInfoViewController {
  
  //Metadata (Full) View
  measurableInfoViewController.metadataTextView.text = measurable.metadataProvider.metadataFull;

  //Description View
  measurableInfoViewController.descriptionTextView.text = measurable.metadataProvider.description;  
}

- (void)layoutUIForMeasurable:(id<Measurable>)measurable inMeasurableInfoViewController:(MeasurableInfoViewController *)measurableInfoViewController {
  
  CGFloat layoutYCoordinate = LAYOUT_VERTICAL_START_POSITION;

  //Metadata (Full) View
  layoutYCoordinate = [self moveToLocation:layoutYCoordinate
                           reshapeWithSize:CGSizeMake(measurableInfoViewController.metadataTextView.frame.size.width, measurableInfoViewController.metadataTextView.contentSize.height)
                                    orHide:(measurable.metadataProvider.metadataFull == nil)
                                      view:measurableInfoViewController.metadataTextView];
  
  //Description View
  layoutYCoordinate = [self moveToLocation:layoutYCoordinate
                           reshapeWithSize:CGSizeMake(measurableInfoViewController.descriptionTextView.frame.size.width, measurableInfoViewController.descriptionTextView.contentSize.height)
                                    orHide:(measurable.metadataProvider.description == nil)
                                      view:measurableInfoViewController.descriptionTextView];
  
}

- (CGFloat) moveToLocation:(CGFloat) location reshapeWithSize:(CGSize) size orHide:(BOOL) hide view:(UIView*) view {

  if(hide) {
    view.hidden = YES;
    return location;
  } else {
    CGRect curViewFrame = view.frame;
    CGRect newViewFrame = CGRectMake(curViewFrame.origin.x, location, size.width, size.height);
    view.frame = newViewFrame;
    
    //Unhide, just in case it was hidden before
    view.hidden = NO;
    
    return newViewFrame.origin.y + newViewFrame.size.height + LAYOUT_VERTICAL_SPACING;
  }
}

@end
