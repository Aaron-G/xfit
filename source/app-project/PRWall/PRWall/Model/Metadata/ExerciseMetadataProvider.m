//
//  ExerciseMetadataProvider.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import "ExerciseMetadataProvider.h"
#import "Exercise.h"
#import "ExerciseMoreInfo.h"
#import "UIHelper.h"

@implementation ExerciseMetadataProvider

@synthesize valueGoal = _valueGoal;
@synthesize unit = _unit;
@synthesize name = _name;
@synthesize description = _description;
@synthesize valueType = _valueType;
@synthesize kind = _kind;
@synthesize moreInfo = _moreInfo;
@synthesize tags = _tags;
@synthesize favorite = _favorite;

- (id)initWithMeasurableIdentifier:(MeasurableIdentifier) identifier {
  self = [super initWithMeasurableIdentifier: identifier];
  
  if (self) {
    self.type = [MeasurableType measurableTypeWithMeasurableTypeIdentifier:MeasurableTypeIdentifierExercise];
    self.valueGoal = -1;
    self.valueType = -1;
    
    
    if([@"run-200" isEqualToString: self.identifier] || [@"deadlift-max" isEqualToString: self.identifier] || [@"burpee-amrap" isEqualToString: self.identifier]) {
      self.favorite = YES;
    }
  }
  return self;
}

- (void)copyToMeasurableMetadataProvider:(MeasurableMetadataProvider*)metadataProvider {

  [super copyToMeasurableMetadataProvider:metadataProvider];
  
  ExerciseMetadataProvider* exerciseMetadataProvider = (ExerciseMetadataProvider*)metadataProvider;
  
  exerciseMetadataProvider.kind = self.kind;
}

- (MeasurableValueGoal)valueGoal {
  
  if(_valueGoal == -1) {
    
    //Arbitrary default value
    MeasurableValueGoal valueGoal = MeasurableValueGoalMore;
    
    if([@"deadlift-max" isEqualToString: self.identifier] ||
       [@"pullup-unbroken" isEqualToString: self.identifier] ||
       [@"double-under-unbroken" isEqualToString: self.identifier] ||
       [@"burpee-amrap" isEqualToString: self.identifier] ||
       [@"thruster-heavy" isEqualToString: self.identifier]) {
      
      valueGoal = MeasurableValueGoalMore;
      
    } else if([@"run-200" isEqualToString: self.identifier] ||
              [@"row-2000" isEqualToString: self.identifier]){
      
      valueGoal = MeasurableValueGoalLess;
      
    }
    
    _valueGoal = valueGoal;
    
  }
  
  return _valueGoal;
}

- (void)setValueGoal:(MeasurableValueGoal)valueGoal {
  _valueGoal = valueGoal;
}

- (Unit *)unit {
  
  if(!_unit) {
    
    Unit * unit = nil;
    
    if([@"run-200" isEqualToString: self.identifier] ||
       [@"row-2000" isEqualToString: self.identifier]) {
      unit = [Unit unitForUnitIdentifier:UnitIdentifierSecond];
      
    } else if([@"deadlift-max" isEqualToString: self.identifier] ||
              [@"thruster-heavy" isEqualToString: self.identifier]) {
      unit = [Unit unitForUnitIdentifier:UnitIdentifierPound];
      
    } else if([@"pullup-unbroken" isEqualToString: self.identifier] ||
              [@"double-under-unbroken" isEqualToString: self.identifier] ||
              [@"burpee-amrap" isEqualToString: self.identifier]) {
      unit = [Unit unitForUnitIdentifier:UnitIdentifierNone];
      
    }
    _unit = unit;
  }
  return _unit;
}

- (void)setUnit:(Unit *)unit {
  _unit = unit;
}

- (NSString *) name {
  
  if(!_name) {
    
    NSString* name = nil;
    
    if([@"run-200" isEqualToString: self.identifier]) {
      name = @"Run";
    } else if([@"row-2000" isEqualToString: self.identifier]) {
      name = @"Row";
    } else if([@"deadlift-max" isEqualToString: self.identifier]) {
      name = @"Deadlift";
    } else if([@"thruster-heavy" isEqualToString: self.identifier]) {
      name = @"Thruster";
    } else if([@"pullup-unbroken" isEqualToString: self.identifier]) {
      name = @"Pullup";
    } else if([@"double-under-unbroken" isEqualToString: self.identifier]) {
      name = @"Double Under";
    } else if([@"burpee-amrap" isEqualToString: self.identifier]) {
      name = @"Burpee";
    } 
    _name = name;
  }
  
  return _name;
}

