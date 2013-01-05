//
//  MeasurableImpl.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"
#import "MeasurableDataProvider.h"
#import "MeasurableMetadataProvider.h"

@interface MeasurableImpl : NSObject <Measurable>

- (id)initWithIdentifier:(MeasurableIdentifier) identifier;

//Subclasses
- (MeasurableDataProvider*) createDataProviderWithIdentifier:(MeasurableIdentifier) identifier;
- (MeasurableMetadataProvider*) createMetadataProviderWithIdentifier:(MeasurableIdentifier) identifier;
+ (void) assignUserPriviligesToMeasurable:(id<Measurable>) measurable;

@end
