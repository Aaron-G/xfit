//
//  MeasurableImpl.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import "MeasurableImpl.h"
#import "DefaultUnitValueFormatter.h"

@implementation MeasurableImpl

@synthesize metadataProvider;
@synthesize dataProvider;
@synthesize valueFormatter = _valueFormatter;

//Designated initializer
- (id)initWithIdentifier:(MeasurableIdentifier) identifier {
  self = [super init];
  
  if (self) {
    
    if(identifier) {
      self.metadataProvider = [self createMetadataProviderWithIdentifier:identifier];
      self.dataProvider = [self createDataProviderWithIdentifier:identifier];
      self.valueFormatter = [[DefaultUnitValueFormatter alloc] init];
    } else {
      self = nil;
    }
  }
  return self;
}


- (MeasurableDataProvider*) createDataProviderWithIdentifier:(MeasurableIdentifier) identifier {
  return [[MeasurableDataProvider alloc] init];
}
- (MeasurableMetadataProvider*) createMetadataProviderWithIdentifier:(MeasurableIdentifier) identifier {
  return [[MeasurableMetadataProvider alloc] initWithMeasurableIdentifier:identifier];
}

@end
