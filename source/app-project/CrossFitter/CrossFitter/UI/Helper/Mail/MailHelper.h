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
extern NSString* MailerHelperEmailSubjectKey;
/*
 A string with the email text/content
 */
extern NSString* MailerHelperEmailTextKey;
/*
 Possible values "yes" or "no". Defaults to "no"
 */
extern NSString* MailerHelperEmailTextIsHtmlKey;
/*
 An NSArray with instances of MailAttachment
 */
extern NSString* MailerHelperEmailAttachmentstKey;
/*
 A string with the FROM email address
 */
extern NSString* MailerHelperEmailFromKey;
/*
 A string with the TO email address
 */
extern NSString* MailerHelperEmailToKey;
/*
 A string with the CC email address
 */
extern NSString* MailerHelperEmailCCKey;
/*
 A string with the BCC email address
 */
extern NSString* MailerHelperEmailBCCKey;


- (void)displayEmailComposerWithEmailInfo: (NSDictionary*) emailInfo;

//Returns the shared instance of this MailHelper.
+ (MailHelper*) sharedInstance;


@end
