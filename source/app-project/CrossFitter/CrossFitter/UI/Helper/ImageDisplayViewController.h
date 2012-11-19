//
//  ImageDisplayViewController.h
//  CrossFitter
//
//  Created by Cleo Barretto on 11/16/12.
//
//

#import <UIKit/UIKit.h>

@interface ImageDisplayViewController : UIViewController <UIGestureRecognizerDelegate>

@property IBOutlet UINavigationBar* navigationBar;
@property IBOutlet UIBarButtonItem* doneBarButtonItem;
@property IBOutlet UIImageView* imageView;
@property UIImage* image;

- (IBAction) hide:(id)sender;

@end
