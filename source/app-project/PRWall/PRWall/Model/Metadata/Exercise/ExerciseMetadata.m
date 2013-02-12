//
//  ExerciseMetadata.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import "ExerciseMetadata.h"
#import "Exercise.h"
#import "UIHelper.h"
#import "MeasurableHelper.h"
#import "ModelHelper.h"

@interface ExerciseMetadata () {
}

@property BOOL needUnitValueDescriptorsUpdate;

@end

@implementation ExerciseMetadata

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////

////////////////////////////////
//unitValueDescriptors
////////////////////////////////
@dynamic unitValueDescriptorsImpl;
@synthesize unitValueDescriptors = _unitValueDescriptors;
@synthesize needUnitValueDescriptorsUpdate;

- (NSArray *)unitValueDescriptors {
  [self willAccessValueForKey:@"unitValueDescriptors"];
  
  if(self.needUnitValueDescriptorsUpdate) {
    _unitValueDescriptors = [MeasurableHelper arrayUnsorted:self.unitValueDescriptorsImpl];
  }
  
  NSArray* tmpValue = _unitValueDescriptors;
  
  [self didAccessValueForKey:@"unitValueDescriptors"];
  return tmpValue;
}

/////////////////////////////////////////////////////////
//Computed Properties
/////////////////////////////////////////////////////////
- (NSString *) metadataShort {
  
  NSString* metadata = nil;
  
  NSMutableArray* arrayOfMetadata = [NSMutableArray array];
  metadata = [UIHelper stringForExerciseUnitValueDescriptors:self.unitValueDescriptors withSeparator: NSLocalizedString(@"minor-separator", @"・")];
  
  if(![UIHelper isEmptyString:metadata]) {
    [arrayOfMetadata addObject: metadata];
  }
  
  metadata = [MeasurableHelper tagsStringForMeasurableMetadata:self];
  
  if(![UIHelper isEmptyString:metadata]) {
    [arrayOfMetadata addObject: metadata];
  }
  
  return [arrayOfMetadata componentsJoinedByString: NSLocalizedString(@"major-separator", @"-")];
}

- (NSString *) metadataFull {
  
  NSString* metadata = self.metadataShort;
  
  NSMutableArray* arrayOfMetadata = [NSMutableArray array];
  
  if(![UIHelper isEmptyString:metadata]) {
    [arrayOfMetadata addObject: metadata];
  }
  
  metadata = self.type.name;
  
  if(![UIHelper isEmptyString:metadata]) {
    [arrayOfMetadata addObject: metadata];
  }
  
  return [arrayOfMetadata componentsJoinedByString: NSLocalizedString(@"major-separator", @"-")];
}

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////
- (void) addUnitValueDescriptor:(ExerciseUnitValueDescriptor*) unitValueDescriptor {
  unitValueDescriptor.metadata = self;
}

- (void) removeUnitValueDescriptor:(ExerciseUnitValueDescriptor*) unitValueDescriptor {
  if([unitValueDescriptor.metadata isEqual: self]) {
    unitValueDescriptor.metadata = nil;
    [ModelHelper deleteModelObject:unitValueDescriptor andSave:NO];
  }
}

- (MeasurableMetadata*) newInstance {
  return [ModelHelper newExerciseMetadata];
}

- (id)copyWithZone:(NSZone *)zone {
  
  ExerciseMetadata* metadata = (ExerciseMetadata*)[super copyWithZone:zone];
  
  if(metadata) {
    
    for (ExerciseUnitValueDescriptor* unitValueDescriptor in self.unitValueDescriptors) {
      [metadata addUnitValueDescriptor:[unitValueDescriptor copy]];
    }
  }
  
  return metadata;
}

/////////////////////////////////////////////////////////
//Core Data
/////////////////////////////////////////////////////////

- (void) setup {
  
  if(self.needSetup) {
    
    [super setup];
    
    [self addObserver:self forKeyPath:@"unitValueDescriptorsImpl" options: 0 context: NULL];
    self.needUnitValueDescriptorsUpdate = YES;    
  }
}

- (void) cleanup {
  
  if(self.needCleanup) {
    
    [super cleanup];
    
    //NSLog(@"ExerciseMetadata - cleanup - %@", [self.objectID URIRepresentation].absoluteString);
    [self removeObserver:self forKeyPath:@"unitValueDescriptorsImpl"];
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  
  [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  
  if([@"unitValueDescriptorsImpl" isEqualToString:keyPath]) {
    //NSLog(@"ExerciseMetadata - observeValueForKeyPath - unitValueDescriptorsImpl");
    
    self.needUnitValueDescriptorsUpdate = YES;
  }
}

@end