//
//  UnitSystemConverter.h
//  CrossFitter
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import <Foundation/Foundation.h>

@class Unit;

@protocol UnitSystemConverter <NSObject>

//Converts the given value to the system unit
- (NSNumber*) convertToSystemValue:(NSNumber*) value;

//Converts the given value from the system unit
- (NSNumber*) convertFromSystemValue:(NSNumber*) value;

@end

