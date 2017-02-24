
//
//  UITableView+TLChat.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/18.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "UITableView+TLChat.h"

@implementation UITableView (TLChat)

- (void)scrollToBottomWithAnimation:(BOOL)animation
{
    CGFloat offsetY = self.contentSize.height > self.height - 64? self.contentSize.height - self.height : -(64);
    [self setContentOffset:CGPointMake(0, offsetY) animated:animation];
}

@end
