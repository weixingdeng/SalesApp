//
//  EHIChatSQL.h
//  MobileSales
//
//  Created by dengwx on 17/2/15.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#ifndef EHIChatSQL_h
#define EHIChatSQL_h

#define     MESSAGE_TABLE_NAME              @"message"

//创建表
#define     SQL_CREATE_MESSAGE_TABLE        @"CREATE TABLE IF NOT EXISTS %@(\
                                                msgid TEXT,\
                                                nodeid TEXT,\
                                                date TEXT,\
                                                sender_id TEXT,\
                                                sender_name TEXT,\
                                                received_id TEXT,\
                                                received_name TEXT,\
                                                own_type INTEGER DEFAULT (0),\
                                                msg_type INTEGER DEFAULT (0),\
                                                content TEXT,\
                                                send_status INTEGER DEFAULT (0),\
                                                received_status BOOLEAN DEFAULT (0),\
                                                ext1 TEXT,\
                                                ext2 TEXT,\
                                                ext3 TEXT,\
                                                ext4 TEXT,\
                                                ext5 TEXT,\
                                                PRIMARY KEY(msgid))"
//添加消息
#define     SQL_ADD_MESSAGE                 @"REPLACE INTO %@ (\
                                                msgid,\
                                                nodeid,\
                                                content,\
                                                date,\
                                                sender_id,\
                                                sender_name,\
                                                received_id,\
                                                received_name,\
                                                own_type,\
                                                msg_type,\
                                                send_status,\
                                                received_status,\
                                                ext1,\
                                                ext2,\
                                                ext3,\
                                                ext4,\
                                                ext5)\
                                                VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"

//查找记录
#define     SQL_SELECT_MESSAGES_PAGE        @"SELECT * FROM %@ WHERE nodeid = '%@' and\
                                            date < '%@'\
                                            order by date desc LIMIT '%ld'"

//更新消息状态
#define     SQL_UPDATE_MESSAGE         @"UPDATE %@ SET send_status = %d WHERE msgid = '%@'"

//根据messageid 查 nodeid
#define     SQL_SELECT_NODEID           @"SELECT nodeid FROM %@ WHERE msgid = '%@'"

//查找所有发送时间超过30s的正在发送的信息
#define     SQL_SELECT_TIMEOUT_MESSAGE   @"SELECT * FROM %@ WHERE send_status = '%d' and date < '%@'"

#endif /* EHIChatSQL_h */
