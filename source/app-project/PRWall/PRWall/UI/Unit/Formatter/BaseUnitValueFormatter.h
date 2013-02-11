//
//  BaseUnitValueFormatter.h
//  PR Wall
//
//  Created by Cleo Barretto on 2/9/13.
//
//

#import <Foundation/Foundation.h>
#import "UnitValueFormatter.h"
#import "Unit.h"

@interface BaseUnitValueFormatter : NSObject <UnitValueFormatter>

//Subclass
//Creates the Unit to be used by this UnitValueFormatter
- (Unit*) createUnit;

@end
