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

static Unit* secondUnit;

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
      kilometerUnit.valueFormatter = [[KilometerFormatter alloc] init];
      kilometerUnit.unitSystemConverter = [[KilometerConverter alloc] init];
    }
    unit = kilometerUnit;
  } else if(unitIdentifier == UnitIdentifierMeter) {
    if(!meterUnit) {
      meterUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierMeter withUnitType:UnitTypeLength];
      meterUnit.valueFormatter = [[MeterFormatter alloc] init];
      meterUnit.unitSystemConverter = [[MeterConverter alloc] init];
    }
    unit = meterUnit;
  } else if(unitIdentifier == UnitIdentifierMile) {
    if(!mileUnit) {
      mileUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierMile withUnitType:UnitTypeLength];
      mileUnit.valueFormatter = [[MileFormatter alloc] init];
      mileUnit.unitSystemConverter = [[MileConverter alloc] init];
    }
    unit = mileUnit;
  } else if(unitIdentifier == UnitIdentifierYard) {
    if(!yardUnit) {
      yardUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierYard withUnitType:UnitTypeLength];
      yardUnit.valueFormatter = [[YardFormatter alloc] init];
      yardUnit.unitSystemConverter = [[YardConverter alloc] init];
    }
    unit = yardUnit;
  } else if(unitIdentifier == UnitIdentifierFoot) {
    if(!footUnit) {
      footUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierFoot withUnitType:UnitTypeLength];
      footUnit.valueFormatter = [[FootInchFormatter alloc] init];
      footUnit.unitSystemConverter = [[FootConverter alloc] init];
    }
    unit = footUnit;
  } else if(unitIdentifier == UnitIdentifierInch) {
    if(!inchUnit) {
      inchUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierInch withUnitType:UnitTypeLength];
      inchUnit.valueFormatter = [[InchFormatter alloc] init];
      inchUnit.unitSystemConverter = [[InchConverter alloc] init];
    }
    unit = inchUnit;
  }
  
  //MASS
  else if(unitIdentifier == UnitIdentifierKilogram) {
    if(!kilogramUnit) {
      kilogramUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierKilogram withUnitType:UnitTypeMass];
      kilogramUnit.valueFormatter = [[KilogramFormatter alloc] init];
      kilogramUnit.unitSystemConverter = [[KilogramConverter alloc] init];
    }
    unit = kilogramUnit;
  } else if(unitIdentifier == UnitIdentifierPound) {
    if(!poundUnit) {
      poundUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierPound withUnitType:UnitTypeMass];
      poundUnit.valueFormatter = [[PoundFormatter alloc] init];
      poundUnit.unitSystemConverter = [[PoundConverter alloc] init];
    }
    unit = poundUnit;
  } else if(unitIdentifier == UnitIdentifierPood) {
    if(!poodUnit) {
      poodUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierPood withUnitType:UnitTypeMass];
      poodUnit.valueFormatter = [[PoodFormatter alloc] init];
      poodUnit.unitSystemConverter = [[PoodConverter alloc] init];
    }
    unit = poodUnit;
  }

  //TIME
  else if(unitIdentifier == UnitIdentifierSecond) {
    if(!secondUnit) {
      secondUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierSecond withUnitType:UnitTypeTime];
      secondUnit.valueFormatter = [[TimeFormatter alloc] init];
      secondUnit.unitSystemConverter = [[DefaultUnitSystemConverter alloc] init];
    }
    unit = secondUnit;
  }
  
  //GENERAL
  else if(unitIdentifier == UnitIdentifierNone) {
    if(!noneUnit) {
      noneUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierNone withUnitType:UnitTypeGeneral];
      noneUnit.valueFormatter = [[DefaultUnitValueFormatter alloc] init];
      noneUnit.unitSystemConverter = [[DefaultUnitSystemConverter alloc] init];
    }
    unit = noneUnit;
  } else if(unitIdentifier == UnitIdentifierPercent) {
    if(!percentUnit) {
      percentUnit = [[Unit alloc] initWithUnitIdentifier:UnitIdentifierPercent withUnitType:UnitTypeGeneral];
      percentUnit.valueFormatter = [[PercentFormatter alloc] init];
      percentUnit.unitSystemConverter = [[DefaultUnitSystemConverter alloc] init];
    }
    unit = percentUnit;
  }
  
  return unit;
}

@end
