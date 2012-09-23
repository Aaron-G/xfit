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
  if(unitIdentifier == kUnitIdentifierKilometer) {
    if(!kilometerUnit) {
      kilometerUnit = [[Unit alloc] initWithUnitIdentifier:kUnitIdentifierKilometer withUnitType:kUnitTypeLength];
    }
    unit = kilometerUnit;
  } else if(unitIdentifier == kUnitIdentifierMeter) {
    if(!meterUnit) {
      meterUnit = [[Unit alloc] initWithUnitIdentifier:kUnitIdentifierMeter withUnitType:kUnitTypeLength];
    }
    unit = meterUnit;
  } else if(unitIdentifier == kUnitIdentifierMile) {
    if(!mileUnit) {
      mileUnit = [[Unit alloc] initWithUnitIdentifier:kUnitIdentifierMile withUnitType:kUnitTypeLength];
    }
    unit = mileUnit;
  } else if(unitIdentifier == kUnitIdentifierYard) {
    if(!yardUnit) {
      yardUnit = [[Unit alloc] initWithUnitIdentifier:kUnitIdentifierYard withUnitType:kUnitTypeLength];
    }
    unit = yardUnit;
  } else if(unitIdentifier == kUnitIdentifierFoot) {
    if(!footUnit) {
      footUnit = [[Unit alloc] initWithUnitIdentifier:kUnitIdentifierFoot withUnitType:kUnitTypeLength];
    }
    unit = footUnit;
  } else if(unitIdentifier == kUnitIdentifierInch) {
    if(!inchUnit) {
      inchUnit = [[Unit alloc] initWithUnitIdentifier:kUnitIdentifierInch withUnitType:kUnitTypeLength];
    }
    unit = inchUnit;
  }
  
  //MASS
  else if(unitIdentifier == kUnitIdentifierKilogram) {
    if(!kilogramUnit) {
      kilogramUnit = [[Unit alloc] initWithUnitIdentifier:kUnitIdentifierKilogram withUnitType:kUnitTypeMass];
    }
    unit = kilogramUnit;
  } else if(unitIdentifier == kUnitIdentifierPound) {
    if(!poundUnit) {
      poundUnit = [[Unit alloc] initWithUnitIdentifier:kUnitIdentifierPound withUnitType:kUnitTypeMass];
    }
    unit = poundUnit;
  } else if(unitIdentifier == kUnitIdentifierPood) {
    if(!poodUnit) {
      poodUnit = [[Unit alloc] initWithUnitIdentifier:kUnitIdentifierPood withUnitType:kUnitTypeMass];
    }
    unit = poodUnit;
  }

  //TIME
  else if(unitIdentifier == kUnitIdentifierMinute) {
    if(!minuteUnit) {
      minuteUnit = [[Unit alloc] initWithUnitIdentifier:kUnitIdentifierMinute withUnitType:kUnitTypeTime];
    }
    unit = minuteUnit;
  } else if(unitIdentifier == kUnitIdentifierSecond) {
    if(!secondUnit) {
      secondUnit = [[Unit alloc] initWithUnitIdentifier:kUnitIdentifierSecond withUnitType:kUnitTypeTime];
    }
    unit = secondUnit;
  }
  
  //GENERAL
  else if(unitIdentifier == kUnitIdentifierNone) {
    if(!noneUnit) {
      noneUnit = [[Unit alloc] initWithUnitIdentifier:kUnitIdentifierNone withUnitType:kUnitTypeGeneral];
    }
    unit = noneUnit;
  } else if(unitIdentifier == kUnitIdentifierPercent) {
    if(!percentUnit) {
      percentUnit = [[Unit alloc] initWithUnitIdentifier:kUnitIdentifierPercent withUnitType:kUnitTypeGeneral];
    }
    unit = percentUnit;
  }
  
  return unit;
}

@end
