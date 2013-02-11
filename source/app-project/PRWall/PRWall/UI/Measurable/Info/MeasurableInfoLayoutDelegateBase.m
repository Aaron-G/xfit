//
//  MeasurableInfoLayoutDelegateBase.m
//  PR Wall
//
//  Created by Cleo Barretto on 11/2/12.
//
//

#import "MeasurableInfoLayoutDelegateBase.h"
#import "Measurable.h"
#import "MeasurableInfoViewController.h"
#import "UIHelper.h"
#import "ActivityMetadata.h"
#import "MediaCollectionViewCell.h"

@implementation MeasurableInfoLayoutDelegateBase

//Vertical spacing between UI component
static CGFloat VERTICAL_LAYOUT_PADDING = 5;

- (void) layoutViewInViewController:(UIViewController*) viewController withMeasurable: (Measurable*) measurable withLayoutPosition:(CGPoint) startPosition {
  
  if([[viewController class] isSubclassOfClass: [MeasurableInfoViewController class]]) {

    MeasurableInfoViewController* measurableInfoViewController = (MeasurableInfoViewController*)viewController;
    
    //If we have a measurable and the UI components have been created
    if (measurable && measurableInfoViewController.descriptionTextView) {
      
      [self updateContentWithMeasurable:measurable inMeasurableInfoViewController:measurableInfoViewController];
      [self updateLayoutWithMeasurable:measurable inMeasurableInfoViewController:measurableInfoViewController startAtPosition:startPosition];
      
      measurableInfoViewController.needsLayout = NO;
    }
  }
}

- (void)updateContentWithMeasurable:(Measurable*)measurable inMeasurableInfoViewController:(MeasurableInfoViewController *)measurableInfoViewController {
  
  //Description View
  measurableInfoViewController.descriptionTextView.text = measurable.metadata.definition;
  
  //Media View
  [measurableInfoViewController.mediaView reloadData];
}

- (void) updateLayoutWithMeasurable: (Measurable*) measurable inMeasurableInfoViewController:(MeasurableInfoViewController*) measurableInfoViewController startAtPosition:(CGPoint) startPosition {

  //Additional space to align properly with Log content
  CGFloat layoutYCoordinate = startPosition.y + 10;
  
  //Divider
  layoutYCoordinate = [UIHelper moveToYLocation:layoutYCoordinate
            reshapeWithSize:CGSizeMake(measurableInfoViewController.dividerButton.frame.size.width, measurableInfoViewController.dividerButton.frame.size.height)
                     orHide:NO
                       view:measurableInfoViewController.dividerButton
        withVerticalSpacing:VERTICAL_LAYOUT_PADDING];

  
  //Media View
  layoutYCoordinate = [UIHelper moveToYLocation:layoutYCoordinate
                                reshapeWithSize:CGSizeMake(MediaCollectionViewCellHeight, MediaCollectionViewCellHeight)
                                         orHide:(measurable.metadata.images.count == 0 && measurable.metadata.videos.count == 0)
                                           view:measurableInfoViewController.mediaView
                            withVerticalSpacing:VERTICAL_LAYOUT_PADDING];

  //Description View
  layoutYCoordinate = [UIHelper moveToYLocation:layoutYCoordinate
                                reshapeWithSize:CGSizeMake(measurableInfoViewController.descriptionTextView.frame.size.width, measurableInfoViewController.descriptionTextView.contentSize.height)
                                         orHide:(measurable.metadata.definition == nil)
                                           view:measurableInfoViewController.descriptionTextView
                            withVerticalSpacing:0];

  //Favorite Icon
  BOOL hide = YES;
  
  if([measurable.metadata.class isSubclassOfClass:ActivityMetadata.class]) {
    if(((ActivityMetadata*)(measurable.metadata)).favorite) {
      hide = NO;
    }
  }
  
  [UIHelper moveToYLocation:layoutYCoordinate
            reshapeWithSize:CGSizeMake(measurableInfoViewController.favoriteButton.frame.size.width, measurableInfoViewController.favoriteButton.frame.size.height)
                     orHide:hide
                       view:measurableInfoViewController.favoriteButton
        withVerticalSpacing:VERTICAL_LAYOUT_PADDING];
}

@end
