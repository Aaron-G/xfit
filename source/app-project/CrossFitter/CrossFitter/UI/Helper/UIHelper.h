//
//  UIHelper.h
//  CrossFitter
//
//  Created by Cleo Barretto on 9/9/12.
//
//

#import <Foundation/Foundation.h>
#import "Measurable.h"

@interface UIHelper : NSObject

+ (CGAffineTransform) adjustImage: (UIButton*) buttonWithImage forMeasurable: (id <Measurable>) measurable;

@end
