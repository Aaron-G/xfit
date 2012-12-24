//
//  DefaultUnitSystemConverter.h
//  PR Wall
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import <Foundation/Foundation.h>
#import "UnitSystemConverter.h"

@interface DefaultUnitSystemConverter : NSObject <UnitSystemConverter>

@property CGFloat convertionFactor;

@end
