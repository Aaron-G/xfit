//
//  UnitValueFormatter.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/21/12.
//
//

#import <Foundation/Foundation.h>

@class Unit;

@protocol UnitValueFormatter <NSObject>

@property Unit* unit;

//Formats the given *system value* into the appropriate
//string representation for this formatter.
- (NSString*) formatValue:(NSNumber*) value;

@end
