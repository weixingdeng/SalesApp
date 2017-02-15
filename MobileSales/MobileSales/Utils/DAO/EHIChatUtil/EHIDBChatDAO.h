//
//  EHIDBChatDAO.h
//  MobileSales
//
//  Created by dengwx on 17/2/15.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHIDBBaseDAO.h"

@interface EHIDBChatDAO : EHIDBBaseDAO

/**
 *  添加消息记录
 */
- (BOOL)addMessage:(NSString *)message;

/**
 *  获取与某个好友的聊天记录
 */
- (void)messagesByUserID:(NSString *)userID
                  nodeID:(NSString *)nodeID
                fromDate:(NSDate *)date
                   count:(NSUInteger)count
                complete:(void (^)(NSArray *data, BOOL hasMore))complete;

/**
 *  最后一条聊天记录（消息页用）
 */
- (NSString *)lastMessageByUserID:(NSString *)userID
                           nodeID:(NSString *)nodeID;

@end
