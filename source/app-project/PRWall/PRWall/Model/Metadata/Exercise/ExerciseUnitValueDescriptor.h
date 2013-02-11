//
//  ExerciseUnitValueDescriptor.h
//  PR Wall
//
//  Created by Cleo Barretto on 2/8/13.
//
//

#import <CoreData/CoreData.h>
#import "ExerciseMetadata.h"

@class ExerciseMetadata;

@interface ExerciseUnitValueDescriptor : NSManagedObject <NSCopying>

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////

//Relationships
@property (nonatomic, retain) ExerciseMetadata* metadata;
@property (nonatomic, retain) Unit* unit;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////
@property NSNumber * value;
@property (nonatomic, retain) NSDecimalNumber * valueImpl;

@end
