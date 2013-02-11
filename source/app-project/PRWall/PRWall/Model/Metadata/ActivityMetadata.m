//
//  ActivityMetadataProvider.m
//  PR Wall
//
//  Created by Cleo Barretto on 1/4/13.
//
//

#import "ActivityMetadataProvider.h"

@implementation ActivityMetadataProvider

- (void)copyToMeasurableMetadataProvider:(MeasurableMetadataProvider *)metadataProvider {
  
  [super copyToMeasurableMetadataProvider:metadataProvider];
  
  ActivityMetadataProvider* activitiyMetadataProvider = (ActivityMetadataProvider*)metadataProvider;
  
  activitiyMetadataProvider.prWall = self.prWall;
  activitiyMetadataProvider.favorite = self.favorite;
  activitiyMetadataProvider.tags = [self.tags copy];
}

@end
