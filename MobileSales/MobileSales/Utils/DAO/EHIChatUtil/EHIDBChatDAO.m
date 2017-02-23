//
//  EHIDBChatDAO.m
//  MobileSales
//
//  Created by dengwx on 17/2/15.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIDBChatDAO.h"
#import "EHIChatSQL.h"

#define TIMEOUT 30

@implementation EHIDBChatDAO

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [EHIDBManager sharedInstance].messageQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            NSLog(@"DB: 聊天记录表创建失败");
        }
    }
    return self;
}

- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_MESSAGE_TABLE, MESSAGE_TABLE_NAME];
    return [self createTable:MESSAGE_TABLE_NAME withSQL:sqlString];
}

- (BOOL)addMessage:(EHIMessage *)message
{    
    NSString *sqlString = [NSString stringWithFormat:SQL_ADD_MESSAGE, MESSAGE_TABLE_NAME];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        message.messageID,
                        message.nodeID,
                        [message.content mj_JSONString],
                        EHITimeStamp(message.date),
                        message.sendID,
                        message.sendName,
                        @"",
                        @"",
                        @(message.ownerTyper),
                        @(message.messageType),
                        @(message.sendState),
                        @"", @"", @"",
                        @"", @"", @"",nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    NSLog(@"插入聊天记录到数据库");
    return ok;
}

/**
 *  获取与某个好友的聊天记录
 */
- (void)messagesByNodeID:(NSString *)nodeID
                fromDate:(NSDate *)date
                   count:(NSUInteger)count
                complete:(void (^)(NSArray *data, BOOL hasMore))complete
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_MESSAGES_PAGE,
                           MESSAGE_TABLE_NAME,
                           nodeID,
                           [NSString stringWithFormat:@"%lf", date.timeIntervalSince1970],
                           (long)(count + 1)];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            EHIMessage *message = [self createDBMessageByFMResultSet:retSet];
            [data insertObject:message atIndex:0];
        }
        [retSet close];
    }];
    
    BOOL hasMore = NO;
    if (data.count == count + 1) {
        hasMore = YES;
        [data removeObjectAtIndex:0];
    }
    complete(data, hasMore);

}

/**
 *  更新消息发送状态 并返回消息的nodeid
 */
- (NSString *)updateMessageSendStatusTo:(EHIMessageSendState)status
                    WithMessageID:(NSString *)messageID
{
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_MESSAGE, MESSAGE_TABLE_NAME,status, messageID];
    BOOL ok = [self excuteSQL:sqlString , nil];
    NSLog(@"更新消息状态");
    if (ok) {
        NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_NODEID, MESSAGE_TABLE_NAME,messageID];
        
        __block NSString *nodeID ;
        [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *rsSet) {
            while ([rsSet next]) {
                nodeID = [rsSet stringForColumn:@"nodeid"];
                NSLog(@"查到nodeID%@",nodeID);
            }
            [rsSet close];
        }];
        return nodeID;
    }
    return nil;
}

/**
 *  查找所有的超时信息 返回
 */
- (void)messageSendTimeoutComplete:(void (^)(NSArray *data))complete
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_TIMEOUT_MESSAGE,
                           MESSAGE_TABLE_NAME,
                           EHIMessageSending,
                           [NSString stringWithFormat:@"%lf", [NSDate date].timeIntervalSince1970 - TIMEOUT]];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            EHIMessage *message = [self createDBMessageByFMResultSet:retSet];
            [data insertObject:message atIndex:0];
        }
        [retSet close];
    }];
    
    complete(data);

}
#pragma mark - Private Methods -
- (EHIMessage *)createDBMessageByFMResultSet:(FMResultSet *)retSet
{

    EHIMessage * message = [EHIMessage createMessageByType:EHIMessageTypeText];
    message.messageID = [retSet stringForColumn:@"msgid"];
    message.nodeID = [retSet stringForColumn:@"nodeID"];
    
    NSString *content = [retSet stringForColumn:@"content"];
    message.content = [[NSMutableDictionary alloc] initWithDictionary:[content mj_JSONObject]];
    
    NSString *dateString = [retSet stringForColumn:@"date"];
    message.date = [NSDate dateWithTimeIntervalSince1970:dateString.doubleValue];
    
    message.sendID = [retSet stringForColumn:@"sender_id"];
    message.sendName = [retSet stringForColumn:@"sender_name"];
    
    message.receivedID = [retSet stringForColumn:@"received_id"];
    message.receivedName = [retSet stringForColumn:@"received_name"];
    
    message.ownerTyper = [retSet intForColumn:@"own_type"];
    message.messageType = [retSet intForColumn:@"msg_type"];
    
    message.sendState = [retSet intForColumn:@"send_status"];
    message.readState = [retSet intForColumn:@"received_status"];
    return message;
}



@end
