//
//  Unit.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import "Unit.h"
#import "ModelHelper.h"

#import "PoundFormatter.h"
#import "InchFormatter.h"
#import "PercentFormatter.h"
#import "FootInchFormatter.h"
#import "KilometerFormatter.h"
#import "MeterFormatter.h"
#import "KilogramFormatter.h"
#import "MileFormatter.h"
#import "YardFormatter.h"
#import "PoodFormatter.h"
#import "TimeFormatter.h"
#import "DefaultUnitValueFormatter.h"

#import "MeterConverter.h"
#import "KilometerConverter.h"
#import "MileConverter.h"
#import "InchConverter.h"
#import "FootConverter.h"
#import "YardConverter.h"
#import "KilogramConverter.h"
#import "PoundConverter.h"
#import "PoodConverter.h"
#import "DefaultUnitSystemConverter.h"

//General
UnitIdentifier UnitIdentifierNone = @"UnitIdentifierNone";
UnitIdentifier UnitIdentifierPercent = @"UnitIdentifierPercent";

//Length
UnitIdentifier UnitIdentifierKilometer = @"UnitIdentifierKilometer";
UnitIdentifier UnitIdentifierMeter = @"UnitIdentifierMeter";
UnitIdentifier UnitIdentifierMile = @"UnitIdentifierMile";
UnitIdentifier UnitIdentifierYard = @"UnitIdentifierYard";
UnitIdentifier UnitIdentifierFoot = @"UnitIdentifierFoot";
UnitIdentifier UnitIdentifierInch = @"UnitIdentifierInch";

//Mass
UnitIdentifier UnitIdentifierKilogram = @"UnitIdentifierKilogram";
UnitIdentifier UnitIdentifierPound = @"UnitIdentifierPound";
UnitIdentifier UnitIdentifierPood = @"UnitIdentifierPood";

//Time
UnitIdentifier UnitIdentifierSecond = @"UnitIdentifierSecond";

@implementation Unit

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////

//Relationships
@dynamic measurableMetadatas;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////

////////////////////////////////
//identifier
////////////////////////////////
@dynamic identifierImpl;

-(UnitIdentifier)identifier {
  [self willAccessValueForKey:@"identifier"];
  NSString *tmpValue = [self identifierImpl];
  [self didAccessValueForKey:@"identifier"];
  return (tmpValue!=nil) ? tmpValue : nil;
}

- (void)setIdentifier:(UnitIdentifier)identifier {
  NSString* tmpValue = identifier;
  [self willChangeValueForKey:@"identifier"];
  [self setIdentifierImpl:tmpValue];
  [self didChangeValueForKey:@"identifier"];
}

////////////////////////////////
//type
////////////////////////////////
@dynamic typeImpl;

-(UnitType)type {
  [self willAccessValueForKey:@"type"];
  NSNumber *tmpValue = [self typeImpl];
  [self didAccessValueForKey:@"type"];
  return (tmpValue!=nil) ? [tmpValue intValue] : UnitTypeGeneral;
}

-(void)setType:(UnitType)type {
  NSNumber* tmpValue = [[NSNumber alloc] initWithInt:type];
  [self willChangeValueForKey:@"type"];
  [self setTypeImpl:tmpValue];
  [self didChangeValueForKey:@"type"];
}

/////////////////////////////////////////////////////////
//Injected Properties
/////////////////////////////////////////////////////////
@synthesize valueFormatter;
@synthesize unitSystemConverter;

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////
+ (Unit *) unitForUnitIdentifier: (UnitIdentifier) identifier {
  
  Unit* unit = [[Unit unitsCache] objectForKey:identifier];
  
  if(!unit) {
    unit = [ModelHelper unitWithUnitIdentifier:identifier];
  }
  
  return unit;
}

/////////////////////////////////////////////////////////
//CACHE
/////////////////////////////////////////////////////////

static NSMutableDictionary* unitsCache;

