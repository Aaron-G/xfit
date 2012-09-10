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
#import "AppScreenShareDelegate.h"
#import "MyBodyScreenShareDelegate.h"
#import "MyBodyUserInfoTableViewCell.h"
#import "MyBodyMetricTableViewCell.h"
#import "ModelFactory.h"
#import "BodyMetric.h"
#import "UIHelper.h"

@interface MyBodyViewController () {
}

@property AppViewController* appViewController;
@property AppScreenShareDelegate* appScreenShareDelegate;

@property UserProfile* userProfile;

@end

@implementation MyBodyViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self) {
    self.appScreenSwitchDelegate = [[MyBodyScreenSwitchDelegate alloc]initWithViewController:self];
    self.appScreenShareDelegate = [[MyBodyScreenShareDelegate alloc]initWithViewController:self];
    self.appViewController = [[App sharedInstance] appViewController];
    self.userProfile = [ModelFactory createUserProfile];
  }
  
  return self;
}

-(void)viewDidLoad {
  
  //Register custom cell
  [self.tableView registerNib: [UINib nibWithNibName:@"MyBodyMetricTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyBodyMetricTableViewCell"];
  [self.tableView registerNib: [UINib nibWithNibName:@"MyBodyUserInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyBodyUserInfoTableViewCell"];
  
  [super viewDidLoad];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //Personal Info section
  if((indexPath.section == 0) && (indexPath.item == 0)) {
    MyBodyUserInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyBodyUserInfoTableViewCell"];
    
    cell.userProfileSummaryLabel.text = [NSString stringWithFormat:
                                         NSLocalizedString(@"mybody-user-profile-summary-format", @"%@\n%@, %@\n%@"),
                                         self.userProfile.name,
                                         self.userProfile.sex,
                                         self.userProfile.age,
                                         self.userProfile.box];
    
    cell.userProfileImageButton.titleLabel.text = NSLocalizedString(@"mybody-user-profile-add-photo-label", @"Add Photo");

    return cell;
  }

  BodyMetricIdentifier metricIdentifier = [self metricIdentifierIndexPath:indexPath];
  if(metricIdentifier != kBodyMetricIdentifierInvalid) {
    
    MyBodyMetricTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyBodyMetricTableViewCell"];
    
    BodyMetric* metric = [self.userProfile.metrics valueForKey: [BodyMetric nameForBodyMetricIdentifier:metricIdentifier]];
    cell.metricNameLabel.text = metric.name;
    
    //CXB CONTINUE - IMPL CONVERTER HERE
    cell.metricValueLabel.text = [NSString stringWithFormat:@"%f", metric.value];

    //Adjust the trend image to tailor to the metric specifics
    [UIHelper adjustImage:cell.metricTrendImageButton forMeasurable:metric];
    
    return cell;
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

- (BodyMetricIdentifier) metricIdentifierIndexPath: (NSIndexPath *)indexPath {
  
  if(indexPath.section == 1) {
    if(indexPath.item == 0) {
      return kBodyMetricIdentifierHeight;
    } else if(indexPath.item == 1) {
      return kBodyMetricIdentifierWeight;
    }
  } else if(indexPath.section == 2) {
    if(indexPath.item == 0) {
      return kBodyMetricIdentifierBodyMassIndex;
    } else if(indexPath.item == 1) {
      return kBodyMetricIdentifierBodyFat;
    }
  } else if(indexPath.section == 3) {
    if(indexPath.item == 0) {
      return kBodyMetricIdentifierChest;
    } else if(indexPath.item == 1) {
      return kBodyMetricIdentifierBiceptsRight;
    } else if(indexPath.item == 2) {
      return kBodyMetricIdentifierBiceptsLeft;
    }
  } else if(indexPath.section == 4) {
    if(indexPath.item == 0) {
      return kBodyMetricIdentifierWaist;
    } else if(indexPath.item == 1) {
      return kBodyMetricIdentifierHip;
    }
  } else if(indexPath.section == 5) {
    if(indexPath.item == 0) {
      return kBodyMetricIdentifierThighRight;
    } else if(indexPath.item == 1) {
      return kBodyMetricIdentifierThighLeft;
    } else if(indexPath.item == 2) {
      return kBodyMetricIdentifierCalfRight;
    } else if(indexPath.item == 3) {
      return kBodyMetricIdentifierCalfLeft;
    }
  }

  return kBodyMetricIdentifierInvalid;
}

//Add proper behavior to cell selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"Group: %d Row: %d", indexPath.section, indexPath.item);
  
//  NSInteger selectedIndex = indexPath.item;
//  
//  //Share Section
//  if(indexPath.section == 1) {
//    
//    if (selectedIndex == 0) {
//      [self shareAppFacebook];
//    } else if (selectedIndex == 1) {
//      [self shareAppTextMessage];
//    } else if (selectedIndex == 2) {
//      [self shareAppEmail];
//    }
//  }
//  //Review Section
//  else if(indexPath.section == 2) {
//    
//    if (selectedIndex == 0) {
//      [self rateApp];
//    }
//  }
//  //Support Section
//  else if(indexPath.section == 3) {
//    
//    if (selectedIndex == 0) {
//      [self requestFeature];
//    } else if (selectedIndex == 1) {
//      [self provideFeedback];
//    } else if (selectedIndex == 2) {
//      [self reportIssue];
//    }
//  }
}

- (void)shareMyBodyAction {
  [self.appScreenShareDelegate share];
}


@end
