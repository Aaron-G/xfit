//
//  AppViewGestureRecognizer.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/3/12.
//
//

#import "AppViewGestureRecognizer.h"
#import "App.h"

@implementation AppViewGestureRecognizer

- (id)initWithTarget:(id)target action:(SEL)action {
  self = [super initWithTarget:target action:action];
  
  if(self) {
    self.numberOfTapsRequired = 1;
    self.numberOfTouchesRequired = 1;
    self.delegate = self;
    
    //We disable the touches on the view when the menu
    //is visible because the x and y of the touch gets
    //improperly translated. So it can happen the user
    //taps in row 1 but the event is processed by row 2
    self.cancelsTouchesInView = YES;
  }
  return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
  
  //On these cases we do not want to interfere with the normal processing of events
  //In another words, do not enforce behavior defined by this Gesture Recognizer 
  if ([touch.view isKindOfClass:[UILabel class]] && ((UILabel*)(touch.view)).enabled) {
    return NO;
  }
  
  return YES;
}

@end