+ (NSMutableDictionary*) unitsCache {
  
  if(!unitsCache) {
    unitsCache = [NSMutableDictionary dictionary];
  }
  return unitsCache;
}

+ (void) injectPropertiesAndCacheUnit:(Unit*) unit withIdentifier: (UnitIdentifier) identifier {
  
  //Already cached and initialized
  if([[Unit unitsCache] objectForKey:identifier]) {
    return;
  }
  
  id<UnitValueFormatter> valueFormatter;
  id<UnitSystemConverter> unitSystemConverter;  
  
  //LENGTH
  if([identifier isEqualToString: UnitIdentifierKilometer]) {
    valueFormatter = [[KilometerFormatter alloc] init];
    unitSystemConverter = [[KilometerConverter alloc] init];
  } else if([identifier isEqualToString: UnitIdentifierMeter]) {
    valueFormatter = [[MeterFormatter alloc] init];
    unitSystemConverter = [[MeterConverter alloc] init];
  } else if([identifier isEqualToString: UnitIdentifierMile]) {
    valueFormatter = [[MileFormatter alloc] init];
    unitSystemConverter = [[MileConverter alloc] init];
  } else if([identifier isEqualToString: UnitIdentifierYard]) {
    valueFormatter = [[YardFormatter alloc] init];
    unitSystemConverter = [[YardConverter alloc] init];
  } else if([identifier isEqualToString: UnitIdentifierFoot]) {
    valueFormatter = [[FootInchFormatter alloc] init];
    unitSystemConverter = [[FootConverter alloc] init];
  } else if([identifier isEqualToString: UnitIdentifierInch]) {
    valueFormatter = [[InchFormatter alloc] init];
    unitSystemConverter = [[InchConverter alloc] init];
  }
  
  //MASS
  else if([identifier isEqualToString: UnitIdentifierKilogram]) {
    valueFormatter = [[KilogramFormatter alloc] init];
    unitSystemConverter = [[KilogramConverter alloc] init];
  } else if([identifier isEqualToString: UnitIdentifierPound]) {
    valueFormatter = [[PoundFormatter alloc] init];
    unitSystemConverter = [[PoundConverter alloc] init];
  } else if([identifier isEqualToString: UnitIdentifierPood]) {
    valueFormatter = [[PoodFormatter alloc] init];
    unitSystemConverter = [[PoodConverter alloc] init];
  }
  
  //TIME
  else if([identifier isEqualToString: UnitIdentifierSecond]) {
    valueFormatter = [[TimeFormatter alloc] init];
    unitSystemConverter = [[DefaultUnitSystemConverter alloc] init];
  }
  
  //GENERAL
  else if([identifier isEqualToString: UnitIdentifierNone]) {
    valueFormatter = [[DefaultUnitValueFormatter alloc] init];
    unitSystemConverter = [[DefaultUnitSystemConverter alloc] init];
  } else if([identifier isEqualToString: UnitIdentifierPercent]) {
    valueFormatter = [[PercentFormatter alloc] init];
    unitSystemConverter = [[DefaultUnitSystemConverter alloc] init];
  }
  
  //Inject properties
  unit.valueFormatter = valueFormatter;
  unit.unitSystemConverter = unitSystemConverter;
  
  //Cache object
  [[Unit unitsCache] setObject:unit forKey:identifier];
}

- (void)didTurnIntoFault {
  
  //Remove it from the cache
  [[Unit unitsCache] removeObjectForKey: self.identifier];
  
  [super didTurnIntoFault];
}

- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context {
  self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
  
  if (self) {

    //Inject the properties and cache instance
    if(self.identifier) {
      [Unit injectPropertiesAndCacheUnit:self withIdentifier:self.identifier];
    }
  }
  return self;
}

-(void)didSave {
  [super didSave];

  //Inject the properties and cache instance
  [Unit injectPropertiesAndCacheUnit:self withIdentifier:self.identifier];
}


@end

