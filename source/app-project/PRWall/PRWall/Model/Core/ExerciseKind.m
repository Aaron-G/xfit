//
//  ExerciseKind.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/27/12.
//
//

#import "ExerciseKind.h"

@interface ExerciseKind ()

- (id)initWithIdentifier:(ExerciseKindIdentifier)identifier withName:(NSString *)name withDescription:(NSString *)description;

@end

@implementation ExerciseKind

static NSArray* exerciseKinds;

- (id)initWithIdentifier:(ExerciseKindIdentifier)identifier withName:(NSString *)name withDescription:(NSString *)description {
  self = [super init];
  
  if(self) {
    self.name = name;
    self.description = description;
  }
  return self;
}

+ (NSArray *)exerciseKinds {

  if(!exerciseKinds) {
    exerciseKinds = [NSArray arrayWithObjects:
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierBall withName:@"Ball" withDescription:@"Wall ball, ball slam"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierBar withName:@"Bar" withDescription:@"Pull up, chin up"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierBody withName:@"Body" withDescription:@"Push up, burpee"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierBox withName:@"Box" withDescription:@"Box jump, dip"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierChain withName:@"Chain" withDescription:@"Battle Chain"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierCore withName:@"Core" withDescription:@"Bicycle crunch, ISO abs"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierGHD withName:@"GHD" withDescription:@"Back extension, sit up"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierKettleBell withName:@"Kettle Bell" withDescription:@"Kettle bell swing, man makers"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierLadder withName:@"Ladder" withDescription:@"Ladder push up, ladder sprints"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierLift withName:@"Lift" withDescription:@"Clean, thurster, jerk"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierMotion withName:@"Motion" withDescription:@"Run, liners, lunge"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierRing withName:@"Ring" withDescription:@"Ring dip, muscle up"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierRope withName:@"Rope" withDescription:@"Double under, rope climb"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierRow withName:@"Row" withDescription:@"Row, row sprints"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierSled withName:@"Sled" withDescription:@"Sled pull"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierSquat withName:@"Squat" withDescription:@"Front squat, back squat"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierStretch withName:@"Stretch" withDescription:@"Foam roll, rest"],
                     [[ExerciseKind alloc] initWithIdentifier:ExerciseKindIdentifierTire withName:@"Tire" withDescription:@"Tire flip, tire hammer"],
                     nil];
  }
  return exerciseKinds;
}

+ (ExerciseKind*) exerciseKindForIdentifier:(ExerciseKindIdentifier) identifier {  
  return [[ExerciseKind exerciseKinds] objectAtIndex:identifier];
}

@end
