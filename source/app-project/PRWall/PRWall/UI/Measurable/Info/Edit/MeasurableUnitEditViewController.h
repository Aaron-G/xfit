//
//  MeasurableUnitEditViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/28/12.
//
//

#import <UIKit/UIKit.h>
#import "Unit.h"

@protocol MeasurableUnitEditViewControllerDelegate <NSObject>

- (void) didChangeUnit:(Unit*) unit;

@end

@interface MeasurableUnitEditViewController : UITableViewController

@property id<MeasurableUnitEditViewControllerDelegate> delegate;

- (void) editUnit:(Unit*) unit;

@end
