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

#define     SQL_CREATE_MESSAGE_TABLE        @"CREATE TABLE IF NOT EXISTS %@(\
                                                msgid TEXT,\
                                                userid TEXT,\
                                                nodeid INTEGER,\
                                                date TEXT,\
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
                                                PRIMARY KEY(userid, msgid, nodeid))"

#define     SQL_ADD_MESSAGE                 @"REPLACE INTO %@ ( msgid, userid, nodeid, date, own_type, msg_type, content, send_status, received_status, ext1, ext2, ext3, ext4, ext5) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?)"

#define     SQL_SELECT_MESSAGES_PAGE        @"SELECT * FROM %@ WHERE nodeid = '%@' and date < '%@' order by date desc LIMIT '%ld'"

#define     SQL_SELECT_LAST_MESSAGE         @"SELECT * FROM %@ WHERE date = ( SELECT MAX(date) FROM %@ WHERE noid = '%@' )"


#endif /* EHIChatSQL_h */
