//
//  MediaPickerSupport.h
//  PR Wall
//
//  Created by Cleo Barretto on 12/30/12.
//
//

#import <Foundation/Foundation.h>
#import "MeasurableLayoutViewController.h"

@protocol MediaPickerSupportDelegate <NSObject>

@property NSInteger imagesSection;
@property NSInteger videosSection;
@property NSArray* videos;
@property NSArray* images;
@property id<Measurable> measurable;
@property UIViewController* viewController;
@property UITableView* tableView;

@end

@interface MediaPickerSupport : NSObject

@property id<MediaPickerSupportDelegate> delegate;

- (void)startPickingMediaAtIndexPath:(NSIndexPath *)indexPath;

@end