- (NSString *) description {
  
  if(!_description) {
    
    NSString* description = nil;
    
    if([@"run-200" isEqualToString: self.identifier]) {
      description = @"Move at a speed faster than a walk, never having both or all the feet on the ground at the same time.";
    } else if([@"row-2000" isEqualToString: self.identifier]) {
      description = @"Rowing is an exercise whose purpose is to strengthen the muscles that draw the rower's arms toward the body.";
    } else if([@"deadlift-max" isEqualToString: self.identifier]) {
      description = @"The deadlift is an exercise where a loaded barbell is lifted off the ground bent over position.";
    } else if([@"thruster-heavy" isEqualToString: self.identifier]) {
      description = @"One of CrossFit’s most deceptively tiring movements, a thruster is a front squat straight into a push press.";
    } else if([@"pullup-unbroken" isEqualToString: self.identifier]) {
      description = @"A pull-up is an exercise where the body is suspended by extended arms, gripping a fixed bar, then pulled up.";
    } else if([@"double-under-unbroken" isEqualToString: self.identifier]) {
      description = @"A double under is when a jump rope passes under an athlete’s feet twice with only one jump.";
    } else if([@"burpee-amrap" isEqualToString: self.identifier]) {
      description = @"Start standing, bend down, plant your hands, kick back into a plank position, do a push-up and jump up again.";
    }

    _description = description;
  }
  
  return _description;
}

- (NSString *) metadataShort {
  
  NSString* metadata = nil;
  
  NSMutableArray* arrayOfMetadata = [NSMutableArray array];
  metadata = [UIHelper stringForExerciseMoreInfos:self.moreInfo withSeparator:NSLocalizedString(@"minor-separator", @"・")];
  
  if(![UIHelper isEmptyString:metadata]) {
    [arrayOfMetadata addObject: metadata];
  }
  
  metadata = [self.tags componentsJoinedByString:NSLocalizedString(@"minor-separator", @"・")];
  
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
  
  metadata = self.kind.name;
  
  if(![UIHelper isEmptyString:metadata]) {
    [arrayOfMetadata addObject: metadata];
  }
  
  return [arrayOfMetadata componentsJoinedByString: NSLocalizedString(@"major-separator", @"-")];
}

- (MeasurableValueType)valueType {
  
  if(_valueType == -1) {
    
    MeasurableValueType valueType = -1;
    
    if([@"run-200" isEqualToString: self.identifier]) {
      valueType = MeasurableValueTypeTime;
    } else if([@"row-2000" isEqualToString: self.identifier]) {
      valueType = MeasurableValueTypeTime;
    } else if([@"deadlift-max" isEqualToString: self.identifier]) {
      valueType = MeasurableValueTypeNumberWithDecimal;
    } else if([@"thruster-heavy" isEqualToString: self.identifier]) {
      valueType = MeasurableValueTypeNumberWithDecimal;
    } else if([@"pullup-unbroken" isEqualToString: self.identifier]) {
      valueType = MeasurableValueTypeNumber;
    } else if([@"double-under-unbroken" isEqualToString: self.identifier]) {
      valueType = MeasurableValueTypeNumber;
    } else if([@"burpee-amrap" isEqualToString: self.identifier]) {
      valueType = MeasurableValueTypeNumber;
    } else {
      valueType = MeasurableValueTypeNumber;
    }
    
    //This should never happen
    assert(valueType != -1);
    
    _valueType = valueType;
  }
  
  return _valueType;
}

- (BOOL)editable {
  return YES;
}

- (BOOL)copyable {
  return YES;
}

