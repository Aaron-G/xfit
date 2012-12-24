//
//  MeasurableDataEntry.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/26/12.
//
//

#import "MeasurableDataEntry.h"

@implementation MeasurableDataEntry

@synthesize identifier;
@synthesize value;
@synthesize date;
@synthesize comment;

@synthesize images;
@synthesize videos;

- (BOOL)hasAdditionalInfo {
  return (comment.length || images.count > 0 || videos.count > 0);
}

@end
