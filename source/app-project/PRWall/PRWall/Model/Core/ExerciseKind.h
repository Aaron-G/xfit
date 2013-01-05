//
//  ExerciseKind.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/27/12.
//
//

#import <Foundation/Foundation.h>

@interface ExerciseKind : NSObject

typedef enum {
  ExerciseKindIdentifierBall,
  ExerciseKindIdentifierBar,
  ExerciseKindIdentifierBody,
  ExerciseKindIdentifierBox,
  ExerciseKindIdentifierChain,
  ExerciseKindIdentifierCore,
  ExerciseKindIdentifierGHD,
  ExerciseKindIdentifierKettleBell,
  ExerciseKindIdentifierLadder,
  ExerciseKindIdentifierLift,
  ExerciseKindIdentifierMotion,
  ExerciseKindIdentifierRing,
  ExerciseKindIdentifierRope,
  ExerciseKindIdentifierRow,
  ExerciseKindIdentifierSled,
  ExerciseKindIdentifierSquat,
  ExerciseKindIdentifierStretch,
  ExerciseKindIdentifierTire
} ExerciseKindIdentifier;

@property NSString* name;
@property NSString* description;

+ (NSArray*) exerciseKinds;
+ (ExerciseKind*) exerciseKindForIdentifier:(ExerciseKindIdentifier) identifier;

@end











