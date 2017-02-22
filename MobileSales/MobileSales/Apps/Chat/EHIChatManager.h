//
//  EHIChatManager.h
//  MobileSales
//
//  Created by dengwx on 17/2/19.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHIDBChatDAO.h"
#import "EHIDBFrameDAO.h"

@interface EHIChatManager : NSObject

+ (EHIChatManager *)sharedInstance;

@property (nonatomic, strong) EHIDBChatDAO *chatDAO;
@property (nonatomic, strong) EHIDBFrameDAO *frameDAO;
@property (nonatomic, strong, readonly) NSString *userID;

/**
 *  发送聊天
 */
- (void)sendMessage:(EHIMessage *)message
           progress:(void (^)(EHIMessage *, CGFloat))progress
            success:(void (^)(EHIMessage *))success
            failure:(void (^)(EHIMessage *))failure;

/**
 *  查询聊天记录
 */
- (void)messageRecordWithNodeID:(NSString *)nodeID
                       fromDate:(NSDate *)date
                          count:(NSUInteger)count
                       complete:(void (^)(NSArray *, BOOL))complete;

/**
 *  添加到聊天列表
 */
- (BOOL)addMessage:(EHIMessage *)message
  toChatListNodeId:(NSString *)nodeId
            isRead:(BOOL)isRead;
/**
 *  添加到聊天列表
 */
- (EHIChatListModel *)updateChatListStateWithChatListModel:(EHIChatListModel *)chatList;

/**
 *  更新聊天列表为已读
 */
- (BOOL)updateChatToReadWithNodeId:(NSString *)nodeId;

/**
 *  查询是否有未读信息
 */
- (BOOL)isMessageNoRead;

/**
 *  更新消息的发送状态 并返回消息的nodeid
 */
- (NSString *)updateMessageSendStatusTo:(EHIMessageSendState)status
                                        WithMessageID:(NSString *)messageID;

/**
 *  查找所有的超时信息 返回
 */
- (void)messageSendTimeoutComplete:(void (^)(NSArray *data))complete;

@end
