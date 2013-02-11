//
//  UIHelper.m
//  PR Wall
//
//  Created by Cleo Barretto on 9/9/12.
//
//

#import "UIHelper.h"
#import "App.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppViewControllerSegue.h"
#import "ExerciseUnitValueDescriptor.h"

@implementation UIHelper

static NSDateFormatter* _appDateFormat;

+ (void) adjustImage: (UIButton*) buttonWithImage forMeasurable: (Measurable*) measurable {
  [UIHelper adjustImage: buttonWithImage
withMeasurableValueTrend: measurable.data.valueTrend
withMeasurableValueGoal: measurable.metadata.valueGoal];
}

+ (void) adjustImage: (UIButton*) buttonWithImage withMeasurableValueTrend: (MeasurableValueTrend) measurableValueTrend withMeasurableValueGoal: (MeasurableValueGoal) valueGoal {
  
  CGAffineTransform transform = CGAffineTransformIdentity;
  
  if(measurableValueTrend == MeasurableValueTrendNone) {
    buttonWithImage.hidden = YES;
    [buttonWithImage setImage:nil forState:UIControlStateNormal];
  } else {
    
    buttonWithImage.hidden = NO;
    
    MeasurableValueTrend valueTrend = measurableValueTrend;
    
    [buttonWithImage setImage:[UIHelper imageForValueTrend:valueTrend
                             withValueGoal:valueGoal]
                     forState:UIControlStateNormal];
    
    //Rotate the image appropriately to indicate proper
    //direction based on Metric goal
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

+ (UIImage*) imageForValueTrend: (MeasurableValueTrend) valueTrend withValueGoal: (MeasurableValueGoal) valueGoal {
  
  NSString* imageName = nil;
  
  //The user is not interested in tracking this
  if(valueGoal == MeasurableValueGoalNone) {
    return nil;
  }
  
  if((valueTrend == MeasurableValueTrendUp && valueGoal == MeasurableValueGoalMore) ||
     (valueTrend == MeasurableValueTrendDown && valueGoal == MeasurableValueGoalLess)) {
    imageName = @"goal-towards-icon";
  } else if((valueTrend == MeasurableValueTrendUp && valueGoal == MeasurableValueGoalLess) ||
            (valueTrend == MeasurableValueTrendDown && valueGoal == MeasurableValueGoalMore)) {
    imageName = @"goal-against-icon";
  } else if(valueTrend == MeasurableValueTrendSame) {
    imageName = @"goal-no-change-icon";
  }
  
  if(imageName) {
    return [UIImage imageNamed:imageName];
  } else {
    return nil;
  }
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
  return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

+ (NSUInteger)supportedInterfaceOrientationsWithLandscape {
  return [UIHelper supportedInterfaceOrientations] | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft;
}

+ (BOOL) isEmptyString:(NSString*) string {
  return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0;
}

+ (void)applyFontToSegmentedControl:(UISegmentedControl*) segmentedControl {
  UIFont* font = [UIFont boldSystemFontOfSize:14.0f];
  NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                         forKey:UITextAttributeFont];
  [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

+ (void) clearSelectionInTableView:(UITableView*) tableView afterDelay:(CGFloat) delay {
  
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    NSIndexPath *indexPath = [tableView indexPathForSelectedRow];
    if(indexPath != nil) {
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
  });
}

+ (void) showViewController:(UIViewController*) viewController asModal:(BOOL)modal withTransitionTitle:(NSString*) transitionTitle {
  
  AppViewControllerSegue* appViewControllerSegue =
  [[AppViewControllerSegue alloc] initWithIdentifier: transitionTitle
                                              source: [[UIHelper appViewController] navigationController].topViewController
                                         destination: viewController];
  appViewControllerSegue.modal = modal;
  [appViewControllerSegue perform];

}

+ (NSString*) generalNameForUnitType: (UnitType) type {
  
  if(type == UnitTypeLength) {
    return NSLocalizedString(@"unit-general-length-title", @"How far");
  } else if(type == UnitTypeMass) {
    return NSLocalizedString(@"unit-general-weight-title", @"How heavy");
  } else if(type == UnitTypeTime) {
    return NSLocalizedString(@"unit-general-time-title", @"How much time");
  } else  {
    return NSLocalizedString(@"unit-general-no-unit-title", @"How many");
  } 
}

+ (NSString*) stringForExerciseUnitValueDescriptors:(NSArray*) descriptors withSeparator:(NSString*) separator {
  
  NSMutableArray* descriptorsStrings = [NSMutableArray arrayWithCapacity:descriptors.count];
  
  for (ExerciseUnitValueDescriptor* descriptor in descriptors) {
    [descriptorsStrings addObject: [descriptor.unit.valueFormatter formatValue:descriptor.value]];
  }
  
  return [descriptorsStrings componentsJoinedByString:separator];
}


@end
