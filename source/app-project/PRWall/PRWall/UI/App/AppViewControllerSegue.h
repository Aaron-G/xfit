//
//  AppViewControllerSegue.h
//  PR Wall
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import <UIKit/UIKit.h>

/*
 Segue that knows how to transition from embedded view controllers.
 */
@interface AppViewControllerSegue : UIStoryboardSegue

@property BOOL modal;

@end
