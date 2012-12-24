//
//  FootInchFormatter.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/21/12.
//
//

#import "DefaultUnitValueFormatter.h"

//Formatter that takes inches as the input and formats into a Feet and Inches.
//for example, 61" is equivalent to 5' 1" (5 feet 1 inch)
@interface FootInchFormatter : NSObject <UnitValueFormatter>

@end
