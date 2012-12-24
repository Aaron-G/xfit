//
//  UserProfile.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import "UserProfile.h"

@implementation UserProfile

@synthesize dateOfBirth = _dateOfBirth;
@synthesize age = _age;

-(void)setDateOfBirth:(NSDate *)dateOfBirth {
  
  _dateOfBirth = dateOfBirth;
  
  NSDateComponents *dataOfBirhtComponents =
  [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:dateOfBirth];
  
  NSDateComponents *nowComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
  
  _age = [NSString stringWithFormat:@"%d", nowComponents.year-dataOfBirhtComponents.year];
  
}

- (NSDate *)dateOfBirth {
  return _dateOfBirth;
}

@end
