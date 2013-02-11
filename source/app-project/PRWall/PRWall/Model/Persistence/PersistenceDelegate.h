//
//  PersistenceDelegate.h
//  PR Wall
//
//  Created by Cleo Barretto on 1/19/13.
//
//

#import <Foundation/Foundation.h>

@interface PersistenceDelegate : NSObject

//Notifies the PersistenceDelegate that the data hans changed
- (void) dataChanged;

//Save the data - if needed
- (void) save;

@end
