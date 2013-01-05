//
//  ActivityTagsEditViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/27/12.
//
//

#import <UIKit/UIKit.h>

@protocol ActivityTagsEditViewControllerDelegate <NSObject>

- (void) didChangeTags:(NSArray*) tags;

@end

@interface ActivityTagsEditViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property IBOutlet UITableView* tableView;
@property id<ActivityTagsEditViewControllerDelegate> delegate;

- (void) editTags:(NSArray*) tags;

@end
