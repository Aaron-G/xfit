//
//  ShareDelegate.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/12/12.
//
//

#import "ShareDelegate.h"
#import "UIHelper.h"
#import "MailHelper.h"
#import "MailAttachment.h"


@implementation ShareDelegate

- init {
  self = [super init];
  
  if(self) {
    
    //Initialize
    _appViewController = [UIHelper appViewController];

  }
  
  return self;
}

//Subclass method - no operation implementation
- (void) share {
}

#pragma ActionSheetDelegate Helper methods

- (void)showActionSheetWithTitlePart:(NSString*) titlePart {
  
  UIActionSheet *actionSheet =
  [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"share-title", @"Share XXX"), titlePart]
                              delegate:self
                     cancelButtonTitle:NSLocalizedString(@"cancel-label", @"Cancel")
                destructiveButtonTitle:nil
                     otherButtonTitles:NSLocalizedString(@"share-facebook", @"Facebook"),
   NSLocalizedString(@"share-text", @"Message"),
   NSLocalizedString(@"share-email", @"Email"),
   nil];
  
  actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
  [actionSheet showInView:self.appViewController.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
  
  //CXB REVIEW_AND_IMPL
  //Facebook
  if (buttonIndex == 0) {
    NSLog(@"Facebook");
  }
  //Message
  else if (buttonIndex == 1) {
    [self displayTextMessageComposer];
  }
  //Email
  else if (buttonIndex == 2) {
    [self displayEmailComposer];
  }
  //Cancel
  else if (buttonIndex == 3) {
    //Nothing to do here
  }
}


#pragma MFMessageComposeViewControllerDelegate

- (void)displayTextMessageComposer {
  NSString * textMessage = self.textMessageText;
  if(textMessage) {
    [self displayTextMessageComposer: textMessage];
  }
}

//CXB_TODO
//Provide ability to include image on text message. PRWall and all charts need it
- (void)displayTextMessageComposer:(NSString *)bodyOfMessage
{
  MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
  
  if([MFMessageComposeViewController canSendText]) {
    controller.body = bodyOfMessage;
    controller.recipients = nil;
    controller.messageComposeDelegate = self;
    [self.appViewController presentViewController:controller animated:YES completion:nil];
  } else {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"cannot-share-title", @"Cannot Share")
                                                    message:NSLocalizedString(@"no-text-message-support-message", @"No text message support")
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"ok-label", @"OK")
                                          otherButtonTitles: nil];
    
    [alert show];
    
  }
}

#pragma MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
  
  [self.appViewController dismissViewControllerAnimated:YES completion:nil];
  
  //CXB REVIEW_AND_IMPL
  if (result == MessageComposeResultCancelled) {
    //    NSLog(@"Message cancelled");
  } else if (result == MessageComposeResultSent) {
    //    NSLog(@"Message sent");
  } else {
    //    NSLog(@"Message failed");
  }
}

#pragma MFMaileComposeViewControllerDelegate

- (void)displayEmailComposer {
  
  
  NSMutableDictionary* emailInfo = [[NSMutableDictionary alloc] initWithCapacity:5];
  [emailInfo setValue:self.emailSubject forKey:MailerHelperEmailSubjectKey];
  [emailInfo setValue:self.emailText forKey:MailerHelperEmailTextKey];
  [emailInfo setValue:@"yes" forKey:MailerHelperEmailTextIsHtmlKey];
  
  MailAttachment* attachment = nil;
  
  if(self.emailAttachmentData) {
    attachment = [[MailAttachment alloc]init];
    attachment.data = self.emailAttachmentData;
    attachment.mimeType = self.emailAttachmentMimeType;
    attachment.fileName = self.emailAttachmentFileName;

    [emailInfo setValue:[NSArray arrayWithObject:attachment] forKey:MailerHelperEmailAttachmentstKey];
  }
  
  [[MailHelper sharedInstance ] displayEmailComposerWithEmailInfo:emailInfo];
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
  //CXB REVIEW_AND_IMPL
  if(result == MFMailComposeResultCancelled) {
    //    NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
  } else if(result == MFMailComposeResultSaved) {
    //    NSLog(@"Mail saved: you saved the email message in the drafts folder.");
  } else if(result == MFMailComposeResultSent) {
    //    NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
  } else if(result == MFMailComposeResultFailed) {
    //    NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
  } else {
    //    NSLog(@"Mail not sent.");
  }
  
  // Remove the mail view
  [self.appViewController dismissViewControllerAnimated:YES completion:nil];
}

//Subclass method - no operation implementation
- (NSData *)emailAttachmentData {
  return nil;
}

- (NSString *)emailAttachmentMimeType {
  return @"image/png";
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  
  //Give a change to the user to pick something else
  if(NSOrderedSame == [alertView.title compare: NSLocalizedString(@"cannot-share-title", @"Cannot Share")]) {
    [self share];
  }
}

//CXB_IMPL
- (void)displayFacebookComposer {
  
}

@end
