//
//  NavigationBarAutoHideSupport.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/14/12.
//
//

#import "NavigationBarAutoHideSupport.h"

@interface NavigationBarAutoHideSupport ()

@property UIViewController* viewController;
@property UINavigationBar* navigationBar;

@end

@implementation NavigationBarAutoHideSupport

- (void)installSupportOnViewController:(UIViewController *)viewController withNavigationBar:(UINavigationBar *)navigationBar
{

  self.viewController = viewController;
  self.navigationBar = navigationBar;
  
  UITapGestureRecognizer* showNavigationBarGestureRecognizer =
  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNavigationBar)];
  showNavigationBarGestureRecognizer.numberOfTapsRequired = 1;
  showNavigationBarGestureRecognizer.numberOfTouchesRequired = 1;
  showNavigationBarGestureRecognizer.cancelsTouchesInView = NO;
  
  [viewController.view addGestureRecognizer:showNavigationBarGestureRecognizer];
  
  //Start Hidden
  [self showNavigationBar:NO];
}

- (void) updateToolbarVisibility:(BOOL) visible when:(CGFloat) when {
  
  UIViewAnimationOptions animationOptions = (visible) ? UIViewAnimationOptionCurveEaseIn : UIViewAnimationOptionCurveEaseOut;
  
  [UIView animateWithDuration: 0.3
                        delay: when
                      options: animationOptions
                   animations:^{
                     self.navigationBar.alpha = (visible) ? 1 : 0;
                   }
                   completion: ^(BOOL finished){
                     
                     //If displaying the toobar, hide it after a bit
                     if(visible) {
                       
                       int64_t delayInSeconds = 2.0;
                       dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                       dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                         [self updateToolbarVisibility:NO when:0];
                       });
                     }
                   }];
}

- (void) showNavigationBar:(BOOL) show {
  self.navigationBar.alpha = (show) ? 1 : 0;
}

- (void) showNavigationBar {
  [self updateToolbarVisibility:YES when:0];
}

@end
