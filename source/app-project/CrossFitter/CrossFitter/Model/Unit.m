//
//  Unit.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/8/12.
//
//

#import "Unit.h"
#import "PoundFormatter.h"
#import "InchFormatter.h"
#import "PercentFormatter.h"
#import "DefaultUnitValueFormatter.h"

static Unit* secondUnit;
static Unit* minuteUnit;

static Unit* kilometerUnit;
static Unit* meterUnit;
static Unit* mileUnit;
static Unit* yardUnit;
static Unit* footUnit;
static Unit* inchUnit;

static Unit* kilogramUnit;
static Unit* poundUnit;
static Unit* poodUnit;

static Unit* noneUnit;
static Unit* percentUnit;


@implementation Unit

- (id) initWithUnitIdentifier:(UnitIdentifier) unitIdentifier withUnitType: (UnitType) UnitType {
  self = [super init];
  
  if(self) {
    self.identifier = unitIdentifier;
    self.type = UnitType;
  }
  
  return self;
}


+ (Unit *) unitForUnitIdentifier: (UnitIdentifier) unitIdentifier {
  
  Unit* unit = nil;
  
  //LENGTH
  if(unitIdentifier == UnitIdentifierKilometer) {
    if(!kilometerUnit) {
      kilometerUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierKilometer withUnitType:UnitTypeLength];
    }
    unit = kilometerUnit;
  } else if(unitIdentifier == UnitIdentifierMeter) {
    if(!meterUnit) {
      meterUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierMeter withUnitType:UnitTypeLength];
    }
    unit = meterUnit;
  } else if(unitIdentifier == UnitIdentifierMile) {
    if(!mileUnit) {
      mileUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierMile withUnitType:UnitTypeLength];
    }
    unit = mileUnit;
  } else if(unitIdentifier == UnitIdentifierYard) {
    if(!yardUnit) {
      yardUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierYard withUnitType:UnitTypeLength];
    }
    unit = yardUnit;
  } else if(unitIdentifier == UnitIdentifierFoot) {
    if(!footUnit) {
      footUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierFoot withUnitType:UnitTypeLength];
    }
    unit = footUnit;
  } else if(unitIdentifier == UnitIdentifierInch) {
    if(!inchUnit) {
      inchUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierInch withUnitType:UnitTypeLength];
    }
    unit = inchUnit;
  }
  
  //MASS
  else if(unitIdentifier == UnitIdentifierKilogram) {
    if(!kilogramUnit) {
      kilogramUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierKilogram withUnitType:UnitTypeMass];
    }
    unit = kilogramUnit;
  } else if(unitIdentifier == UnitIdentifierPound) {
    if(!poundUnit) {
      poundUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierPound withUnitType:UnitTypeMass];
    }
    unit = poundUnit;
  } else if(unitIdentifier == UnitIdentifierPood) {
    if(!poodUnit) {
      poodUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierPood withUnitType:UnitTypeMass];
    }
    unit = poodUnit;
  }

  //TIME
  else if(unitIdentifier == UnitIdentifierMinute) {
    if(!minuteUnit) {
      minuteUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierMinute withUnitType:UnitTypeTime];
    }
    unit = minuteUnit;
  } else if(unitIdentifier == UnitIdentifierSecond) {
    if(!secondUnit) {
      secondUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierSecond withUnitType:UnitTypeTime];
    }
    unit = secondUnit;
  }
  
  //GENERAL
  else if(unitIdentifier == UnitIdentifierNone) {
    if(!noneUnit) {
      noneUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierNone withUnitType:UnitTypeGeneral];
    }
    unit = noneUnit;
  } else if(unitIdentifier == UnitIdentifierPercent) {
    if(!percentUnit) {
      percentUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierPercent withUnitType:UnitTypeGeneral];
    }
    unit = percentUnit;
  }
  
  return unit;
}

@end
