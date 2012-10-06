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
  
  if([BodyMetricIdentifierHeight isEqualToString: self.measurableIdentifier] ||
     [BodyMetricIdentifierChest isEqualToString: self.measurableIdentifier] ||
     [BodyMetricIdentifierBiceptsLeft isEqualToString: self.measurableIdentifier] ||
     [BodyMetricIdentifierBiceptsRight isEqualToString: self.measurableIdentifier] ||
     [BodyMetricIdentifierThighLeft isEqualToString: self.measurableIdentifier] ||
     [BodyMetricIdentifierThighRight isEqualToString: self.measurableIdentifier] ||
     [BodyMetricIdentifierCalfLeft isEqualToString: self.measurableIdentifier] ||
     [BodyMetricIdentifierCalfRight isEqualToString: self.measurableIdentifier]) {
    
    trendBetterDirection = MeasurableValueTrendBetterDirectionUp;
    
  } else if([BodyMetricIdentifierWeight isEqualToString: self.measurableIdentifier] ||
            [BodyMetricIdentifierWaist isEqualToString: self.measurableIdentifier] ||
            [BodyMetricIdentifierHip isEqualToString: self.measurableIdentifier] ||
            [BodyMetricIdentifierBodyMassIndex isEqualToString: self.measurableIdentifier] ||
            [BodyMetricIdentifierBodyFat isEqualToString: self.measurableIdentifier] ){
    
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
    
    if([BodyMetricIdentifierHeight isEqualToString: self.measurableIdentifier] ||
       [BodyMetricIdentifierChest isEqualToString: self.measurableIdentifier] ||
       [BodyMetricIdentifierWaist isEqualToString: self.measurableIdentifier] ||
       [BodyMetricIdentifierHip isEqualToString: self.measurableIdentifier] ||
       [BodyMetricIdentifierBiceptsLeft isEqualToString: self.measurableIdentifier] ||
       [BodyMetricIdentifierBiceptsRight isEqualToString: self.measurableIdentifier] ||
       [BodyMetricIdentifierThighLeft isEqualToString: self.measurableIdentifier] ||
       [BodyMetricIdentifierThighRight isEqualToString: self.measurableIdentifier] ||
       [BodyMetricIdentifierCalfLeft isEqualToString: self.measurableIdentifier] ||
       [BodyMetricIdentifierCalfRight isEqualToString: self.measurableIdentifier]) {
      
      unit = [Unit unitForUnitIdentifier:UnitIdentifierInch];
    } else if([BodyMetricIdentifierWeight isEqualToString: self.measurableIdentifier]) {
      
      unit = [Unit unitForUnitIdentifier:UnitIdentifierPound];
    } else if([BodyMetricIdentifierBodyMassIndex isEqualToString: self.measurableIdentifier]) {
      
      unit = [Unit unitForUnitIdentifier:UnitIdentifierNone];
    } else if([BodyMetricIdentifierBodyFat isEqualToString: self.measurableIdentifier]) {
      
      unit = [Unit unitForUnitIdentifier:UnitIdentifierPercent];
    }
    _unit = unit;
  }
  return _unit;
}


- (NSString *) name {
  
  if(!_name) {
  
    NSString* name = nil;
    
    if([BodyMetricIdentifierHeight isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"height-metric-label", @"Height");
    } else if([BodyMetricIdentifierWeight isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"weight-metric-label", @"Weight");
    } else if([BodyMetricIdentifierChest isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"chest-metric-label", @"Chest");
    } else if([BodyMetricIdentifierWaist isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"waist-metric-label", @"Waist");
    } else if([BodyMetricIdentifierHip isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"hip-metric-label", @"Hip");
    } else if([BodyMetricIdentifierBiceptsLeft isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"biceps-left-metric-label", @"Biceps - Left");
    } else if([BodyMetricIdentifierBiceptsRight isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"biceps-right-metric-label", @"Biceps - Right");
    } else if([BodyMetricIdentifierThighLeft isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"thigh-left-metric-label", @"Thigh - Left");
    } else if([BodyMetricIdentifierThighRight isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"thigh-right-metric-label", @"Thigh - Right");
    } else if([BodyMetricIdentifierCalfLeft isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"calf-left-metric-label", @"Calf - Left");
    } else if([BodyMetricIdentifierCalfRight isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"calf-right-metric-label", @"Calf - Right");
    } else if([BodyMetricIdentifierBodyMassIndex isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"body-mass-index-metric-label", @"Body Mass Index");
    } else if([BodyMetricIdentifierBodyFat isEqualToString: self.measurableIdentifier]) {
      name = NSLocalizedString(@"body-fat-metric-label", @"Body Fat");
    }
    _name = name;
  }
  
  return _name;
}

