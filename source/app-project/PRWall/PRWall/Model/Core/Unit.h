//
//  Unit.h
//  PR Wall
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "UnitValueFormatter.h"
#import "UnitSystemConverter.h"

@class UnitValueFormatter;
@class UnitSystemConverter;

typedef enum {
  UnitTypeGeneral, //Body Mass Index, Body Fat...
  UnitTypeLength,
  UnitTypeMass,
  UnitTypeTime,
} UnitType;

typedef NSString* UnitIdentifier;

//General
extern UnitIdentifier UnitIdentifierNone;
extern UnitIdentifier UnitIdentifierPercent;

//Length
extern UnitIdentifier UnitIdentifierKilometer;
extern UnitIdentifier UnitIdentifierMeter;
extern UnitIdentifier UnitIdentifierMile;
extern UnitIdentifier UnitIdentifierYard;
extern UnitIdentifier UnitIdentifierFoot;
extern UnitIdentifier UnitIdentifierInch;

//Mass
extern UnitIdentifier UnitIdentifierKilogram;
extern UnitIdentifier UnitIdentifierPound;
extern UnitIdentifier UnitIdentifierPood;

//Time
extern UnitIdentifier UnitIdentifierSecond;

@interface Unit : NSManagedObject

/////////////////////////////////////////////////////////
//Core Data Properties
/////////////////////////////////////////////////////////

//Relationships
@property (nonatomic, retain) NSSet * measurableMetadatas;

/////////////////////////////////////////////////////////
//Wrapped Properties
/////////////////////////////////////////////////////////

//Attributes
@property UnitIdentifier identifier;
@property (nonatomic, retain) NSString * identifierImpl;

@property UnitType type;
@property (nonatomic, retain) NSNumber * typeImpl;

/////////////////////////////////////////////////////////
//Injected Properties
/////////////////////////////////////////////////////////
//@property UnitIdentifier identifier;
@property id<UnitValueFormatter> valueFormatter;
@property id<UnitSystemConverter> unitSystemConverter;

/////////////////////////////////////////////////////////
//API
/////////////////////////////////////////////////////////
+ (Unit *) unitForUnitIdentifier: (UnitIdentifier) unitIdentifier;

@end
