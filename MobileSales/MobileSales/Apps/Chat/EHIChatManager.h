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
- (BOOL)updateChatToReadWithNodeLevel:(NSString *)nodeLevel
                           withNodeId:(NSString *)nodeId;

- (BOOL)isMessageNoRead;
@end
