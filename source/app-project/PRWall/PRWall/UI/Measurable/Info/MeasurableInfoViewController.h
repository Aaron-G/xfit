//
//  MeasurableInfoViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/30/12.
//
//

#import <UIKit/UIKit.h>
#import "MeasurableLayoutViewController.h"
#import "MediaCollectionViewDelegate.h"

@interface MeasurableInfoViewController : MeasurableLayoutViewController <MediaCollectionViewDelegateMediaProvider>

@property IBOutlet UITextView* descriptionTextView;
@property IBOutlet UIButton* dividerButton;
@property IBOutlet UIButton* favoriteButton;
@property IBOutlet UICollectionView* mediaView;

- (void) share;

@end
