//
//  EHIFrameSQL.h
//  MobileSales
//
//  Created by dengwx on 17/2/15.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#ifndef EHIFrameSQL_h
#define EHIFrameSQL_h

//创建框架总表(聊天分类)
#define     FRAME_TABLE_NAME                @"chat_list"

#define     SQL_CREATE_FRAME_TABLE        @"CREATE TABLE IF NOT EXISTS %@(\
                                            NodeLevel TEXT,\
                                            NodeId TEXT,\
                                            Date TEXT,\
                                            Content TEXT,\
                                            IsRead INTEGER DEFAULT 1,\
                                            SenderName TEXT,\
                                            ext1 TEXT,\
                                            ext2 TEXT,\
                                            ext3 TEXT,\
                                            ext4 TEXT,\
                                            ext5 TEXT,\
                                            PRIMARY KEY(NodeId))"

#define     SQL_ADD_CONVERSATION              @"REPLACE INTO %@ ( \
                                                NodeLevel,\
                                                NodeId,\
                                                Date,\
                                                Content,\
                                                IsRead,\
                                                SenderName,\
                                                ext1, ext2, ext3, ext4, ext5)\
                                                VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"

#define SQL_SELECT_NOREAD_MESSAGE @"SELECT * FROM %@ WHERE IsRead = %d"

#define SQL_SELECT_CONVERSATION_INFO  @"SELECT * FROM %@ WHERE NodeId = %@"

#define SQL_UPDATE_ISREAD @"UPDATE %@ SET IsRead = %d WHERE NodeLevel = %@ and NodeId = %@"

#endif /* EHIFrameSQL_h */
