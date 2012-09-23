//
//  FootInchFormatter.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/21/12.
//
//

#import "FootInchFormatter.h"

@interface FootInchFormatter () {
  
}
@property NSString* feetAndInchesFormat;
@property NSString* feetFormat;
@property NSString* inchesFormat;

@end

//CXB TODO
//Refactor to simply use delegation to 1 FootFormatter and another
//InchFormatter then combine the result
@implementation FootInchFormatter

@synthesize feetAndInchesFormat = _feetAndInchesFormat;
@synthesize feetFormat = _feetFormat;
@synthesize inchesFormat = _inchesFormat;

- (NSString *)formatValue:(NSNumber*)value {
  
  NSInteger intValue = value.integerValue;
  
  NSInteger feet = intValue / 12;
  NSInteger inches = intValue % 12;
  
  if(inches == 0) {
    return [NSString stringWithFormat:self.feetFormat, feet];
  } else if (feet == 0) {
    return [NSString stringWithFormat:self.inchesFormat, inches];
  } else {
    return [NSString stringWithFormat:self.feetAndInchesFormat, feet, inches];
  }
}

- (void) setFeetFormat:(NSString*) format {
  _feetFormat = format;
}

- (NSString*) feetFormat {
  
  if(!_feetFormat) {
    _feetFormat = NSLocalizedString(@"foot-format", @"'");
  }
  return _feetFormat;
}

- (void) setFeetAndInchesFormat:(NSString*) format {
  _feetAndInchesFormat = format;
}

- (NSString*) feetAndInchesFormat {
  
  if(!_feetAndInchesFormat) {
    _feetAndInchesFormat = NSLocalizedString(@"foot-and-inch-format", @"' \"");
  }
  return _feetAndInchesFormat;
}

- (void) setInchesFormat:(NSString*) format {
  _inchesFormat = format;
}

- (NSString*) inchesFormat {
  
  if(!_inchesFormat) {
    _inchesFormat = NSLocalizedString(@"inch-format", @"\"");
  }
  return _inchesFormat;
}

@end
