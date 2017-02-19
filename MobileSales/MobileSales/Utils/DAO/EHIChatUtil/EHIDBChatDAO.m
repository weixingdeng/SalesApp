//
//  EHIDBChatDAO.m
//  MobileSales
//
//  Created by dengwx on 17/2/15.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIDBChatDAO.h"
#import "EHIChatSQL.h"

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
//    if (message == nil || message.messageID == nil || message.userID == nil || (message.friendID == nil && message.groupID == nil)) {
//        return NO;
//    }
    
//    NSString *fid = @"";
//    NSString *subfid;
//    if (message.partnerType == EHIPartnerTypeUser) {
//        fid = message.friendID;
//    }
//    else {
//        fid = message.groupID;
//        subfid = message.friendID;
//    }
    
    NSString *sqlString = [NSString stringWithFormat:SQL_ADD_MESSAGE, MESSAGE_TABLE_NAME];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        message.messageID,
                        message.nodeID,
                        [message.content mj_JSONString],
                        EHITimeStamp(message.date),
                        @"",@"", @"", @"", @"",
                        @"", @"", @"", @"", @"",
                        @"", @"", @"", @"",nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
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

#pragma mark - Private Methods -
- (EHIMessage *)createDBMessageByFMResultSet:(FMResultSet *)retSet
{
//    EHIMessageType type = [retSet intForColumn:@"msg_type"];
    EHIMessage * message = [EHIMessage createMessageByType:1];
    message.messageID = [retSet stringForColumn:@"msgid"];
//    message.userID = [retSet stringForColumn:@"uid"];
    
//    message.friendID = [retSet stringForColumn:@"fid"];
    message.nodeID = [retSet stringForColumn:@"nodeID"];
    
    NSString *dateString = [retSet stringForColumn:@"date"];
    message.date = [NSDate dateWithTimeIntervalSince1970:dateString.doubleValue];
    message.ownerTyper = [retSet intForColumn:@"own_type"];
    NSString *content = [retSet stringForColumn:@"content"];
    message.content = [[NSMutableDictionary alloc] initWithDictionary:[content mj_JSONObject]];
    message.sendState = [retSet intForColumn:@"send_status"];
    message.readState = [retSet intForColumn:@"received_status"];
    return message;
}



@end
