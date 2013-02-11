//
//  MeasurableTagsEditViewController.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/27/12.
//
//

#import <UIKit/UIKit.h>

@protocol MeasurableTagsEditViewControllerDelegate <NSObject>

- (void) didChangeTags:(NSArray*) tags;

@end

@interface MeasurableTagsEditViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property IBOutlet UITableView* tableView;
@property id<MeasurableTagsEditViewControllerDelegate> delegate;

- (void) editTags:(NSArray*) tags;

@end