- (ExerciseKind *)kind {

  if(!_kind) {
    
    ExerciseKind* kind = nil;
    
    if([@"run-200" isEqualToString: self.identifier]) {
      kind = [ExerciseKind exerciseKindForIdentifier:ExerciseKindIdentifierMotion];
    } else if([@"row-2000" isEqualToString: self.identifier]) {
      kind = [ExerciseKind exerciseKindForIdentifier:ExerciseKindIdentifierRow];
    } else if([@"deadlift-max" isEqualToString: self.identifier]) {
      kind = [ExerciseKind exerciseKindForIdentifier:ExerciseKindIdentifierLift];
    } else if([@"thruster-heavy" isEqualToString: self.identifier]) {
      kind = [ExerciseKind exerciseKindForIdentifier:ExerciseKindIdentifierLift];
    } else if([@"pullup-unbroken" isEqualToString: self.identifier]) {
      kind = [ExerciseKind exerciseKindForIdentifier:ExerciseKindIdentifierBar];
    } else if([@"double-under-unbroken" isEqualToString: self.identifier]) {
      kind = [ExerciseKind exerciseKindForIdentifier:ExerciseKindIdentifierRope];
    } else if([@"burpee-amrap" isEqualToString: self.identifier]) {
      kind = [ExerciseKind exerciseKindForIdentifier:ExerciseKindIdentifierBody];
    }

    _kind = kind;
  }
  return _kind;
}

- (void)setKind:(ExerciseKind *)kind {
  _kind = kind;
}

- (void)setMoreInfo:(NSDictionary *)moreInfo {
  _moreInfo = moreInfo;
}

- (NSDictionary *)moreInfo {
  
  if(!_moreInfo) {
    
    NSMutableDictionary* moreInfo = [NSMutableDictionary dictionary];
    
    if([@"run-200" isEqualToString: self.identifier]) {
      ExerciseMoreInfo* exerciseMoreInfo = [[ExerciseMoreInfo alloc]initWithIdentifier:ExerciseMoreInfoLength];
      exerciseMoreInfo.unit = [Unit unitForUnitIdentifier:UnitIdentifierMeter];
      exerciseMoreInfo.value = [exerciseMoreInfo.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithInt:200]];
      [moreInfo setObject:exerciseMoreInfo forKey:exerciseMoreInfo.identifier];
      
    } else if([@"row-2000" isEqualToString: self.identifier]) {
      ExerciseMoreInfo* exerciseMoreInfo = [[ExerciseMoreInfo alloc]initWithIdentifier:ExerciseMoreInfoLength];
      exerciseMoreInfo.unit = [Unit unitForUnitIdentifier:UnitIdentifierMeter];
      exerciseMoreInfo.value = [exerciseMoreInfo.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithInt:2000]];
      [moreInfo setObject:exerciseMoreInfo forKey:exerciseMoreInfo.identifier];
    } else if([@"burpee-amrap" isEqualToString: self.identifier]) {
      ExerciseMoreInfo* exerciseMoreInfo = [[ExerciseMoreInfo alloc]initWithIdentifier:ExerciseMoreInfoTime];
      exerciseMoreInfo.unit = [Unit unitForUnitIdentifier:UnitIdentifierSecond];
      exerciseMoreInfo.value = [exerciseMoreInfo.unit.unitSystemConverter convertToSystemValue:[NSNumber numberWithInt:60]];
      [moreInfo setObject:exerciseMoreInfo forKey:exerciseMoreInfo.identifier];
    }
    
    _moreInfo = moreInfo;
  }
  
  return _moreInfo;
}

- (NSArray *)tags {
  
  if(!_tags) {
    
    NSArray* tags = nil;
    
    if([@"deadlift-max" isEqualToString: self.identifier]) {
      tags = [NSArray arrayWithObjects:@"Max", nil];
    } else if([@"thruster-heavy" isEqualToString: self.identifier]) {
      tags = [NSArray arrayWithObjects:@"Heavy", nil];
    } else if([@"pullup-unbroken" isEqualToString: self.identifier]) {
      tags = [NSArray arrayWithObjects:@"Unbroken", nil];
    } else if([@"double-under-unbroken" isEqualToString: self.identifier]) {
      tags = [NSArray arrayWithObjects:@"Unbroken", nil];
    } else if([@"burpee-amrap" isEqualToString: self.identifier]) {
      tags = [NSArray arrayWithObjects:@"AMRAP", nil];
    }
    
    _tags = tags;
  }
  return _tags;
}

- (void)setTags:(NSArray *)tags {
  _tags = tags;
}

@end