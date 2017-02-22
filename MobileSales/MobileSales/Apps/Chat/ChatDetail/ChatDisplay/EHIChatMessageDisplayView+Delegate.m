//
//  EHIChatMessageDisplayView+Delegate.m
//  MobileSales
//
//  Created by dengwx on 17/2/17.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatMessageDisplayView+Delegate.h"

@implementation EHIChatMessageDisplayView (Delegate)

#pragma mark - # Public Methods
- (void)registerCellClassForTableView:(UITableView *)tableView
{
    [tableView registerClass:[EHITextMessageCell class] forCellReuseIdentifier:@"EHITextMessageCell"];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"EmptyCell"];
}

//tableView每组的单元格数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

//具体单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EHIMessage * message = self.data[indexPath.row];
    if (message.messageType == EHIMessageTypeText) {
        EHITextMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EHITextMessageCell"];
        [cell setMessage:message];
        [cell setDelegate:self];
        return cell;
    }
    
    return [tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];
}

//d点击头像
- (void)messageCellDidClickAvatarForMessage:(EHIMessage *)message
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayView:didClickMessageAvatar:)]) {
        [self.delegate chatMessageDisplayView:self
                        didClickMessageAvatar:message];
    }
}

//点击重发
- (void)messageCellDidClickSendAgainForMessage:(EHIMessage *)message
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayView:didClickMessageSendAgain:)]) {
        [self.delegate chatMessageDisplayView:self
                        didClickMessageAvatar:message];
    }
}

#error mark
//获取view的顶级vc
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    EHIMessage * message = self.data[indexPath.row];
    return message.messageFrame.height;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.window endEditing:YES];
}


@end
