//
//  EHIChatManager.m
//  MobileSales
//
//  Created by dengwx on 17/2/19.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatManager.h"

@implementation EHIChatManager

static EHIChatManager *chatManager;
+ (EHIChatManager *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
       chatManager = [[EHIChatManager alloc] init];
    });
    return chatManager;
}

/**
 *  发送聊天
 */
- (void)sendMessage:(EHIMessage *)message
           progress:(void (^)(EHIMessage *, CGFloat))progress
            success:(void (^)(EHIMessage *))success
            failure:(void (^)(EHIMessage *))failure
{
    BOOL ok = [self.chatDAO addMessage:message];
    if (!ok) {
        NSLog(@"存储Message到DB失败");
    }else
    {
        NSLog(@"存储Message到DB成功");
    }
}

/**
 *  查询聊天记录
 */
- (void)messageRecordWithNodeID:(NSString *)nodeID
                       fromDate:(NSDate *)date
                          count:(NSUInteger)count
                       complete:(void (^)(NSArray *, BOOL))complete
{
    [self.chatDAO messagesByNodeID:nodeID fromDate:date count:count complete:^(NSArray *data, BOOL hasMore) {
        complete(data, hasMore);
    }];
}

/**
 *  添加到聊天列表
 */
- (BOOL)addMessage:(EHIMessage *)message
        toChatListNodeId:(NSString *)nodeId
            isRead:(BOOL)isRead{
    return [self.frameDAO addMessage:message
                    toChatListNodeId:nodeId
                              isRead:isRead];
}

/**
 *  添加到聊天列表
 */
- (EHIChatListModel *)updateChatListStateWithChatListModel:(EHIChatListModel *)chatList
{
    return [self.frameDAO updateChatListStateWithChatListModel:chatList];
}

/**
 *  更新聊天列表为已读
 */
- (BOOL)updateChatToReadWithNodeId:(NSString *)nodeId
{
    return [self.frameDAO updateChatToReadWithNodeId:nodeId];
}

- (BOOL)isMessageNoRead
{
    return [self.frameDAO isMessageNoRead];
}

/**
 *  更新消息的发送状态 并返回消息的nodeid
 */
- (NSString *)updateMessageSendStatusTo:(EHIMessageSendState)status
                          WithMessageID:(NSString *)messageID
{
    return [self.chatDAO updateMessageSendStatusTo:status
                                     WithMessageID:messageID];
}

/**
 *  查找所有的超时信息 返回
 */
- (void)messageSendTimeoutComplete:(void (^)(NSArray *data))complete
{
    [self.chatDAO messageSendTimeoutComplete:^(NSArray *data) {
        complete(data);
    }];
}

#pragma mark - Getter -
- (EHIDBChatDAO *)chatDAO
{
    if (_chatDAO == nil) {
        _chatDAO = [[EHIDBChatDAO alloc] init];
    }
    return _chatDAO;
}

- (EHIDBFrameDAO *)frameDAO
{
    if (!_frameDAO) {
        _frameDAO = [[EHIDBFrameDAO alloc] init];
    }
    return _frameDAO;
}


@end
