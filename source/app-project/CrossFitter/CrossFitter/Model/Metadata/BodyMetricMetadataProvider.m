//
//  BodyMetricMetadataProvider.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import "BodyMetricMetadataProvider.h"
#import "BodyMetric.h"

@implementation BodyMetricMetadataProvider

@synthesize valueTrendBetterDirection = _valueTrendBetterDirection;
@synthesize unit = _unit;
@synthesize name = _name;
@synthesize description = _description;
@synthesize metadataShort = _metadataShort;
@synthesize metadataFull = _metadataFull;

- (id)initWithMeasurableIdentifier:(MeasurableIdentifier) identifier {
  self = [super initWithMeasurableIdentifier: identifier];
  
  if (self) {
    self.type = [MeasurableType measurableTypeWithMeasurableTypeIdentifier:MeasurableTypeIdentifierBodyMetric];
  }
  return self;
}

- (MeasurableValueTrendBetterDirection)valueTrendBetterDirection {
  
  if(!_valueTrendBetterDirection) {
    
  //Arbitrary default value
    MeasurableValueTrendBetterDirection trendBetterDirection = MeasurableValueTrendBetterDirectionUp;
  
  if([BodyMetricIdentifierHeight isEqualToString: self.identifier] ||
     [BodyMetricIdentifierChest isEqualToString: self.identifier] ||
     [BodyMetricIdentifierBiceptsLeft isEqualToString: self.identifier] ||
     [BodyMetricIdentifierBiceptsRight isEqualToString: self.identifier] ||
     [BodyMetricIdentifierThighLeft isEqualToString: self.identifier] ||
     [BodyMetricIdentifierThighRight isEqualToString: self.identifier] ||
     [BodyMetricIdentifierCalfLeft isEqualToString: self.identifier] ||
     [BodyMetricIdentifierCalfRight isEqualToString: self.identifier]) {
    
    trendBetterDirection = MeasurableValueTrendBetterDirectionUp;
    
  } else if([BodyMetricIdentifierWeight isEqualToString: self.identifier] ||
            [BodyMetricIdentifierWaist isEqualToString: self.identifier] ||
            [BodyMetricIdentifierHip isEqualToString: self.identifier] ||
            [BodyMetricIdentifierBodyMassIndex isEqualToString: self.identifier] ||
            [BodyMetricIdentifierBodyFat isEqualToString: self.identifier] ){
    
    trendBetterDirection = MeasurableValueTrendBetterDirectionDown;
    
  }
  
  _valueTrendBetterDirection = trendBetterDirection;
    
  }
  
  return _valueTrendBetterDirection;
}

- (Unit *)unit {

  //For now this is hardcoded. We need to provide
  //a settings screen
  if(!_unit) {
    
    Unit * unit = nil;
    
    if([BodyMetricIdentifierHeight isEqualToString: self.identifier] ||
       [BodyMetricIdentifierChest isEqualToString: self.identifier] ||
       [BodyMetricIdentifierWaist isEqualToString: self.identifier] ||
       [BodyMetricIdentifierHip isEqualToString: self.identifier] ||
       [BodyMetricIdentifierBiceptsLeft isEqualToString: self.identifier] ||
       [BodyMetricIdentifierBiceptsRight isEqualToString: self.identifier] ||
       [BodyMetricIdentifierThighLeft isEqualToString: self.identifier] ||
       [BodyMetricIdentifierThighRight isEqualToString: self.identifier] ||
       [BodyMetricIdentifierCalfLeft isEqualToString: self.identifier] ||
       [BodyMetricIdentifierCalfRight isEqualToString: self.identifier]) {
      
      unit = [Unit unitForUnitIdentifier:UnitIdentifierInch];
    } else if([BodyMetricIdentifierWeight isEqualToString: self.identifier]) {
      
      unit = [Unit unitForUnitIdentifier:UnitIdentifierPound];
    } else if([BodyMetricIdentifierBodyMassIndex isEqualToString: self.identifier]) {
      
      unit = [Unit unitForUnitIdentifier:UnitIdentifierNone];
    } else if([BodyMetricIdentifierBodyFat isEqualToString: self.identifier]) {
      
      unit = [Unit unitForUnitIdentifier:UnitIdentifierPercent];
    }
    _unit = unit;
  }
  return _unit;
}


