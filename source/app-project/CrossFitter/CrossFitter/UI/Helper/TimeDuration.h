//
//  TimeDuration.h
//  CrossFitter
//
//  Created by Cleo Barretto on 11/30/12.
//
//

#import <Foundation/Foundation.h>

@interface TimeDuration : NSObject

//The time duration in seconds
@property NSInteger value;

@property (readonly) NSInteger hours;
@property (readonly) NSInteger minutes;
@property (readonly) NSInteger seconds;

@end
