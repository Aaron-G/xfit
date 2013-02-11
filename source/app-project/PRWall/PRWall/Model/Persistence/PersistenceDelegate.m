//
//  PersistenceDelegate.m
//  PR Wall
//
//  Created by Cleo Barretto on 1/19/13.
//
//

#import "PersistenceDelegate.h"
#import "PersistenceStore.h"

@interface PersistenceDelegate ()

@property BOOL needsSave;

@end

@implementation PersistenceDelegate

- (id)init {
  self = [super init];
  if (self) {
    self.needsSave = NO;
  }
  return self;
}

- (void) dataChanged {
  self.needsSave = YES;
}

- (void) save {
  
  if(self.needsSave) {
    
    //Save the changes
    self.needsSave = (![[PersistenceStore sharedInstance] save]);
    
    //Ensure the changes were saved
    assert(!self.needsSave);
  }
}

@end
