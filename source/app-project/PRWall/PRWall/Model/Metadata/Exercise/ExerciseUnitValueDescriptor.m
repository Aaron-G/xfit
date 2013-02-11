//
//  ExerciseUnitValueDescriptor.m
//  PR Wall
//
//  Created by Cleo Barretto on 2/8/13.
//
//

#import "ExerciseUnitValueDescriptor.h"
#import "ModelHelper.h"

@implementation ExerciseUnitValueDescriptor

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////

//Relationships
@dynamic metadata;
@dynamic unit;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////

////////////////////////////////
//value
////////////////////////////////
@dynamic valueImpl;

- (NSNumber *)value {
  [self willAccessValueForKey:@"value"];
  NSNumber *tmpValue = [self valueImpl];
  [self didAccessValueForKey:@"value"];
  return tmpValue;
}

- (void)setValue:(NSNumber *)value {
  NSDecimalNumber* tmpValue = [NSDecimalNumber decimalNumberWithDecimal:[value decimalValue]];
  [self willChangeValueForKey:@"value"];
  [self setValueImpl:tmpValue];
  [self didChangeValueForKey:@"value"];
}

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////

- (id)copyWithZone:(NSZone *)zone {
  
  ExerciseUnitValueDescriptor* unitValueDescriptor = [ModelHelper newExerciseUnitValueDescriptor];
  
  if(unitValueDescriptor) {
    
    unitValueDescriptor.value = self.value;
    unitValueDescriptor.unit = self.unit;
  }
  
  return unitValueDescriptor;
}

@end
