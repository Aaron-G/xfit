//
//  ModelFactory.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import <Foundation/Foundation.h>
#import "UserProfile.h"

@interface ModelFactory : NSObject

+ (UserProfile*) createDefaultUserProfile;
+ (NSDictionary*) createDefaultBodyMetrics;

@end
