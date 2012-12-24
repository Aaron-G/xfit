//
//  MeasurableLayoutViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/4/12.
//
//

#import <UIKit/UIKit.h>
#import "MeasurableViewLayoutDelegate.h"
#import "MeasurableProvider.h"

@interface MeasurableLayoutViewController : UIViewController <MeasurableProvider>

//Indicates to the support object that its associated view needs layout
@property BOOL needsLayout;

//Responsible for actual layout
@property (readonly) id<MeasurableViewLayoutDelegate> layoutDelegate;

//The location where it should start displaying its content
@property CGPoint layoutPosition;

//Updates the view layout if needed
- (void) layoutView;

//Force the view to layout
- (void) forceLayout;

//Reloads the view and trigger a view layout
- (void) reloadView;

@end
