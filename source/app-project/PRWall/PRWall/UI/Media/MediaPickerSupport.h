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
@property (readonly) NSArray* videos;
@property (readonly) NSArray* images;
@property Measurable* measurable;
@property UIViewController* viewController;
@property UITableView* tableView;

- (void)pickedImage:(NSString*) path atIndexPath:(NSIndexPath *)indexPath;
- (void)pickedVideo:(NSString*) path atIndexPath:(NSIndexPath *)indexPath;

@end

@interface MediaPickerSupport : NSObject

@property id<MediaPickerSupportDelegate> delegate;

- (void)startPickingMediaAtIndexPath:(NSIndexPath *)indexPath;

@end
