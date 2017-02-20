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
 *  获取有最后聊天信息的对话
 */
- (NSArray *)lastConversationByNodeId:(NSInteger)nodeID
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    return data;
    
}

#pragma mark - Getter -
- (EHIDBChatDAO *)chatDAO
{
    if (_chatDAO == nil) {
        _chatDAO = [[EHIDBChatDAO alloc] init];
    }
    return _chatDAO;
}


@end