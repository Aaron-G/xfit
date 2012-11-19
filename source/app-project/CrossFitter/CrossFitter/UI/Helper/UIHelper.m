//
//  UIHelper.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/9/12.
//
//

#import "UIHelper.h"
#import "App.h"

@implementation UIHelper

static NSDateFormatter* _appDateFormat;

+ (void) adjustImage: (UIButton*) buttonWithImage forMeasurable: (id <Measurable>) measurable {
  [UIHelper adjustImage: buttonWithImage
withMeasurableValueTrend: measurable.dataProvider.valueTrend
withMeasurableValueTrendBetterDirection: measurable.metadataProvider.valueTrendBetterDirection];
}

+ (void) adjustImage: (UIButton*) buttonWithImage withMeasurableValueTrend: (MeasurableValueTrend) measurableValueTrend withMeasurableValueTrendBetterDirection: (MeasurableValueTrendBetterDirection) valueTrendBetterDirection {
  
  CGAffineTransform transform = CGAffineTransformIdentity;
  
  if(measurableValueTrend == MeasurableValueTrendNone) {
    buttonWithImage.hidden = YES;
    [buttonWithImage setImage:nil forState:UIControlStateNormal];
  } else {
    
    buttonWithImage.hidden = NO;
    
    MeasurableValueTrend valueTrend = measurableValueTrend;
    
    [buttonWithImage setImage:[UIHelper imageForValueTrend:valueTrend
                             withValueTrendBetterDirection:valueTrendBetterDirection]
                     forState:UIControlStateNormal];
    
    //Rotate the image appropriately to indicate proper
    //direction based on Metric "better trend properties"
    if(valueTrend != MeasurableValueTrendSame) {
      
      CGFloat imageRotationAngle;
      if(valueTrend == MeasurableValueTrendUp) {
        imageRotationAngle = 180;
      } else if(valueTrend == MeasurableValueTrendDown) {
        imageRotationAngle = 0;
      }
      
      transform = CGAffineTransformMakeRotation(imageRotationAngle*M_PI/180.0);
    }
  }
  buttonWithImage.transform = transform;
}

+ (UIImage*) imageForValueTrend: (MeasurableValueTrend) valueTrend withValueTrendBetterDirection: (MeasurableValueTrendBetterDirection) valueTrendBetterDirection {
  
  NSString* imageName = nil;
  
  if((valueTrend == MeasurableValueTrendUp && valueTrendBetterDirection == MeasurableValueTrendBetterDirectionUp) ||
     (valueTrend == MeasurableValueTrendDown && valueTrendBetterDirection == MeasurableValueTrendBetterDirectionDown)) {
    imageName = @"better-value-direction";
  } else if((valueTrend == MeasurableValueTrendUp && valueTrendBetterDirection == MeasurableValueTrendBetterDirectionDown) ||
            (valueTrend == MeasurableValueTrendDown && valueTrendBetterDirection == MeasurableValueTrendBetterDirectionUp)) {
    imageName = @"worse-value-direction";
  } else if(valueTrend == MeasurableValueTrendSame) {
    imageName = @"same-value-direction";
  }
  
  if(imageName) {
    return [UIImage imageNamed:imageName];
  } else {
    return nil;
  }
}

+ (void) displayImageFullScreen:(UIImage*) image {
  ImageDisplayViewController* imageDisplayViewController = [UIHelper imageDisplayViewController];
  imageDisplayViewController.image = image;
  [[[UIHelper appViewController] navigationController] presentViewController:imageDisplayViewController animated:YES completion:nil];
}

+ (AppViewController*) appViewController {
  return [[App sharedInstance] appViewController];
}

+ (MeasurableViewController*) measurableViewController {
  return [[App sharedInstance] measurableViewController];
}

+ (UserProfileViewController*) userProfileViewController {
  return [[App sharedInstance] userProfileViewController];
}

+ (UIViewController*) viewControllerWithViewStoryboardIdentifier: (NSString*) identifier {
  AppViewController* appViewController = [[App sharedInstance] appViewController];
  return [appViewController.storyboard instantiateViewControllerWithIdentifier:identifier];
}

+ (ImageDisplayViewController*) imageDisplayViewController {
  return (ImageDisplayViewController*)[UIHelper viewControllerWithViewStoryboardIdentifier: @"ImageDisplayViewController"];
}

+ (NSDateFormatter *)appDateFormat {
  if(!_appDateFormat) {
    _appDateFormat = [[NSDateFormatter alloc] init];
    _appDateFormat.dateFormat = NSLocalizedString(@"app-date-format", @"MM/dd/yy");
  }
  return _appDateFormat;
}

+ (void) showMessage:(NSString*) message withTitle:(NSString*) title {
  
  UIAlertView *alertView = [[UIAlertView alloc]
                            initWithTitle:title
                            message:message
                            delegate:nil cancelButtonTitle:NSLocalizedString(@"ok-label", @"OK")
                            otherButtonTitles:nil];
  [alertView show];

}

+ (CGFloat) moveToYLocation:(CGFloat) yLocation reshapeWithSize:(CGSize) size orHide:(BOOL) hide view:(UIView*) view withVerticalSpacing:(NSInteger) verticalSpacing {
  
  if(hide) {
    view.hidden = YES;
    return yLocation;
  } else {
    
    CGRect curViewFrame = view.frame;
    
    CGRect newViewFrame = CGRectMake(curViewFrame.origin.x, yLocation, size.width, size.height);

    //Unhide, just in case it was hidden before
    view.hidden = NO;
    
    view.frame = newViewFrame;
    
    return newViewFrame.origin.y + newViewFrame.size.height + verticalSpacing;
  }
}

+ (NSUInteger)supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskPortrait;
}

+ (NSUInteger)supportedInterfaceOrientationsWithLandscape {
  return UIInterfaceOrientationMaskPortrait & UIInterfaceOrientationMaskLandscapeRight;
}

@end
