//
//  EHIChatManager.h
//  MobileSales
//
//  Created by dengwx on 17/2/19.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHIDBChatDAO.h"

@interface EHIChatManager : NSObject

+ (EHIChatManager *)sharedInstance;

@property (nonatomic, strong) EHIDBChatDAO *chatDAO;
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
 *  获取有最后聊天信息的对话
 */
- (NSArray *)lastConversationByNodeId:(NSInteger)nodeID;

@end
