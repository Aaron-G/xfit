//
//  MailAttachment.h
//  CrossFitter
//
//  Created by Cleo Barretto on 8/16/12.
//
//

#import <Foundation/Foundation.h>

@interface MailAttachment : NSObject

@property NSData* data;
@property NSString* mimeType;
@property NSString* fileName;

@end
