//
//  ShareDelegate.h
//  CrossFitter
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import <Foundation/Foundation.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "AppViewController.h"
@class AppViewController;

@interface ShareDelegate : NSObject <UIActionSheetDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate, UIAlertViewDelegate>

- initWithViewController: (UIViewController*) viewController;

@property (readonly) UIViewController * viewController;
@property (readonly) AppViewController * appViewController;

//ActionSheet
- (void)showActionSheetWithTitlePart:(NSString*) titlePart;

//Sharing
- (void)share;

//Text Message
@property (readonly) NSString * textMessageText;

//Email
@property (readonly) NSString * emailText;
@property (readonly) NSString * emailSubject;
@property (readonly) NSData * emailAttachmentData;
@property (readonly) NSString * emailAttachmentFileName;
@property (readonly) NSString * emailAttachmentMimeType;

////////////////////////////////////////////////////////////////////////////////
//Subclasses
////////////////////////////////////////////////////////////////////////////////
- (void)displayEmailComposer;
- (void)displayTextMessageComposer;
- (void)displayFacebookComposer;

@end
