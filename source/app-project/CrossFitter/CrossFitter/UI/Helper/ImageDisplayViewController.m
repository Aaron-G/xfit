//
//  ImageDisplayViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 11/16/12.
//
//

#import "ImageDisplayViewController.h"
#import "UIHelper.h"
#import "ImageDisplayViewGestureRecognizer.h"

@interface ImageDisplayViewController ()

@end

@implementation ImageDisplayViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  self.imageView.image = self.image;

  //
  UITapGestureRecognizer* showNavigationBarGestureRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNavigationBar)];
  showNavigationBarGestureRecognizer.numberOfTapsRequired = 1;
  showNavigationBarGestureRecognizer.numberOfTouchesRequired = 1;
  showNavigationBarGestureRecognizer.cancelsTouchesInView = NO;
 
  [self.imageView addGestureRecognizer:showNavigationBarGestureRecognizer];
  
}
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self showNavigationBar:NO];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
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

- (IBAction) hide:(id)sender {
  [[UIHelper appViewController] dismissViewControllerAnimated:YES completion:nil];
}

@end
