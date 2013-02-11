//
//  MeasurableData.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/14/12.
//
//

#import "MeasurableData.h"
#import "MeasurableDataEntry.h"
#import "MeasurableHelper.h"
#import "ModelHelper.h"

@interface MeasurableData () {
}

@property MeasurableDataEntry* firstValue;
@property BOOL needValuesUpdate;

@property BOOL needSetup;
@property BOOL needCleanup;

@end

@implementation MeasurableData

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////

//Relationships
@dynamic measurable;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////

////////////////////////////////
//values
////////////////////////////////
@dynamic valuesImpl;
@synthesize values = _values;
@synthesize needValuesUpdate;

- (NSArray *)values {
  [self willAccessValueForKey:@"values"];

  if(self.needValuesUpdate) {
    [self updateInternalState];
  }
  
  NSArray* tmpValue = _values;
  
  [self didAccessValueForKey:@"values"];
  return tmpValue;
}

/////////////////////////////////////////////////////////
//Computed Properties
/////////////////////////////////////////////////////////

@synthesize firstValue = _firstValue;

- (MeasurableValueTrend)valueTrend {
  return  (self.firstValue) ? self.firstValue.valueTrend : MeasurableValueTrendNone;
}

- (NSNumber *)value {
  return self.firstValue.value;
}

- (NSDate *)date {
  return self.firstValue.date;
}

- (NSString *)comment {
  return self.firstValue.comment;
}

- (MeasurableDataEntry *)firstValue {
  
  if(self.needValuesUpdate) {
    [self updateInternalState];
  }
  
  return _firstValue;
}
- (void)setFirstValue:(MeasurableDataEntry *)firstValue {
  _firstValue = firstValue;
}

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////

- (void) addValue:(MeasurableDataEntry*) value {

  //Create the relationship - add the value
  value.measurableData = self;
}

- (void) removeValue:(MeasurableDataEntry*) value {

  if([value.measurableData isEqual: self]) {
    value.measurableData = nil;
    [ModelHelper deleteModelObject:value andSave:NO];    
  }
}

- (void) dataChanged {
  self.needValuesUpdate = YES;
}

- (void) metadataChanged {
  self.needValuesUpdate = YES;
}

- (void) updateInternalState {

  //This (at the top) prevents infinit loops
  self.needValuesUpdate = NO;
  
  //Update the values
  _values = [MeasurableHelper arraySortedByDate:self.valuesImpl ascending:NO];
  
  //Update first value
  [self updateFirstValueFromValues:_values];
  
  //Update value trends
  [self updateValueTrendsInValues:_values];  
}

- (void)updateFirstValueFromValues:(NSArray*) values {
  
  if(values && values.count > 0) {
    self.firstValue = [values objectAtIndex:0];
  } else {
    self.firstValue = nil;
  }
}

- (void)updateValueTrendsInValues:(NSArray*) values {
  
  CGFloat curValue;
  CGFloat previousValue;

  MeasurableDataEntry* previousDataEntry = nil;
  
  for (NSInteger i = self.values.count-1; i>=0 ; i--) {
    
    MeasurableDataEntry* curDataEntry = [values objectAtIndex:i];
    
    curValue = [curDataEntry.value floatValue];
    
    if(previousDataEntry) {
      
      previousValue = [previousDataEntry.value floatValue];
      
      if (curValue > previousValue) {
        curDataEntry.valueTrend = MeasurableValueTrendUp;
      } else if (curValue < previousValue) {
        curDataEntry.valueTrend = MeasurableValueTrendDown;
      } else {
        curDataEntry.valueTrend = MeasurableValueTrendSame;
      }
    } else {
      curDataEntry.valueTrend = MeasurableValueTrendNone;
    }
    
    previousDataEntry = curDataEntry;    
  }
}

/////////////////////////////////////////////////////////
//Core Data
/////////////////////////////////////////////////////////

@synthesize needSetup;
@synthesize needCleanup;

- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context {
  self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
  
  if (self) {
    self.needSetup = YES;
    [self setup];
  }
  return self;
}

- (void)awakeFromFetch {
  [super awakeFromFetch];
  [self setup];
}

- (void)awakeFromInsert {
  [super awakeFromInsert];
  [self setup];
}

- (void)prepareForDeletion {
  [self cleanup];
  
  [super prepareForDeletion];
}

- (void)didTurnIntoFault {
  [self cleanup];
  [super didTurnIntoFault];
}

- (void) setup {
  
  if(self.needSetup) {
    
    [self addObserver:self forKeyPath:@"valuesImpl" options: 0 context: NULL];
    self.needValuesUpdate = YES;
    
    self.needSetup = NO;
    self.needCleanup = YES;
  }
}

- (void) cleanup {
  
  if(self.needCleanup) {
    
    //NSLog(@"MeasurableData - cleanup - %@", [self.objectID URIRepresentation].absoluteString);
    [self removeObserver:self forKeyPath:@"valuesImpl"];
    
    self.needCleanup = NO;
    self.needSetup = YES;
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  
  if([@"valuesImpl" isEqualToString:keyPath]) {
//    NSLog(@"MeasurableData - observeValueForKeyPath - values");

    self.needValuesUpdate = YES;    
  }
}



@end
