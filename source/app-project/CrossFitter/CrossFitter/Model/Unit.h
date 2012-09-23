//
//  Unit.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import <Foundation/Foundation.h>
#import "UnitValueFormatter.h"

@class UnitValueFormatter;

typedef enum {
  kUnitTypeGeneral, //Body Mass Index, Body Fat...
  kUnitTypeLength,
  kUnitTypeMass,
  kUnitTypeTime,
} UnitType;

typedef enum {
  
  //General
  kUnitIdentifierNone,
  kUnitIdentifierPercent,

  //Length
  kUnitIdentifierKilometer,
  kUnitIdentifierMeter,
  kUnitIdentifierMile,
  kUnitIdentifierYard,
  kUnitIdentifierFoot,
  kUnitIdentifierInch,
  
  //Mass
  kUnitIdentifierKilogram,
  kUnitIdentifierPound,
  kUnitIdentifierPood,
  
  //Time
  kUnitIdentifierSecond,
  kUnitIdentifierMinute
  
} UnitIdentifier;


@interface Unit : NSObject

@property UnitIdentifier identifier;
@property UnitType type;

+ (Unit *) unitForUnitIdentifier: (UnitIdentifier) unitIdentifier;

@end