- (NSString *) name {
  
  if(!_name) {
  
    NSString* name = nil;
    
    if([BodyMetricIdentifierHeight isEqualToString: self.identifier]) {
      name = NSLocalizedString(@"height-metric-label", @"Height");
    } else if([BodyMetricIdentifierWeight isEqualToString: self.identifier]) {
      name = NSLocalizedString(@"weight-metric-label", @"Weight");
    } else if([BodyMetricIdentifierChest isEqualToString: self.identifier]) {
      name = NSLocalizedString(@"chest-metric-label", @"Chest");
    } else if([BodyMetricIdentifierWaist isEqualToString: self.identifier]) {
      name = NSLocalizedString(@"waist-metric-label", @"Waist");
    } else if([BodyMetricIdentifierHip isEqualToString: self.identifier]) {
      name = NSLocalizedString(@"hip-metric-label", @"Hip");
    } else if([BodyMetricIdentifierBiceptsLeft isEqualToString: self.identifier]) {
      name = NSLocalizedString(@"biceps-left-metric-label", @"Biceps - Left");
    } else if([BodyMetricIdentifierBiceptsRight isEqualToString: self.identifier]) {
      name = NSLocalizedString(@"biceps-right-metric-label", @"Biceps - Right");
    } else if([BodyMetricIdentifierThighLeft isEqualToString: self.identifier]) {
      name = NSLocalizedString(@"thigh-left-metric-label", @"Thigh - Left");
    } else if([BodyMetricIdentifierThighRight isEqualToString: self.identifier]) {
      name = NSLocalizedString(@"thigh-right-metric-label", @"Thigh - Right");
    } else if([BodyMetricIdentifierCalfLeft isEqualToString: self.identifier]) {
      name = NSLocalizedString(@"calf-left-metric-label", @"Calf - Left");
    } else if([BodyMetricIdentifierCalfRight isEqualToString: self.identifier]) {
      name = NSLocalizedString(@"calf-right-metric-label", @"Calf - Right");
    } else if([BodyMetricIdentifierBodyMassIndex isEqualToString: self.identifier]) {
      name = NSLocalizedString(@"body-mass-index-metric-label", @"Body Mass Index");
    } else if([BodyMetricIdentifierBodyFat isEqualToString: self.identifier]) {
      name = NSLocalizedString(@"body-fat-metric-label", @"Body Fat");
    }
    _name = name;
  }
  
  return _name;
}

- (NSString *) description {
  
  if(!_description) {
    
    NSString* description = nil;
    
    if([BodyMetricIdentifierHeight isEqualToString: self.identifier]) {
      description = NSLocalizedString(@"height-metric-description", @"");
    } else if([BodyMetricIdentifierWeight isEqualToString: self.identifier]) {
      description = NSLocalizedString(@"weight-metric-description", @"");
    } else if([BodyMetricIdentifierChest isEqualToString: self.identifier]) {
      description = NSLocalizedString(@"chest-metric-description", @"");
    } else if([BodyMetricIdentifierWaist isEqualToString: self.identifier]) {
      description = NSLocalizedString(@"waist-metric-description", @"");
    } else if([BodyMetricIdentifierHip isEqualToString: self.identifier]) {
      description = NSLocalizedString(@"hip-metric-description", @"");
    } else if([BodyMetricIdentifierBiceptsLeft isEqualToString: self.identifier]) {
      description = NSLocalizedString(@"biceps-left-metric-description", @"");
    } else if([BodyMetricIdentifierBiceptsRight isEqualToString: self.identifier]) {
      description = NSLocalizedString(@"biceps-right-metric-description", @"");
    } else if([BodyMetricIdentifierThighLeft isEqualToString: self.identifier]) {
      description = NSLocalizedString(@"thigh-left-metric-description", @"");
    } else if([BodyMetricIdentifierThighRight isEqualToString: self.identifier]) {
      description = NSLocalizedString(@"thigh-right-metric-description", @"");
    } else if([BodyMetricIdentifierCalfLeft isEqualToString: self.identifier]) {
      description = NSLocalizedString(@"calf-left-metric-description", @"");
    } else if([BodyMetricIdentifierCalfRight isEqualToString: self.identifier]) {
      description = NSLocalizedString(@"calf-right-metric-description", @"");
    } else if([BodyMetricIdentifierBodyMassIndex isEqualToString: self.identifier]) {
      description = NSLocalizedString(@"body-mass-index-metric-description", @"");
    } else if([BodyMetricIdentifierBodyFat isEqualToString: self.identifier]) {
      description = NSLocalizedString(@"body-fat-metric-description", @"");
    }
    _description = description;
  }
  
  return _description;
}

