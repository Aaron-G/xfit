//
//  UnitValueFormatter.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/21/12.
//
//

#import <Foundation/Foundation.h>

@protocol UnitValueFormatter <NSObject>

- (NSString*) formatValue:(NSNumber*) value;

@end
