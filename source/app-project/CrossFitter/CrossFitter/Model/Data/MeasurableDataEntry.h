//
//  MeasurableDataEntry.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/26/12.
//
//

#import <Foundation/Foundation.h>

@interface MeasurableDataEntry : NSObject

//Data Provider Properties
@property NSString* identifier;
@property NSNumber* value;
@property NSDate* date;
@property NSString* comment;

@property NSArray* images;
@property NSArray* videos;


@end
