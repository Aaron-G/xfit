//
//  Unit.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import <Foundation/Foundation.h>

typedef enum {
  kUnitTypeLength,
  kUnitTypeMass,
  kUnitTypeTime,
  kUnitTypePercent
} UnitType;

typedef enum {
  
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
  kUnitIdentifierSeconds
  
} UnitIdentifier;


@interface Unit : NSObject

@property UnitIdentifier identifier;
@property UnitType type;

@end
