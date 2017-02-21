//
//  EHIDBFrameDAO.m
//  MobileSales
//
//  Created by dengwx on 17/2/21.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIDBFrameDAO.h"
#import "EHIDBManager.h"
#import "EHIFrameSQL.h"

@implementation EHIDBFrameDAO

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [EHIDBManager sharedInstance].messageQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            NSLog(@"DB: 聊天列表创建失败");
        }else
        {
            NSLog(@"DB: 聊天列表创建成功");
        }
    }
    return self;
}

- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_FRAME_TABLE, FRAME_TABLE_NAME];
    return [self createTable:FRAME_TABLE_NAME withSQL:sqlString];
}

//添加信息到 聊天记录
- (BOOL)addMessage:(EHIMessage *)message
  toChatListNodeId:(NSString *)nodeId
            isRead:(BOOL)isRead;
{
    NSString *sqlString = [NSString stringWithFormat:SQL_ADD_CONVERSATION, FRAME_TABLE_NAME];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        @"0",
                        message.nodeID,
                        message.date,
                        [message.content mj_JSONString],
                        @(isRead),
                        message.sendName,
                        @"", @"", @"", @"", @"",nil];
    
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    if (!ok) {
        NSLog(@"DB: 聊天列表插入失败");
    }else
    {
        NSLog(@"DB: 聊天列表插入成功");
    }
    return ok;
}

//查询是否有未读聊天信息
- (BOOL)isMessageNoRead
{
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_NOREAD_MESSAGE, FRAME_TABLE_NAME,0];
    
    __block BOOL hasNoRead = NO;
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *rsSet) {
        while ([rsSet next]) {
            hasNoRead = YES;
        }
        [rsSet close];
    }];
    return hasNoRead;

}


//更新聊天列表的状态 获取最新聊天列表
- (EHIChatListModel *)updateChatListStateWithChatListModel:(EHIChatListModel *)chatList
{
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_CONVERSATION_INFO, FRAME_TABLE_NAME,chatList.NodeId];
     __block EHIChatListModel *newChatList = chatList;
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *rsSet) {
        BOOL hasResult = NO;
        while ([rsSet next]) {
            hasResult = YES;
            newChatList = [self createDBFrameByFMResultSet:rsSet
                                          withBaseChatList:chatList];
        }
        if (!hasResult) {
            newChatList.isRead = YES;
        }
        [rsSet close];
    }];
    
    return newChatList;
    
}

//更新聊天列表为已读
- (BOOL)updateChatToReadWithNodeId:(NSString *)nodeId
{
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_ISREAD, FRAME_TABLE_NAME, 1, nodeId];
    BOOL ok = [self excuteSQL:sqlString , nil];
    return ok;
}

//在原有model基础上扩展属性
- (EHIChatListModel *)createDBFrameByFMResultSet:(FMResultSet *)reSet
                                withBaseChatList:(EHIChatListModel *)chatList
{
    chatList.content = [reSet stringForColumn:@"Content"];
    chatList.date = [reSet dateForColumn:@"Date"];
    chatList.isRead = [reSet boolForColumn:@"IsRead"];
    chatList.senderName = [reSet stringForColumn:@"SenderName"];
    return chatList;
    
}




@end
