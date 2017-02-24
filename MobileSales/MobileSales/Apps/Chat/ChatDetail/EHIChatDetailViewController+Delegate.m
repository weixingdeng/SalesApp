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
#import "EHIMyInfomationViewController.h"
#import <AudioToolbox/AudioToolbox.h>
@implementation EHIChatDetailViewController (Delegate)

#pragma mark keyboad代理
- (void)keyboardWillShow:(NSNotification *)notification
{
    [self.messageView scrollToBottomWithAnimation:YES];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    [self.messageView scrollToBottomWithAnimation:YES];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
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
    message.showName = message.ownerTyper == EHIMessageOwnerTypeSelf ? NO : YES;
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
                                                                    message.showName = message.ownerTyper == EHIMessageOwnerTypeSelf ? NO : YES;
                                                                }
                                                            }
                                                            completed(date, array, hasMore);
    }];
}

//发送信息
- (void)sendMessage:(EHIMessage *)message
{
    [[EHIChatManager sharedInstance] sendMessage:message progress:^(EHIMessage * message, CGFloat pregress) {
        
    } success:^(EHIMessage * message) {
        
    } failure:^(EHIMessage * message) {
        
    }];
    [[EHIChatManager sharedInstance] addMessage:message
                               toChatListNodeId:self.listModel.NodeId
                                         isRead:YES];
    
    [self addToShowMessage:message];    // 添加到列表
    
    [self.socketManager sendMessageWithMessage:message];
}


//接到信息
- (void)receivedMessage:(EHIMessage *)message
{
    BOOL isRead = NO;
    if ([self.listModel.NodeId isEqualToString:message.nodeID]) {
        [self addToShowMessage:message];
        isRead = YES;
    }else
    {
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);//震动
    }

    [[EHIChatManager sharedInstance] addMessage:message
                               toChatListNodeId:self.listModel.NodeId
                                         isRead:isRead];
    
    [[EHIChatManager sharedInstance] sendMessage:message
                                        progress:^(EHIMessage * message, CGFloat pregress) {
        
    } success:^(EHIMessage * message) {
        
    } failure:^(EHIMessage * message) {
        
    }];
}

//接到确认信息
- (void)receivedACKWithMessageId:(NSString *)messageId toSenderStatus:(EHIMessageSendState)status
{
    NSString *nodeId = [[EHIChatManager sharedInstance]
                        updateMessageSendStatusTo:status
                        WithMessageID:messageId];
    if (nodeId) {
        if (self.listModel.NodeId == nodeId) {
            for (EHIMessage *message in self.messageView.data) {
                if ([messageId isEqualToString:message.messageID]) {
                    message.sendState = status;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.messageView.chatDetailTable reloadData];
                    });
                    return;
                }
            }
        }
    }
}

//检查信息
- (void)messageStatusCheckComplete:(NSArray *)data
{
    for (EHIMessage *sendingMessage in data) {
       [self receivedACKWithMessageId:sendingMessage.messageID
                       toSenderStatus:EHIMessageSendFail];

    }
}

/**
 *  用户头像点击事件
 */
- (void)chatMessageDisplayView:(EHIChatMessageDisplayView *)chatTVC
         didClickMessageAvatar:(EHIMessage *)message
{
    //键盘消失
    [self.window endEditing:YES];
    
    //获取点击的cell的下标
    EHIMyInfomationViewController *infoVC = [[EHIMyInfomationViewController alloc] init];
    infoVC.userName = message.sendName;
    infoVC.userNo = message.sendID;
    infoVC.isOtherInfo = message.ownerTyper != EHIMessageOwnerTypeSelf;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:infoVC animated:YES];

}

/**
 *  重发消息点击事件
 */
- (void)chatMessageDisplayView:(EHIChatMessageDisplayView *)chatTVC
      didClickMessageSendAgain:(EHIMessage *)message
{
    WXAlertController *alert = [WXAlertController alertControllerWithTitle:nil message:@"重发该消息?" preferredStyle:WXAlertControllerStyleAlert];
    WXAlertAction *cancelAction = [WXAlertAction actionWithTitle:@"取消" style:WXAlertActionStyleCancel handler:nil];
    WXAlertAction *sendAgainAction = [WXAlertAction actionWithTitle:@"重发" style:WXAlertActionStyleDefault handler:^(WXAlertAction * _Nonnull action) {
        
        for (EHIMessage *sendMessage in self.messageView.data) {
            if ([message.messageID isEqualToString:sendMessage.messageID]) {
                [self.messageView.data removeObject:sendMessage];
                
                //更改消息状态
                message.sendState = EHIMessageSending;
                message.date = [NSDate date];
                [message resetMessageFrame];
                
                [self sendMessage:message];
                return;
            }
        }
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:sendAgainAction];
    
    [self presentViewController:alert animated:YES completion:nil];
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
