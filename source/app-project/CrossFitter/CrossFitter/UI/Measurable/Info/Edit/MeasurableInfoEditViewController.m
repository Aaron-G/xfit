//
//  MeasurableInfoEditViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 12/1/12.
//
//

#import "MeasurableInfoEditViewController.h"
#import "UIHelper.h"
#import "MeasurableHelper.h"

@interface MeasurableInfoEditViewController ()

@end

@implementation MeasurableInfoEditViewController

@synthesize measurable = _measurable;

- (void)loadView {

  [super loadView];
  
  //Register custom table view cells
  [self.tableView registerNib: [UINib nibWithNibName:@"BetterDirectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"BetterDirectionTableViewCell"];
  [self.tableView registerNib: [UINib nibWithNibName:@"MassUnitTableViewCell" bundle:nil] forCellReuseIdentifier:@"MassUnitTableViewCell"];
  [self.tableView registerNib: [UINib nibWithNibName:@"LengthUnitTableViewCell" bundle:nil] forCellReuseIdentifier:@"LengthUnitTableViewCell"];
  
}

- (void)viewWillAppear:(BOOL)animated {
  [self updateView];
  
  [super viewWillAppear:animated];
}

- (void) reloadView {
  
  [self forceUpdateView];
}

- (void) forceUpdateView {
  
  self.requiresViewUpdate = YES;
  [self updateView];
  
}

- (void)setMeasurable:(id<Measurable>)measurable {
  _measurable = measurable;
  
  [self reloadView];
}

- (id<Measurable>)measurable {
  return _measurable;
}

- (void) updateView {
  
  if(self.requiresViewUpdate) {
    
    //Update the view
    id<MeasurableViewUpdateDelegate> updateDelegate = [MeasurableHelper measurableInfoEditViewUpdateDelegateForMeasurable:self.measurable];
    [updateDelegate updateViewInViewController:self withMeasurable: self.measurable withLayoutPosition: self.viewLayoutPosition];
  }
}

- (void) createBetterDirectionCell {

  self.betterDirectionCell = [self.tableView dequeueReusableCellWithIdentifier:@"BetterDirectionTableViewCell"];

  [self.betterDirectionCell.betterDirectionSegmentedControl setTitle:NSLocalizedString(@"better-direction-more-label", @"more") forSegmentAtIndex:0];
  [self.betterDirectionCell.betterDirectionSegmentedControl setTitle:NSLocalizedString(@"better-direction-less-label", @"less") forSegmentAtIndex:1];
  [self.betterDirectionCell.betterDirectionSegmentedControl setTitle:NSLocalizedString(@"better-direction-none-label", @"none") forSegmentAtIndex:2];

  [UIHelper applyFontToSegmentedControl:self.betterDirectionCell.betterDirectionSegmentedControl];

  [self.betterDirectionCell.betterDirectionSegmentedControl addTarget:self
                                                               action:@selector(changeBetterDirection:)
                                                     forControlEvents:UIControlEventValueChanged];
}

- (void) createMassUnitCell {

  self.massUnitCell = [self.tableView dequeueReusableCellWithIdentifier:@"MassUnitTableViewCell"];

  [self.massUnitCell.massUnitSegmentedControl setTitle:NSLocalizedString(@"kilogram-suffix", @"kg") forSegmentAtIndex:0];
  [self.massUnitCell.massUnitSegmentedControl setTitle:NSLocalizedString(@"pound-suffix", @"lb") forSegmentAtIndex:1];
  [self.massUnitCell.massUnitSegmentedControl setTitle:NSLocalizedString(@"pood-suffix", @"pu") forSegmentAtIndex:2];

  [UIHelper applyFontToSegmentedControl:self.massUnitCell.massUnitSegmentedControl];

  [self.massUnitCell.massUnitSegmentedControl addTarget:self
                                                 action:@selector(changeMassUnit:)
                                       forControlEvents:UIControlEventValueChanged];
}

- (void) createLengthUnitCell {

  self.lengthUnitCell = [self.tableView dequeueReusableCellWithIdentifier:@"LengthUnitTableViewCell"];

  [self.lengthUnitCell.lengthUnitSegmentedControl setTitle:NSLocalizedString(@"meter-suffix", @"m") forSegmentAtIndex:0];
  [self.lengthUnitCell.lengthUnitSegmentedControl setTitle:NSLocalizedString(@"kilometer-suffix", @"km") forSegmentAtIndex:1];
  [self.lengthUnitCell.lengthUnitSegmentedControl setTitle:NSLocalizedString(@"inch-suffix-word", @"in") forSegmentAtIndex:2];
  [self.lengthUnitCell.lengthUnitSegmentedControl setTitle:NSLocalizedString(@"foot-suffix-word", @"ft") forSegmentAtIndex:3];
  [self.lengthUnitCell.lengthUnitSegmentedControl setTitle:NSLocalizedString(@"yard-suffix", @"yd") forSegmentAtIndex:4];
  [self.lengthUnitCell.lengthUnitSegmentedControl setTitle:NSLocalizedString(@"mile-suffix", @"mi") forSegmentAtIndex:5];

  [UIHelper applyFontToSegmentedControl:self.lengthUnitCell.lengthUnitSegmentedControl];

  [self.lengthUnitCell.lengthUnitSegmentedControl addTarget:self
                                                 action:@selector(changeLengthUnit:)
                                       forControlEvents:UIControlEventValueChanged];
}

- (NSInteger) segmentedControlIndexForBetterDirection:(MeasurableValueTrendBetterDirection) betterDirection {
  
  NSInteger index = -1;
  
  if(betterDirection == MeasurableValueTrendBetterDirectionUp) {
    index = 0;
  } else if(betterDirection == MeasurableValueTrendBetterDirectionDown) {
    index = 1;
  } else if(betterDirection == MeasurableValueTrendBetterDirectionNone) {
    index = 2;
  }
  
  assert(index != -1);
  return index;
}

- (NSInteger) segmentedControlIndexForLengthUnit:(Unit*) unit {
  
  NSInteger index = -1;
  
  if(unit.identifier == UnitIdentifierMeter) {
    index = 0;
  } else if(unit.identifier == UnitIdentifierKilometer) {
    index = 1;
  } else if(unit.identifier == UnitIdentifierInch) {
    index = 2;
  } else if(unit.identifier == UnitIdentifierFoot) {
    index = 3;
  } else if(unit.identifier == UnitIdentifierYard) {
    index = 4;
  } else if(unit.identifier == UnitIdentifierMile) {
    index = 5;
  }
  
  assert(index != -1);
  return index;
}

- (UnitIdentifier) lengthUnitForSegmentedControlIndex:(NSInteger) index {
  
  UnitIdentifier unitIdentifier = -1;
  
  if(index == 0) {
    unitIdentifier = UnitIdentifierMeter;
  } else if(index == 1) {
    unitIdentifier = UnitIdentifierKilometer;
  } else if(index == 2) {
    unitIdentifier = UnitIdentifierInch;
  } else if(index == 3) {
    unitIdentifier = UnitIdentifierFoot;
  } else if(index == 4) {
    unitIdentifier = UnitIdentifierYard;
  } else if(index == 5) {
    unitIdentifier = UnitIdentifierMile;
  }
  
  assert(unitIdentifier != -1);
  return unitIdentifier;
}

- (NSInteger) segmentedControlIndexForMassUnit:(Unit*) unit {
  
  NSInteger index = -1;
  
  if(unit.identifier == UnitIdentifierKilogram) {
    index = 0;
  } else if(unit.identifier == UnitIdentifierPound) {
    index = 1;
  } else if(unit.identifier == UnitIdentifierPood) {
    index = 2;
  }
  
  assert(index != -1);
  return index;
}

- (MeasurableValueTrendBetterDirection) betterDirectionForSegmentedControlIndex:(NSInteger) index {
  
  MeasurableValueTrendBetterDirection betterDirection = -1;
  
  if(index == 0) {
    betterDirection = MeasurableValueTrendBetterDirectionUp;
  } else if(index == 1) {
    betterDirection = MeasurableValueTrendBetterDirectionDown;
  } else if(index == 2) {
    betterDirection = MeasurableValueTrendBetterDirectionNone;
  }
  
  assert(betterDirection != -1);
  return betterDirection;
}

- (UnitIdentifier) massUnitForSegmentedControlIndex:(NSInteger) index {
  
  UnitIdentifier unitIdentifier = -1;
  
  if(index == 0) {
    unitIdentifier = UnitIdentifierKilogram;
  } else if(index == 1) {
    unitIdentifier = UnitIdentifierPound;
  } else if(index == 2) {
    unitIdentifier = UnitIdentifierPood;
  }
  
  assert(unitIdentifier != -1);
  return unitIdentifier;
}

- (void) updateUnitWithUnitIndentifier:(UnitIdentifier) unitIdentifier {
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    //1- Update the unit itself
    self.measurable.metadataProvider.unit = [Unit unitForUnitIdentifier:unitIdentifier];
    
    /////////////////////////////////////////////////////////////////
    //CXB_TEMP_HACK - This force the recomputation of trends
    //This will be replaced with the model update API
    self.measurable.dataProvider.values = self.measurable.dataProvider.values;
    /////////////////////////////////////////////////////////////////
    
    //2- Let the edit delegate know that things changed
    [self.delegate didEditMeasurableInfoForMeasurable:self.measurable];
  });
}

- (IBAction) changeMassUnit:(id)sender {
  [self updateUnitWithUnitIndentifier:[self massUnitForSegmentedControlIndex: ((UISegmentedControl*)sender).selectedSegmentIndex]];
}

- (IBAction) changeLengthUnit:(id)sender {
  [self updateUnitWithUnitIndentifier:[self lengthUnitForSegmentedControlIndex: ((UISegmentedControl*)sender).selectedSegmentIndex]];
}

- (IBAction) changeBetterDirection:(id)sender {
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    //1- Update the better direction
    self.measurable.metadataProvider.valueTrendBetterDirection = [self betterDirectionForSegmentedControlIndex:((UISegmentedControl*)sender).selectedSegmentIndex];
    
    /////////////////////////////////////////////////////////////////
    //CXB_TEMP_HACK - This force the recomputation of trends
    //This will be replaced with the model update API
    self.measurable.dataProvider.values = self.measurable.dataProvider.values;
    /////////////////////////////////////////////////////////////////
    
    //2- Let the edit delegate know that things changed
    [self.delegate didEditMeasurableInfoForMeasurable:self.measurable];
  });

}

@end
