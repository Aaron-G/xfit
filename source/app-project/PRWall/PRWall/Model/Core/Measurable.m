//
//  Measurable.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/9/12.
//
//

#import "Measurable.h"
#import "ModelHelper.h"

@implementation Measurable

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////

//Relationships
@dynamic metadata;
@dynamic data;
@dynamic userProfile;

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////

- (id)copyWithZone:(NSZone *)zone {

  //Create new measurable
  Measurable* measurable = [self newInstance];
  
  if(measurable) {
    measurable.userProfile = self.userProfile;
    measurable.metadata = [self.metadata copy];

    //Make this a user Measurable - only way this is called
    measurable.metadata.source = MeasurableSourceUser;
    measurable.metadata.copyable = YES;
  }
  return measurable;
}

- (Measurable *)newInstance {
  return nil;
}
@end
