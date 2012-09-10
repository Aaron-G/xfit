//
//  UIHelper.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/9/12.
//
//

#import "UIHelper.h"

@implementation UIHelper

+ (CGAffineTransform) adjustImage: (UIButton*) buttonWithImage forMeasurable: (id <Measurable>) measurable {
  
  CGAffineTransform transform = CGAffineTransformIdentity;
  
  if(measurable.valueTrend == kMeasurableValueTrendNone) {
    buttonWithImage.hidden = YES;
    [buttonWithImage setImage:nil forState:UIControlStateNormal];
  } else {
    
    buttonWithImage.hidden = NO;
    [buttonWithImage setImage:[UIHelper imageForValueTrend:measurable.valueTrend] forState:UIControlStateNormal];
    
    //Rotate the image appropriately to indicate proper
    //direction based on Metric "better trend properties"
    if(measurable.valueTrend != kMeasurableValueTrendSame) {
      
      CGFloat imageRotationAngle;
      if(measurable.valueTrend == kMeasurableValueTrendBetter) {
        if(measurable.valueTrendBetterDirection == kMeasurableValueTrendDirectionDown) {
          imageRotationAngle = 0;
        } else if (measurable.valueTrendBetterDirection == kMeasurableValueTrendDirectionUp) {
          imageRotationAngle = 180;
        }
      } else if(measurable.valueTrend == kMeasurableValueTrendWorse) {
        if(measurable.valueTrendBetterDirection == kMeasurableValueTrendDirectionUp) {
          imageRotationAngle = 0;
        } else if (measurable.valueTrendBetterDirection == kMeasurableValueTrendDirectionDown) {
          imageRotationAngle = 180;
        }
      }
      
      transform = CGAffineTransformMakeRotation(imageRotationAngle*M_PI/180.0);
    }
  }
  return transform;
}

+ (UIImage*) imageForValueTrend: (MeasurableValueTrend) valueTrend {
  
  NSString* imageName = nil;
  
  if(valueTrend == kMeasurableValueTrendBetter) {
    imageName = @"better-value-image";
  } else if(valueTrend == kMeasurableValueTrendWorse) {
    imageName = @"worse-value-image";
  } else if(valueTrend == kMeasurableValueTrendSame) {
    imageName = @"same-value-image";
  }
  
  if(imageName) {
    return [UIImage imageNamed:imageName];
  } else {
    return nil;
  }
}

@end
