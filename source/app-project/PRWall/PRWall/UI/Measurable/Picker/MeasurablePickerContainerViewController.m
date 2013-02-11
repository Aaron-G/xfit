//
//  MeasurablePickerContainerViewController.m
//  PR Wall
//
//  Created by Cleo Barretto on 1/3/13.
//
//

#import "MeasurablePickerContainerViewController.h"
#import "MeasurablePickerCollectionViewController.h"
#import "UIHelper.h"

@interface MeasurablePickerContainerViewController ()

@property (readonly) MeasurablePickerCollectionViewController* measurablePickerCollectionViewController;

@property id<MeasurablePickerDelegate> delegate;
@property NSArray* measurables;
@property MeasurableCategory* measurableCategory;

@end

@implementation MeasurablePickerContainerViewController

@synthesize measurablePickerCollectionViewController = _measurablePickerCollectionViewController;

- (MeasurablePickerCollectionViewController *)measurablePickerCollectionViewController {
  if(!_measurablePickerCollectionViewController) {
    for (UIViewController * viewController in self.childViewControllers) {
      if([viewController isKindOfClass: [MeasurablePickerCollectionViewController class]]) {
        _measurablePickerCollectionViewController = (MeasurablePickerCollectionViewController*)viewController;
      }
    }
  }
  return _measurablePickerCollectionViewController;
}

- (void) pickMeasurableOfCategory:(MeasurableCategory*) measurableCategory fromMeasurables:(NSArray*) measurables withTitle:(NSString*) title withDelegate:(id<MeasurablePickerDelegate>) delegate {
  
  self.measurableCategory = measurableCategory;
  self.title = title;
  self.measurables = measurables;
  self.delegate = delegate;
  
  [UIHelper showViewController:self asModal:NO withTransitionTitle:title];
}

-(void)viewDidLoad {
  
  [super viewDidLoad];
  
  //Pass on reference to Page Control
  self.measurablePickerCollectionViewController.pickerPageControl = self.pageControl;
  
  //Delegate the call
  [self.measurablePickerCollectionViewController pickMeasurableOfType:self.measurableCategory fromMeasurables:self.measurables withDelegate:self.delegate];  
}

- (NSUInteger)supportedInterfaceOrientations {
  return [UIHelper supportedInterfaceOrientations];
}

@end
