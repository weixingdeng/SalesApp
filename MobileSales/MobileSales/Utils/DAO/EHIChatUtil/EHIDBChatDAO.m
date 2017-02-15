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

- (BOOL)addMessage:(NSString *)message
{
//    if (message == nil || message.messageID == nil || message.userID == nil || (message.friendID == nil && message.groupID == nil)) {
//        return NO;
//    }
    
//    NSString *fid = @"";
//    NSString *subfid;
//    if (message.partnerType == TLPartnerTypeUser) {
//        fid = message.friendID;
//    }
//    else {
//        fid = message.groupID;
//        subfid = message.friendID;
//    }
    
    NSString *sqlString = [NSString stringWithFormat:SQL_ADD_MESSAGE, MESSAGE_TABLE_NAME];
//    NSArray *arrPara = [NSArray arrayWithObjects:
//                        message.messageID,
//                        message.userID,
//                        fid,
//                        TLNoNilString(subfid),
//                        TLTimeStamp(message.date),
//                        [NSNumber numberWithInteger:message.partnerType],
//                        [NSNumber numberWithInteger:message.ownerTyper],
//                        [NSNumber numberWithInteger:message.messageType],
//                        [message.content mj_JSONString],
//                        [NSNumber numberWithInteger:message.sendState],
//                        [NSNumber numberWithInteger:message.readState],
//                        @"", @"", @"", @"", @"", nil];
//    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:nil];
    return ok;
}


@end
