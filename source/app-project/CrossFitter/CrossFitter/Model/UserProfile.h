//
//  UserProfile.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import <Foundation/Foundation.h>

@interface UserProfile : NSObject

@property NSString* name;
@property NSDate* dateOfBirth;
@property NSString* box;
@property NSString* sex;
@property NSDictionary* metrics;

//This is computed
@property (readonly) NSString* age;

@end
