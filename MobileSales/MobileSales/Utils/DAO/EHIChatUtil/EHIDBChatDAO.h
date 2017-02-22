//
//  EHIDBChatDAO.h
//  MobileSales
//
//  Created by dengwx on 17/2/15.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHIDBBaseDAO.h"
#import "EHIMessage.h"

@interface EHIDBChatDAO : EHIDBBaseDAO

/**
 *  添加消息记录
 */
- (BOOL)addMessage:(EHIMessage *)message;

/**
 *  获取与某个好友的聊天记录
 */
- (void)messagesByNodeID:(NSString *)nodeID
                fromDate:(NSDate *)date
                   count:(NSUInteger)count
                complete:(void (^)(NSArray *data, BOOL hasMore))complete;

/**
 *  更新消息发送状态 并返回消息的nodeid
 */
- (NSString *)updateMessageSendStatusTo:(EHIMessageSendState)status
                    WithMessageID:(NSString *)messageID;


@end
