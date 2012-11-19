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
#import "UIHelper.h"

@implementation MeasurableInfoUpdateDelegateBase

//Vertical spacing between UI component
static CGFloat VERTICAL_LAYOUT_PADDING = 0;

//Vertical position where to start to layout the UI components
//
//This is the bottom of the of the "divider" under the measurable names
static CGFloat VERTICAL_LAYOUT_START_POSITION = 36;

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
  
  CGFloat layoutYCoordinate = VERTICAL_LAYOUT_START_POSITION;

  //Metadata (Full) View
  layoutYCoordinate = [UIHelper moveToYLocation:layoutYCoordinate
                                reshapeWithSize:CGSizeMake(measurableInfoViewController.metadataTextView.frame.size.width, measurableInfoViewController.metadataTextView.contentSize.height)
                                         orHide:(measurable.metadataProvider.metadataFull == nil)
                                           view:measurableInfoViewController.metadataTextView
                            withVerticalSpacing:VERTICAL_LAYOUT_PADDING];
  
  //Description View
  layoutYCoordinate = [UIHelper moveToYLocation:layoutYCoordinate
                                reshapeWithSize:CGSizeMake(measurableInfoViewController.descriptionTextView.frame.size.width, measurableInfoViewController.descriptionTextView.contentSize.height)
                                         orHide:(measurable.metadataProvider.description == nil)
                                           view:measurableInfoViewController.descriptionTextView
                            withVerticalSpacing:VERTICAL_LAYOUT_PADDING];
  
}

@end
