//
//  MenuCell.m
//  CrossFitter
//
//  Created by Cleo Barretto on 8/10/12.
//
//
#import "MenuCell.h"

@implementation MenuCell

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button = button;

    CGRect rect = self.button.frame;
    rect.size.height = frame.size.height;
    rect.size.width = frame.size.width;
    self.button.frame = rect;
    
    [self.contentView addSubview:self.button];
  }
  return self;
}

@end
