//
//  EHIChatDetailViewController+Delegate.m
//  MobileSales
//
//  Created by dengwx on 17/2/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatDetailViewController+Delegate.h"
#import "EHIChatManager.h"
#import "NSString+EHIUUID.h"

@implementation EHIChatDetailViewController (Delegate)

#pragma mark keyboad代理
- (void)keyboardWillShow:(NSNotification *)notification
{
    [self.messageView scrollToBottomWithAnimation:YES];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
//    NSLog(@"---didshow---");
    [self.messageView scrollToBottomWithAnimation:YES];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
//    NSLog(@"---frame---");
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-keyboardFrame.size.height);
    }];
    [self.view layoutIfNeeded];
    [self.messageView scrollToBottomWithAnimation:YES];
}


- (void)keyboardWillHide:(NSNotification *)notification
{
      [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
    }];
    [self.view layoutIfNeeded];
}

//MARK: TLChatBarDelegate
// 发送文本消息
- (void)chatBar:(EHIChatBar *)chatBar sendText:(NSString *)text
{
    EHITextMessage *message = [[EHITextMessage alloc] init];
    message.text = text;
    
    //数据拼接
    message.messageID = [NSString createUUID];
    message.sendID = SHARE_USER_CONTEXT.user.user_id;
    message.sendName = SHARE_USER_CONTEXT.user.user_name;
    message.nodeID = self.listModel.NodeId;
    message.date = [NSDate date];
    message.showName = NO;
    
    message.messageType = EHIMessageTypeText;
    message.ownerTyper = EHIMessageOwnerTypeSelf;
    
    [self sendMessage:message];
    
}


#pragma mark EHIChatMessageDisplayViewDelegate
//发送message
- (void)addToShowMessage:(EHIMessage *)message
{
    message.showTime = [self needShowTime:message.date];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.messageView addMessage:message];
        [self.messageView scrollToBottomWithAnimation:YES];
    });
}

//点击消息背景 隐藏输入框
- (void)chatMessageDisplayViewDidTouched:(EHIChatMessageDisplayView *)chatTVC
{
    [self.chatBar.textView resignFirstResponder];
}

// chatView 获取历史记录
- (void)chatMessageDisplayView:(EHIChatMessageDisplayView *)chatTVC getRecordsFromDate:(NSDate *)date count:(NSUInteger)count completed:(void (^)(NSDate *, NSArray *, BOOL))completed
{
    [[EHIChatManager sharedInstance] messageRecordWithNodeID:self.listModel.NodeId
                                                    fromDate:date
                                                       count:count
                                                    complete:^(NSArray *array, BOOL hasMore) {
                                                            if (array.count > 0) {
                                                                int count = 0;
                                                                NSTimeInterval tm = 0;
                                                                for (EHIMessage *message in array) {
                                                                    if (++count > MAX_SHOWTIME_MSG_COUNT || tm == 0 || message.date.timeIntervalSince1970 - tm > MAX_SHOWTIME_MSG_SECOND) {
                                                                        tm = message.date.timeIntervalSince1970;
                                                                        count = 0;
                                                                        message.showTime = YES;
                                                                    }
                                                                }
                                                            }
                                                            completed(date, array, hasMore);
    }];
}

//发送信息
- (void)sendMessage:(EHIMessage *)message
{
    
    [self.socketManager sendMessageWithMessage:message];
    [self addToShowMessage:message];    // 添加到列表
    
    [[EHIChatManager sharedInstance] addMessage:message
                               toChatListNodeId:self.listModel.NodeId
                                         isRead:YES];
    
    [[EHIChatManager sharedInstance] sendMessage:message progress:^(EHIMessage * message, CGFloat pregress) {
        
    } success:^(EHIMessage * message) {
        NSLog(@"send success");
    } failure:^(EHIMessage * message) {
        NSLog(@"send failure");
    }];
}


//接到信息
- (void)receivedMessage:(EHIMessage *)message
{
    BOOL isRead = NO;
    if ([self.listModel.NodeId isEqualToString:message.nodeID]) {
        [self addToShowMessage:message];
        isRead = YES;
    }

    [[EHIChatManager sharedInstance] addMessage:message
                               toChatListNodeId:self.listModel.NodeId
                                         isRead:isRead];
    
    [[EHIChatManager sharedInstance] sendMessage:message
                                        progress:^(EHIMessage * message, CGFloat pregress) {
        
    } success:^(EHIMessage * message) {
        NSLog(@"send success");
    } failure:^(EHIMessage * message) {
        NSLog(@"send failure");
    }];


}

#pragma mark - # Private Methods
static NSTimeInterval lastDateInterval = 0;
static NSInteger msgAccumulate = 0;
- (BOOL)needShowTime:(NSDate *)date
{
    if (++msgAccumulate > MAX_SHOWTIME_MSG_COUNT || lastDateInterval == 0 || date.timeIntervalSince1970 - lastDateInterval > MAX_SHOWTIME_MSG_SECOND) {
        lastDateInterval = date.timeIntervalSince1970;
        msgAccumulate = 0;
        return YES;
    }
    return NO;
}



@end
