//
//  Unit.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import <Foundation/Foundation.h>
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

typedef enum {
  
  //General
  UnitIdentifierNone,
  UnitIdentifierPercent,

  //Length
  UnitIdentifierKilometer,
  UnitIdentifierMeter,
  UnitIdentifierMile,
  UnitIdentifierYard,
  UnitIdentifierFoot,
  UnitIdentifierInch,
  
  //Mass
  UnitIdentifierKilogram,
  UnitIdentifierPound,
  UnitIdentifierPood,
  
  //Time
  UnitIdentifierSecond
  
} UnitIdentifier;


@interface Unit : NSObject

@property UnitIdentifier identifier;
@property UnitType type;
@property id<UnitValueFormatter> valueFormatter;
@property id<UnitSystemConverter> unitSystemConverter;

+ (Unit *) unitForUnitIdentifier: (UnitIdentifier) unitIdentifier;


@end
