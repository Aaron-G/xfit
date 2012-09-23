//
//  MeasurableImpl.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"
#import "MeasurableDataProvider.h"
#import "MeasurableMetadataProvider.h"

@interface MeasurableImpl : NSObject <Measurable>

- (id)initWithIdentifier:(NSString*) identifier;

//Subclasses
- (MeasurableDataProvider*) createDataProviderWithIdentifier:(NSString*) identifier;
- (MeasurableMetadataProvider*) createMetadataProviderWithIdentifier:(NSString*) identifier;

@end
