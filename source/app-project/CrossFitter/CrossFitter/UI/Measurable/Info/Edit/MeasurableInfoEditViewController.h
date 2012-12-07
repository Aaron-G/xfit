//
//  MeasurableInfoEditViewController.h
//  CrossFitter
//
//  Created by Cleo Barretto on 12/1/12.
//
//

#import <UIKit/UIKit.h>
#import "MeasurableInfoEditViewControllerDelegate.h"
#import "BetterDirectionTableViewCell.h"
#import "MassUnitTableViewCell.h"
#import "LengthUnitTableViewCell.h"
#import "MeasurableLayoutViewController.h"


@interface MeasurableInfoEditViewController : MeasurableLayoutViewController <UITableViewDataSource, UITableViewDelegate>

@property id<MeasurableInfoEditViewControllerDelegate> delegate;

//Subclasses properties
@property BetterDirectionTableViewCell* betterDirectionCell;
@property MassUnitTableViewCell* massUnitCell;
@property LengthUnitTableViewCell* lengthUnitCell;

//Outlets
@property IBOutlet UITableView* tableView;

//Actions
- (IBAction) changeMassUnit:(id)sender;
- (IBAction) changeLengthUnit:(id)sender;
- (IBAction) changeBetterDirection:(id)sender;

//Subclasses methods
- (void) createBetterDirectionCell;
- (void) createMassUnitCell;
- (void) createLengthUnitCell;

- (NSInteger) segmentedControlIndexForBetterDirection:(MeasurableValueTrendBetterDirection) betterDirection;
- (NSInteger) segmentedControlIndexForLengthUnit:(Unit*) unit;
- (NSInteger) segmentedControlIndexForMassUnit:(Unit*) unit;

- (UnitIdentifier) lengthUnitForSegmentedControlIndex:(NSInteger) index;
- (MeasurableValueTrendBetterDirection) betterDirectionForSegmentedControlIndex:(NSInteger) index;
- (UnitIdentifier) massUnitForSegmentedControlIndex:(NSInteger) index;

@end
