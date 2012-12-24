//
//  ShareDelegate.h
//  PR Wall
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

@property UIViewController * viewController;

@property BOOL modalScreenDisplayed;

//ActionSheet
- (void)showActionSheetWithTitlePart:(NSString*) titlePart;
- (void)showActionSheetWithTitlePart:(NSString*) titlePart fromToolBar: (UIToolbar*) toolbar;

//Sharing
- (void)share;
- (void) shareFromToolBar:(UIToolbar*) toolbar;

//Text Message
@property (readonly) NSString * textMessageText;

//Email
@property (readonly) NSString * emailText;
@property (readonly) NSString * emailSubject;
@property (readonly) NSData * emailAttachmentData;
@property (readonly) NSString * emailAttachmentFileName;
@property (readonly) NSString * emailAttachmentMimeType;

//Facebook
@property (readonly) UIImage * facebookImage;
@property (readonly) NSString * facebookMessage;
@property (readonly) NSURL * facebookURL;

//Twitter
@property (readonly) UIImage * twitterImage;
@property (readonly) NSString * twitterMessage;
@property (readonly) NSURL * twitterURL;

////////////////////////////////////////////////////////////////////////////////
//Subclasses
////////////////////////////////////////////////////////////////////////////////
- (void)displayEmailComposer;
- (void)displayTextMessageComposer;
- (void)displayFacebookComposer;
- (void)displayTwitterComposer;

@end
