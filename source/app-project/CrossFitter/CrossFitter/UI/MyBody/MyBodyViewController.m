//
//  MyBodyViewController.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/8/12.
//
//

#import "MyBodyViewController.h"
#import "AppViewController.h"
#import "MyBodyScreenSwitchDelegate.h"
#import "App.h"
#import "ShareDelegate.h"
#import "MyBodyScreenShareDelegate.h"
#import "MyBodyUserProfileTableViewCell.h"
#import "MeasurableTableViewCell.h"
#import "ModelFactory.h"
#import "BodyMetric.h"
#import "UIHelper.h"
#import "AppViewControllerSegue.h"
#import "MeasurableHelper.h"
#import "UserProfileViewController.h"

@interface MyBodyViewController () {
}

@property AppViewController* appViewController;
@property ShareDelegate* appScreenShareDelegate;

@end

@implementation MyBodyViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self) {
    self.appScreenSwitchDelegate = [[MyBodyScreenSwitchDelegate alloc]initWithViewController:self];
    self.appScreenShareDelegate = [[MyBodyScreenShareDelegate alloc]init];
    self.appViewController = [UIHelper appViewController];
  }
  
  return self;
}

-(void)viewDidLoad {
  
  //Register custom cell
  [self.tableView registerNib: [UINib nibWithNibName:@"MeasurableTableViewCell" bundle:nil] forCellReuseIdentifier:@"MeasurableTableViewCell"];
  [self.tableView registerNib: [UINib nibWithNibName:@"MyBodyUserProfileTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyBodyUserProfileTableViewCell"];
  
  [super viewDidLoad];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //Personal Info section
  if((indexPath.section == 0) && (indexPath.item == 0)) {
    MyBodyUserProfileTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyBodyUserProfileTableViewCell"];
    UserProfile* userProfile = [App sharedInstance].userProfile;
    
    NSString* sexText = @"";
    if(userProfile.sex == UserProfileSexMale) {
      sexText = NSLocalizedString(@"male-label", @"Male");
    } else if(userProfile.sex == UserProfileSexFemale) {
      sexText = NSLocalizedString(@"female-label", @"Female");
    }

    if(userProfile.name.length) {
      
      cell.userProfileSummaryLabel.text = [NSString stringWithFormat:
                                           NSLocalizedString(@"mybody-user-profile-summary-format", @"%@\n%@, %@\n%@"),
                                           [App sharedInstance].userProfile.name,
                                           sexText,
                                           [App sharedInstance].userProfile.age,
                                           [App sharedInstance].userProfile.box];
      
    } else {
      cell.userProfileSummaryLabel.text = [NSString stringWithFormat:
                                           NSLocalizedString(@"mybody-user-profile-summary-no-name-format", @"%@, %@\n%@"),
                                           sexText,
                                           [App sharedInstance].userProfile.age,
                                           [App sharedInstance].userProfile.box];
    }
    
    cell.userProfileImageButton.titleLabel.text = NSLocalizedString(@"mybody-user-profile-add-photo-label", @"Add Photo");

    return cell;
  }

  NSString* metricIdentifier = [self metricIdentifierIndexPath:indexPath];
  if(metricIdentifier != BodyMetricIdentifierInvalid) {
    
    BodyMetric* metric = [[App sharedInstance].userProfile.metrics valueForKey: metricIdentifier];
    return [MeasurableHelper tableViewCellForMeasurable:metric inTableView:tableView];
  } else {
    return [super tableView: tableView cellForRowAtIndexPath:indexPath];
  }
}

//Localize the table section titles
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  
  if(section == 0 || section == 2) {
    return @"";
  } else if(section == 1) {
    return NSLocalizedString(@"mybody-section-title-body", @"Body");
  } else if(section == 3) {
    return NSLocalizedString(@"mybody-section-title-upper", @"Upper");
  } else if(section == 4) {
    return NSLocalizedString(@"mybody-section-title-torso", @"Torso");
  } else if(section == 5) {
    return NSLocalizedString(@"mybody-section-title-lower", @"Lower");
  } else {
    return [super tableView:tableView titleForHeaderInSection:section];
  }
}

- (NSString*) metricIdentifierIndexPath: (NSIndexPath *)indexPath {
  
  if(indexPath.section == 1) {
    if(indexPath.item == 0) {
      return BodyMetricIdentifierHeight;
    } else if(indexPath.item == 1) {
      return BodyMetricIdentifierWeight;
    }
  } else if(indexPath.section == 2) {
    if(indexPath.item == 0) {
      return BodyMetricIdentifierBodyMassIndex;
    } else if(indexPath.item == 1) {
      return BodyMetricIdentifierBodyFat;
    }
  } else if(indexPath.section == 3) {
    if(indexPath.item == 0) {
      return BodyMetricIdentifierChest;
    } else if(indexPath.item == 1) {
      return BodyMetricIdentifierBiceptsRight;
    } else if(indexPath.item == 2) {
      return BodyMetricIdentifierBiceptsLeft;
    }
  } else if(indexPath.section == 4) {
    if(indexPath.item == 0) {
      return BodyMetricIdentifierWaist;
    } else if(indexPath.item == 1) {
      return BodyMetricIdentifierHip;
    }
  } else if(indexPath.section == 5) {
    if(indexPath.item == 0) {
      return BodyMetricIdentifierThighRight;
    } else if(indexPath.item == 1) {
      return BodyMetricIdentifierThighLeft;
    } else if(indexPath.item == 2) {
      return BodyMetricIdentifierCalfRight;
    } else if(indexPath.item == 3) {
      return BodyMetricIdentifierCalfLeft;
    }
  }

  return BodyMetricIdentifierInvalid;
}

//Add proper behavior to cell selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if(indexPath.section == 0 && indexPath.item == 0) {
    
    UserProfileViewController* userProfileViewController = [UIHelper userProfileViewController];
    userProfileViewController.myBodyViewController = self;
    
    AppViewControllerSegue* appViewControllerSegue =
    [[AppViewControllerSegue alloc] initWithIdentifier:@"My Body to User Profile"
                                                source:self
                                           destination:userProfileViewController];
    
    [appViewControllerSegue perform];
    
  } else {
    NSString* metricIdentifier = [self metricIdentifierIndexPath:indexPath];
    
    if(metricIdentifier != BodyMetricIdentifierInvalid) {
      
      BodyMetric* metric = [[App sharedInstance].userProfile.metrics valueForKey: metricIdentifier];
      
      MeasurableViewController* measurableViewController = [UIHelper measurableViewController];
      measurableViewController.measurable = metric;
      
      AppViewControllerSegue* appViewControllerSegue =
      [[AppViewControllerSegue alloc] initWithIdentifier:@"My Body to Body Metric"
                                                  source:self
                                             destination:measurableViewController];
      
      [appViewControllerSegue perform];
    }
  }
}

- (void)shareMyBodyAction {
  [self.appScreenShareDelegate share];
}


@end
