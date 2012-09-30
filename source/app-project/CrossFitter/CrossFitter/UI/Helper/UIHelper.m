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

+ (void) adjustImage: (UIButton*) buttonWithImage forMeasurable: (id <Measurable>) measurable {
  
  CGAffineTransform transform = CGAffineTransformIdentity;
  
  if(measurable.dataProvider.valueTrend == MeasurableValueTrendNone) {
    buttonWithImage.hidden = YES;
    [buttonWithImage setImage:nil forState:UIControlStateNormal];
  } else {
    
    buttonWithImage.hidden = NO;
    
    MeasurableValueTrend valueTrend = measurable.dataProvider.valueTrend;
    MeasurableValueTrendBetterDirection valueTrendBetterDirection = measurable.metadataProvider.valueTrendBetterDirection;
    
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
    imageName = @"better-value-image";
  } else if((valueTrend == MeasurableValueTrendUp && valueTrendBetterDirection == MeasurableValueTrendBetterDirectionDown) ||
            (valueTrend == MeasurableValueTrendDown && valueTrendBetterDirection == MeasurableValueTrendBetterDirectionUp)) {
    imageName = @"worse-value-image";
  } else if(valueTrend == MeasurableValueTrendSame) {
    imageName = @"same-value-image";
  }
  
  if(imageName) {
    return [UIImage imageNamed:imageName];
  } else {
    return nil;
  }
}

+ (MeasurableViewController*) measurableViewController {
  return (MeasurableViewController*) [UIHelper viewControllerWithViewControllerIdentifier: @"MeasurableViewController"];
}

+ (UIViewController*) viewControllerWithViewControllerIdentifier: (NSString*) identifier {
  AppViewController* appViewController = [[App sharedInstance] appViewController];
  return [appViewController.storyboard instantiateViewControllerWithIdentifier:identifier];
}



@end
