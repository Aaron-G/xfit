//
//  InfoViewController.h
//  CrossFitter
//
//  Created by Cleo Barretto on 8/8/12.
//
//
#import "AppScreenSwitchDelegate.h"

@interface InfoViewController : UITableViewController

@property AppScreenSwitchDelegate* appScreenSwitchDelegate;

//Info Group
@property IBOutlet UILabel* aboutLabel;
@property IBOutlet UILabel* versionLabel;

//Share Group
@property IBOutlet UILabel* facebookLabel;
@property IBOutlet UILabel* messageLabel;
@property IBOutlet UILabel* emailLabel;

//Review Group
@property IBOutlet UILabel* rateAppLabel;

//Support Group
@property IBOutlet UILabel* featureLabel;
@property IBOutlet UILabel* feedbackLabel;
@property IBOutlet UILabel* issueLabel;

- (IBAction) shareAppEmail;
- (IBAction) shareAppTextMessage;
- (IBAction) shareAppFacebook;


@end
