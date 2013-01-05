//
//  MediaPickerSupport.m
//  PR Wall
//
//  Created by Cleo Barretto on 12/30/12.
//
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "MediaPickerSupport.h"
#import "UIHelper.h"
#import "MediaHelper.h"
#import "MeasurableHelper.h"
#import "VideoThumbnailGenerator.h"

@interface MediaPickerSupport () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, VideoThumbnailGeneratorDelegate>

@property UIImagePickerController *imagePickerController;
@property UIImagePickerController *videoPickerController;

@property BOOL canPickImage;
@property BOOL canPickVideo;

@property NSMutableDictionary* videoThumbnailGenerators;

@end

@implementation MediaPickerSupport

- (id)init {
  self = [super init];
  
  if(self) {

    self.videoThumbnailGenerators = [NSMutableDictionary dictionary];

    /////////////////////////////////////////////////////////////////
    //Image Picker
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    self.imagePickerController.allowsEditing = YES;
    self.imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //Disable image picking if not available
    self.canPickImage = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    
    /////////////////////////////////////////////////////////////////
    //Video Picker
    self.videoPickerController = [[UIImagePickerController alloc] init];
    self.videoPickerController.delegate = self;
    self.videoPickerController.allowsEditing = YES;
    self.videoPickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    self.videoPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //Disable video picking if not available
    self.canPickVideo = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];    
  }
  
  return self;
}


///////////////////////////////////////////////////////////////////
//MEDIA PICKING
///////////////////////////////////////////////////////////////////

- (void)startPickingMediaAtIndexPath:(NSIndexPath *)indexPath {
  
  if(indexPath.section == self.delegate.imagesSection && indexPath.item == 0) {
    
    if(self.canPickImage) {
      [self startPickingImage];
    } else {
      [UIHelper showMessage:NSLocalizedString(@"no-image-support-message", @"Your device does not support images.")
                  withTitle:NSLocalizedString(@"cannot-add-picture-title", "Cannot Add Picture")];
    }
  } else if(indexPath.section == self.delegate.videosSection && indexPath.item == 0) {
    if(self.canPickVideo) {
      [self startPickingVideo];
    } else {
      [UIHelper showMessage:NSLocalizedString(@"no-video-support-message", @"Your device does not support videos.")
                  withTitle:NSLocalizedString(@"cannot-add-video-title", "Cannot Add Video")];
    }
  }
}

- (void) addImage:(UIImage*) image orVideo:(NSURL*) video inSection:(NSInteger) section {
  
  //1- Check if there is enough space
  NSString* errorMessageTitleKey = nil;
  
  if(image && ![MediaHelper enoughSpaceForImage:image]) {
    errorMessageTitleKey = @"cannot-add-picture-title";
  }
  
  if(video && ![MediaHelper enoughSpaceForVideo:video]) {
    errorMessageTitleKey = @"cannot-add-video-title";
  }
  
  if(errorMessageTitleKey) {
    [UIHelper showMessage:NSLocalizedString(@"no-space-in-device-message", @"Your device does not have enough space.")
                withTitle:NSLocalizedString(errorMessageTitleKey, "")];
    return;
  }
  
  NSArray* mediaArray = nil;
  NSURL* mediaURL = nil;
  
  MediaHelperPurpose mediaHelperPurpose = [MeasurableHelper mediaHelperPurposeForMeasurable:self.delegate.measurable];
  
  if(image) {
    
    mediaURL = [MediaHelper saveImage:image forPurpose:mediaHelperPurpose];
    if(mediaURL) {
      mediaArray = self.delegate.images;
    } else {
      errorMessageTitleKey = @"cannot-add-picture-title";
    }
  } else if(video) {
    mediaURL = [MediaHelper saveVideo:video forPurpose:mediaHelperPurpose];
    
    if(mediaURL) {
      mediaArray = self.delegate.videos;
      
      //Start loading the thumbnail
      //This seems to be the only way this works
      dispatch_async(dispatch_get_main_queue(), ^{
        VideoThumbnailGenerator* thumbnailGenerator = [[VideoThumbnailGenerator alloc] init];
        thumbnailGenerator.delegate = self;
        [thumbnailGenerator generateThumbnailForVideo:mediaURL.path];
        [self.videoThumbnailGenerators setObject:thumbnailGenerator forKey:mediaURL.path];
      });
      
    } else {
      errorMessageTitleKey = @"cannot-add-video-title";
    }
  }
  
  if(errorMessageTitleKey) {
    [UIHelper showMessage:NSLocalizedString(@"unexpected-problem-message", "There was an unexpected problem. If the problem persists, please contact us.")
                withTitle:NSLocalizedString(errorMessageTitleKey, "")];
    return;
  }
  
  //Find current number of images or videos - take into account the "+ add" row
  NSInteger numberOfMedia = mediaArray.count+1;
  
  //Update the data model
  NSMutableArray* updateArray = [NSMutableArray arrayWithArray:mediaArray];
  
  [updateArray addObject:mediaURL.path];
  
  //Update the appropriate data structure
  if(image) {
    self.delegate.images = updateArray;
  } else if (video) {
    self.delegate.videos = updateArray;
  }
  
  //Trigger UI update
  //
  //Update the insert index path array
  NSArray* indexPathsToInsert = [NSArray arrayWithObjects: [NSIndexPath indexPathForRow: numberOfMedia inSection:section], nil];
  
  //Actually perform the change
  [self.delegate.tableView beginUpdates];
  [self.delegate.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:UITableViewRowAnimationFade];
  [self.delegate.tableView endUpdates];
}

///////////////////////////////////////////////////////////////////
//IMAGE PICKING
///////////////////////////////////////////////////////////////////
- (IBAction) startPickingImage {
  [UIHelper showViewController:self.imagePickerController asModal:YES withTransitionTitle:@"To Image Picker"];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  
  if(picker == self.imagePickerController) {
    [self addImage:[info valueForKey:UIImagePickerControllerEditedImage] orVideo:nil inSection:self.delegate.imagesSection];
  } else if(picker == self.videoPickerController) {
    [self addImage:nil orVideo:[info valueForKey:UIImagePickerControllerMediaURL] inSection:self.delegate.videosSection];
  }
  
  [[self viewControllerToDismissForPicker:picker] dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [[self viewControllerToDismissForPicker:picker] dismissViewControllerAnimated:YES completion:nil];
}

- (UIViewController*) viewControllerToDismissForPicker:(UIImagePickerController *)picker {
  UIViewController* viewController = nil;
  if(picker == self.imagePickerController) {
    viewController = self.imagePickerController;
  } else if(picker == self.videoPickerController) {
    viewController = self.videoPickerController;
  }
  return viewController;
}

///////////////////////////////////////////////////////////////////
//VIDEO PICKING
///////////////////////////////////////////////////////////////////
- (IBAction) startPickingVideo {
  [UIHelper showViewController:self.videoPickerController asModal:YES withTransitionTitle:@"To Video Picker"];
}

- (void)didGenerateThumbnailForVideo:(NSString *)video {
  
  NSInteger rowForVideo = [self.delegate.videos indexOfObject:video];
  
  [self.videoThumbnailGenerators removeObjectForKey:video];
  
  [self.delegate.tableView reloadRowsAtIndexPaths: [NSArray arrayWithObject:[NSIndexPath indexPathForItem:(rowForVideo + 1) inSection:self.delegate.videosSection]] withRowAnimation: NO];
}

- (void)didNotGenerateThumbnailForVideo:(NSString*) video {  
}

@end
