//
//  DefaultUnitValueFormatter.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/21/12.
//
//

#import <Foundation/Foundation.h>
#import "UnitValueFormatter.h"
#import "Unit.h"
#import "BaseUnitValueFormatter.h"

@interface DefaultUnitValueFormatter : BaseUnitValueFormatter

//The string suffix for values "lb, m, Kg...")
@property NSString* suffixString;

//The style to represent the value
@property NSNumberFormatterStyle numberStyle;

//The number formatter used to, well, format the value
@property NSNumberFormatter* numberFormatter;

@end
