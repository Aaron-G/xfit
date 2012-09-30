//
//  UIHelper.m
//  CrossFitter
//
//  Created by Cleo Barretto on 9/9/12.
//
//

#import "UIHelper.h"

@implementation UIHelper

+ (void) adjustImage: (UIButton*) buttonWithImage forMeasurable: (id <Measurable>) measurable {
  
  CGAffineTransform transform = CGAffineTransformIdentity;
  
  if(measurable.dataProvider.valueTrend == kMeasurableValueTrendNone) {
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
    if(valueTrend != kMeasurableValueTrendSame) {
      
      CGFloat imageRotationAngle;
      if(valueTrend == kMeasurableValueTrendUp) {
        imageRotationAngle = 180;
      } else if(valueTrend == kMeasurableValueTrendDown) {
        imageRotationAngle = 0;
      }
      
      transform = CGAffineTransformMakeRotation(imageRotationAngle*M_PI/180.0);
    }
  }
  buttonWithImage.transform = transform;
}

+ (UIImage*) imageForValueTrend: (MeasurableValueTrend) valueTrend withValueTrendBetterDirection: (MeasurableValueTrendBetterDirection) valueTrendBetterDirection {
  
  NSString* imageName = nil;
  
  if((valueTrend == kMeasurableValueTrendUp && valueTrendBetterDirection == kMeasurableValueTrendBetterDirectionUp) ||
     (valueTrend == kMeasurableValueTrendDown && valueTrendBetterDirection == kMeasurableValueTrendBetterDirectionDown)) {
    imageName = @"better-value-image";
  } else if((valueTrend == kMeasurableValueTrendUp && valueTrendBetterDirection == kMeasurableValueTrendBetterDirectionDown) ||
            (valueTrend == kMeasurableValueTrendDown && valueTrendBetterDirection == kMeasurableValueTrendBetterDirectionUp)) {
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
