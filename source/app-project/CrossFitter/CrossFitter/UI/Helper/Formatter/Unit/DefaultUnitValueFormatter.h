//
//  DefaultUnitValueFormatter.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/21/12.
//
//

#import <Foundation/Foundation.h>
#import "UnitValueFormatter.h"
#import "Unit.h"

@interface DefaultUnitValueFormatter : NSObject <UnitValueFormatter> 

//The string suffix for values "lb, m, Kg...")
@property NSString* suffixString;

//The style to represent the value
@property NSNumberFormatterStyle numberStyle;

//The number formatter used to, well, format the value
@property NSNumberFormatter* numberFormatter;

@end
