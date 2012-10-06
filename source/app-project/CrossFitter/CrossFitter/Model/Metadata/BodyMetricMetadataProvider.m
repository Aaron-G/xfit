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

- (id)initWithMeasurableIdentifier:(NSString*) measurableIdentifier {
  self = [super initWithMeasurableIdentifier: measurableIdentifier];
  
  if (self) {
    self.type = [MeasurableType measurableTypeWithMeasurableTypeIdentifier:MeasurableTypeIdentifierBodyMetric];
  }
  return self;
}

- (MeasurableValueTrendBetterDirection)valueTrendBetterDirection {
  
  if(!_valueTrendBetterDirection) {
    
  //Arbitrary default value
    MeasurableValueTrendBetterDirection trendBetterDirection = MeasurableValueTrendBetterDirectionUp;
  
  if([kBodyMetricIdentifierHeight isEqualToString: self.measurableIdentifier] ||
     [kBodyMetricIdentifierChest isEqualToString: self.measurableIdentifier] ||
     [kBodyMetricIdentifierBiceptsLeft isEqualToString: self.measurableIdentifier] ||
     [kBodyMetricIdentifierBiceptsRight isEqualToString: self.measurableIdentifier] ||
     [kBodyMetricIdentifierThighLeft isEqualToString: self.measurableIdentifier] ||
     [kBodyMetricIdentifierThighRight isEqualToString: self.measurableIdentifier] ||
     [kBodyMetricIdentifierCalfLeft isEqualToString: self.measurableIdentifier] ||
     [kBodyMetricIdentifierCalfRight isEqualToString: self.measurableIdentifier]) {
    
    trendBetterDirection = MeasurableValueTrendBetterDirectionUp;
    
  } else if([kBodyMetricIdentifierWeight isEqualToString: self.measurableIdentifier] ||
            [kBodyMetricIdentifierWaist isEqualToString: self.measurableIdentifier] ||
            [kBodyMetricIdentifierHip isEqualToString: self.measurableIdentifier] ||
            [kBodyMetricIdentifierBodyMassIndex isEqualToString: self.measurableIdentifier] ||
            [kBodyMetricIdentifierBodyFat isEqualToString: self.measurableIdentifier] ){
    
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
    
    if([kBodyMetricIdentifierHeight isEqualToString: self.measurableIdentifier] ||
       [kBodyMetricIdentifierChest isEqualToString: self.measurableIdentifier] ||
       [kBodyMetricIdentifierWaist isEqualToString: self.measurableIdentifier] ||
       [kBodyMetricIdentifierHip isEqualToString: self.measurableIdentifier] ||
       [kBodyMetricIdentifierBiceptsLeft isEqualToString: self.measurableIdentifier] ||
       [kBodyMetricIdentifierBiceptsRight isEqualToString: self.measurableIdentifier] ||
       [kBodyMetricIdentifierThighLeft isEqualToString: self.measurableIdentifier] ||
       [kBodyMetricIdentifierThighRight isEqualToString: self.measurableIdentifier] ||
       [kBodyMetricIdentifierCalfLeft isEqualToString: self.measurableIdentifier] ||
       [kBodyMetricIdentifierCalfRight isEqualToString: self.measurableIdentifier]) {
      
      unit = [Unit unitForUnitIdentifier:UnitIdentifierInch];
    } else if([kBodyMetricIdentifierWeight isEqualToString: self.measurableIdentifier]) {
      
      unit = [Unit unitForUnitIdentifier:UnitIdentifierPound];
    } else if([kBodyMetricIdentifierBodyMassIndex isEqualToString: self.measurableIdentifier]) {
      
      unit = [Unit unitForUnitIdentifier:UnitIdentifierNone];
    } else if([kBodyMetricIdentifierBodyFat isEqualToString: self.measurableIdentifier]) {
      
      unit = [Unit unitForUnitIdentifier:UnitIdentifierPercent];
    }
    _unit = unit;
  }
  return _unit;
}


- (NSString *) name {
  
  if(!_name) {
  
    NSString* name = nil;
    
    if([kBodyMetricIdentifierHeight isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"height-metric-label", @"Height");
    } else if([kBodyMetricIdentifierWeight isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"weight-metric-label", @"Weight");
    } else if([kBodyMetricIdentifierChest isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"chest-metric-label", @"Chest");
    } else if([kBodyMetricIdentifierWaist isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"waist-metric-label", @"Waist");
    } else if([kBodyMetricIdentifierHip isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"hip-metric-label", @"Hip");
    } else if([kBodyMetricIdentifierBiceptsLeft isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"biceps-left-metric-label", @"Biceps - Left");
    } else if([kBodyMetricIdentifierBiceptsRight isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"biceps-right-metric-label", @"Biceps - Right");
    } else if([kBodyMetricIdentifierThighLeft isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"thigh-left-metric-label", @"Thigh - Left");
    } else if([kBodyMetricIdentifierThighRight isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"thigh-right-metric-label", @"Thigh - Right");
    } else if([kBodyMetricIdentifierCalfLeft isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"calf-left-metric-label", @"Calf - Left");
    } else if([kBodyMetricIdentifierCalfRight isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"calf-right-metric-label", @"Calf - Right");
    } else if([kBodyMetricIdentifierBodyMassIndex isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"body-mass-index-metric-label", @"Body Mass Index");
    } else if([kBodyMetricIdentifierBodyFat isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"body-fat-metric-label", @"Body Fat");
    }
    _name = name;
  }
  
  return _name;
}

- (NSString *) description {
  
  if(!_description) {
    
    NSString* description = nil;
    
    if([kBodyMetricIdentifierHeight isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"height-metric-description", @"");
    } else if([kBodyMetricIdentifierWeight isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"weight-metric-description", @"");
    } else if([kBodyMetricIdentifierChest isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"chest-metric-description", @"");
    } else if([kBodyMetricIdentifierWaist isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"waist-metric-description", @"");
    } else if([kBodyMetricIdentifierHip isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"hip-metric-description", @"");
    } else if([kBodyMetricIdentifierBiceptsLeft isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"biceps-left-metric-description", @"");
    } else if([kBodyMetricIdentifierBiceptsRight isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"biceps-right-metric-description", @"");
    } else if([kBodyMetricIdentifierThighLeft isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"thigh-left-metric-description", @"");
    } else if([kBodyMetricIdentifierThighRight isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"thigh-right-metric-description", @"");
    } else if([kBodyMetricIdentifierCalfLeft isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"calf-left-metric-description", @"");
    } else if([kBodyMetricIdentifierCalfRight isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"calf-right-metric-description", @"");
    } else if([kBodyMetricIdentifierBodyMassIndex isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"body-mass-index-metric-description", @"");
    } else if([kBodyMetricIdentifierBodyFat isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"body-fat-metric-description", @"");
    }
    _description = description;
  }
  
  return _description;
}

- (NSString *) metadataShort {
  
  if(!_metadataShort) {
    
    NSString* metadataShort = nil;
    
    if([kBodyMetricIdentifierHeight isEqualToString: self.measurableIdentifier]) {
      metadataShort = nil;
    } else if([kBodyMetricIdentifierWeight isEqualToString: self.measurableIdentifier]) {
      metadataShort = nil;
    } else if([kBodyMetricIdentifierChest isEqualToString: self.measurableIdentifier]) {
      metadataShort = nil;
    } else if([kBodyMetricIdentifierWaist isEqualToString: self.measurableIdentifier]) {
      metadataShort = nil;
    } else if([kBodyMetricIdentifierHip isEqualToString: self.measurableIdentifier]) {
      metadataShort = nil;
    } else if([kBodyMetricIdentifierBiceptsLeft isEqualToString: self.measurableIdentifier]) {
      metadataShort = @"Left";
    } else if([kBodyMetricIdentifierBiceptsRight isEqualToString: self.measurableIdentifier]) {
      metadataShort = @"Right";
    } else if([kBodyMetricIdentifierThighLeft isEqualToString: self.measurableIdentifier]) {
      metadataShort = @"Left";
    } else if([kBodyMetricIdentifierThighRight isEqualToString: self.measurableIdentifier]) {
      metadataShort = @"Right";
    } else if([kBodyMetricIdentifierCalfLeft isEqualToString: self.measurableIdentifier]) {
      metadataShort = @"Left";
    } else if([kBodyMetricIdentifierCalfRight isEqualToString: self.measurableIdentifier]) {
      metadataShort = @"Right";
    } else if([kBodyMetricIdentifierBodyMassIndex isEqualToString: self.measurableIdentifier]) {
      metadataShort = nil;
    } else if([kBodyMetricIdentifierBodyFat isEqualToString: self.measurableIdentifier]) {
      metadataShort = nil;
    }
    _metadataShort = metadataShort;
  }
  
  return _metadataShort;
}

- (NSString *) metadataFull {
  
  if(!_metadataFull) {
    
    NSString* metadataFull = nil;
    
    if([kBodyMetricIdentifierHeight isEqualToString: self.measurableIdentifier]) {
      metadataFull = nil;
    } else if([kBodyMetricIdentifierWeight isEqualToString: self.measurableIdentifier]) {
      metadataFull = nil;
    } else if([kBodyMetricIdentifierChest isEqualToString: self.measurableIdentifier]) {
      metadataFull = nil;
    } else if([kBodyMetricIdentifierWaist isEqualToString: self.measurableIdentifier]) {
      metadataFull = nil;
    } else if([kBodyMetricIdentifierHip isEqualToString: self.measurableIdentifier]) {
      metadataFull = nil;
    } else if([kBodyMetricIdentifierBiceptsLeft isEqualToString: self.measurableIdentifier]) {
      metadataFull = @"Left";
    } else if([kBodyMetricIdentifierBiceptsRight isEqualToString: self.measurableIdentifier]) {
      metadataFull = @"Right";
    } else if([kBodyMetricIdentifierThighLeft isEqualToString: self.measurableIdentifier]) {
      metadataFull = @"Left";
    } else if([kBodyMetricIdentifierThighRight isEqualToString: self.measurableIdentifier]) {
      metadataFull = @"Right";
    } else if([kBodyMetricIdentifierCalfLeft isEqualToString: self.measurableIdentifier]) {
      metadataFull = @"Left";
    } else if([kBodyMetricIdentifierCalfRight isEqualToString: self.measurableIdentifier]) {
      metadataFull = @"Right";
    } else if([kBodyMetricIdentifierBodyMassIndex isEqualToString: self.measurableIdentifier]) {
      metadataFull = nil;
    } else if([kBodyMetricIdentifierBodyFat isEqualToString: self.measurableIdentifier]) {
      metadataFull = nil;
    }
    _metadataFull = metadataFull;
  }
  
  return _metadataFull;
}


@end
