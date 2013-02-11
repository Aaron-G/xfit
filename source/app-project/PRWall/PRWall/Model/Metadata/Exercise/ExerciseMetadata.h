//
//  ExerciseMetadata.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import "ActivityMetadata.h"
#import "ExerciseUnitValueDescriptor.h"

@class ExerciseUnitValueDescriptor;

@interface ExerciseMetadata : ActivityMetadata

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////
@property (readonly) NSArray * unitValueDescriptors;
@property (nonatomic, retain) NSSet * unitValueDescriptorsImpl;

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////
- (void) addUnitValueDescriptor:(ExerciseUnitValueDescriptor*) unitValueDescriptor;
- (void) removeUnitValueDescriptor:(ExerciseUnitValueDescriptor*) unitValueDescriptor;

@end