- (NSString *) description {
  
  if(!_description) {
    
    NSString* description = nil;
    
    if([BodyMetricIdentifierHeight isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"height-metric-description", @"");
    } else if([BodyMetricIdentifierWeight isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"weight-metric-description", @"");
    } else if([BodyMetricIdentifierChest isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"chest-metric-description", @"");
    } else if([BodyMetricIdentifierWaist isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"waist-metric-description", @"");
    } else if([BodyMetricIdentifierHip isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"hip-metric-description", @"");
    } else if([BodyMetricIdentifierBiceptsLeft isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"biceps-left-metric-description", @"");
    } else if([BodyMetricIdentifierBiceptsRight isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"biceps-right-metric-description", @"");
    } else if([BodyMetricIdentifierThighLeft isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"thigh-left-metric-description", @"");
    } else if([BodyMetricIdentifierThighRight isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"thigh-right-metric-description", @"");
    } else if([BodyMetricIdentifierCalfLeft isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"calf-left-metric-description", @"");
    } else if([BodyMetricIdentifierCalfRight isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"calf-right-metric-description", @"");
    } else if([BodyMetricIdentifierBodyMassIndex isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"body-mass-index-metric-description", @"");
    } else if([BodyMetricIdentifierBodyFat isEqualToString: self.measurableIdentifier]) {
      description = NSLocalizedString(@"body-fat-metric-description", @"");
    }
    _description = description;
  }
  
  return _description;
}

- (NSString *) metadataShort {
  
  if(!_metadataShort) {
    
    NSString* metadataShort = nil;
    
    if([BodyMetricIdentifierHeight isEqualToString: self.measurableIdentifier]) {
      metadataShort = nil;
    } else if([BodyMetricIdentifierWeight isEqualToString: self.measurableIdentifier]) {
      metadataShort = nil;
    } else if([BodyMetricIdentifierChest isEqualToString: self.measurableIdentifier]) {
      metadataShort = nil;
    } else if([BodyMetricIdentifierWaist isEqualToString: self.measurableIdentifier]) {
      metadataShort = nil;
    } else if([BodyMetricIdentifierHip isEqualToString: self.measurableIdentifier]) {
      metadataShort = nil;
    } else if([BodyMetricIdentifierBiceptsLeft isEqualToString: self.measurableIdentifier]) {
      metadataShort = @"Left";
    } else if([BodyMetricIdentifierBiceptsRight isEqualToString: self.measurableIdentifier]) {
      metadataShort = @"Right";
    } else if([BodyMetricIdentifierThighLeft isEqualToString: self.measurableIdentifier]) {
      metadataShort = @"Left";
    } else if([BodyMetricIdentifierThighRight isEqualToString: self.measurableIdentifier]) {
      metadataShort = @"Right";
    } else if([BodyMetricIdentifierCalfLeft isEqualToString: self.measurableIdentifier]) {
      metadataShort = @"Left";
    } else if([BodyMetricIdentifierCalfRight isEqualToString: self.measurableIdentifier]) {
      metadataShort = @"Right";
    } else if([BodyMetricIdentifierBodyMassIndex isEqualToString: self.measurableIdentifier]) {
      metadataShort = nil;
    } else if([BodyMetricIdentifierBodyFat isEqualToString: self.measurableIdentifier]) {
      metadataShort = nil;
    }
    _metadataShort = metadataShort;
  }
  
  return _metadataShort;
}

- (NSString *) metadataFull {
  
  if(!_metadataFull) {
    
    NSString* metadataFull = nil;
    
    if([BodyMetricIdentifierHeight isEqualToString: self.measurableIdentifier]) {
      metadataFull = nil;
    } else if([BodyMetricIdentifierWeight isEqualToString: self.measurableIdentifier]) {
      metadataFull = nil;
    } else if([BodyMetricIdentifierChest isEqualToString: self.measurableIdentifier]) {
      metadataFull = nil;
    } else if([BodyMetricIdentifierWaist isEqualToString: self.measurableIdentifier]) {
      metadataFull = nil;
    } else if([BodyMetricIdentifierHip isEqualToString: self.measurableIdentifier]) {
      metadataFull = nil;
    } else if([BodyMetricIdentifierBiceptsLeft isEqualToString: self.measurableIdentifier]) {
      metadataFull = @"Left";
    } else if([BodyMetricIdentifierBiceptsRight isEqualToString: self.measurableIdentifier]) {
      metadataFull = @"Right";
    } else if([BodyMetricIdentifierThighLeft isEqualToString: self.measurableIdentifier]) {
      metadataFull = @"Left";
    } else if([BodyMetricIdentifierThighRight isEqualToString: self.measurableIdentifier]) {
      metadataFull = @"Right";
    } else if([BodyMetricIdentifierCalfLeft isEqualToString: self.measurableIdentifier]) {
      metadataFull = @"Left";
    } else if([BodyMetricIdentifierCalfRight isEqualToString: self.measurableIdentifier]) {
      metadataFull = @"Right";
    } else if([BodyMetricIdentifierBodyMassIndex isEqualToString: self.measurableIdentifier]) {
      metadataFull = nil;
    } else if([BodyMetricIdentifierBodyFat isEqualToString: self.measurableIdentifier]) {
      metadataFull = nil;
    }
    _metadataFull = metadataFull;
  }
  
  return _metadataFull;
}


@end
