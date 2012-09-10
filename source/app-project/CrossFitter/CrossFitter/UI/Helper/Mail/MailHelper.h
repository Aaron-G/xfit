//
//  MailHelper.h
//  CrossFitter
//
//  Created by Cleo Barretto on 8/15/12.
//
//

#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MailHelper : NSObject <MFMailComposeViewControllerDelegate>

/*
 A string with the email subject
 */
extern NSString* kMailerHelperEmailSubjectKey;
/*
 A string with the email text/content
 */
extern NSString* kMailerHelperEmailTextKey;
/*
 Possible values "yes" or "no". Defaults to "no"
 */
extern NSString* kMailerHelperEmailTextIsHtmlKey;
/*
 An NSArray with instances of MailAttachment
 */
extern NSString* kMailerHelperEmailAttachmentstKey;
/*
 A string with the FROM email address
 */
extern NSString* kMailerHelperEmailFromKey;
/*
 A string with the TO email address
 */
extern NSString* kMailerHelperEmailToKey;
/*
 A string with the CC email address
 */
extern NSString* kMailerHelperEmailCCKey;
/*
 A string with the BCC email address
 */
extern NSString* kMailerHelperEmailBCCKey;


- (void)displayEmailComposerWithEmailInfo: (NSDictionary*) emailInfo;

//Returns the shared instance of this MailHelper.
+ (MailHelper*) sharedInstance;


@end