- (NSString *) metadataShort {
  
  if(!_metadataShort) {
    
    NSString* metadataShort = nil;
    
    if([BodyMetricIdentifierHeight isEqualToString: self.identifier]) {
      metadataShort = nil;
    } else if([BodyMetricIdentifierWeight isEqualToString: self.identifier]) {
      metadataShort = nil;
    } else if([BodyMetricIdentifierChest isEqualToString: self.identifier]) {
      metadataShort = nil;
    } else if([BodyMetricIdentifierWaist isEqualToString: self.identifier]) {
      metadataShort = nil;
    } else if([BodyMetricIdentifierHip isEqualToString: self.identifier]) {
      metadataShort = nil;
    } else if([BodyMetricIdentifierBiceptsLeft isEqualToString: self.identifier]) {
      metadataShort = @"Left";
    } else if([BodyMetricIdentifierBiceptsRight isEqualToString: self.identifier]) {
      metadataShort = @"Right";
    } else if([BodyMetricIdentifierThighLeft isEqualToString: self.identifier]) {
      metadataShort = @"Left";
    } else if([BodyMetricIdentifierThighRight isEqualToString: self.identifier]) {
      metadataShort = @"Right";
    } else if([BodyMetricIdentifierCalfLeft isEqualToString: self.identifier]) {
      metadataShort = @"Left";
    } else if([BodyMetricIdentifierCalfRight isEqualToString: self.identifier]) {
      metadataShort = @"Right";
    } else if([BodyMetricIdentifierBodyMassIndex isEqualToString: self.identifier]) {
      metadataShort = nil;
    } else if([BodyMetricIdentifierBodyFat isEqualToString: self.identifier]) {
      metadataShort = nil;
    }
    _metadataShort = metadataShort;
  }
  
  return _metadataShort;
}

- (NSString *) metadataFull {
  
  if(!_metadataFull) {
    
    NSString* metadataFull = nil;
    
    if([BodyMetricIdentifierHeight isEqualToString: self.identifier]) {
      metadataFull = nil;
    } else if([BodyMetricIdentifierWeight isEqualToString: self.identifier]) {
      metadataFull = nil;
    } else if([BodyMetricIdentifierChest isEqualToString: self.identifier]) {
      metadataFull = nil;
    } else if([BodyMetricIdentifierWaist isEqualToString: self.identifier]) {
      metadataFull = nil;
    } else if([BodyMetricIdentifierHip isEqualToString: self.identifier]) {
      metadataFull = nil;
    } else if([BodyMetricIdentifierBiceptsLeft isEqualToString: self.identifier]) {
      metadataFull = @"Left";
    } else if([BodyMetricIdentifierBiceptsRight isEqualToString: self.identifier]) {
      metadataFull = @"Right";
    } else if([BodyMetricIdentifierThighLeft isEqualToString: self.identifier]) {
      metadataFull = @"Left";
    } else if([BodyMetricIdentifierThighRight isEqualToString: self.identifier]) {
      metadataFull = @"Right";
    } else if([BodyMetricIdentifierCalfLeft isEqualToString: self.identifier]) {
      metadataFull = @"Left";
    } else if([BodyMetricIdentifierCalfRight isEqualToString: self.identifier]) {
      metadataFull = @"Right";
    } else if([BodyMetricIdentifierBodyMassIndex isEqualToString: self.identifier]) {
      metadataFull = nil;
    } else if([BodyMetricIdentifierBodyFat isEqualToString: self.identifier]) {
      metadataFull = nil;
    }
    _metadataFull = metadataFull;
  }
  
  return _metadataFull;
}

- (BOOL)editable {
  return NO;
}

@end
