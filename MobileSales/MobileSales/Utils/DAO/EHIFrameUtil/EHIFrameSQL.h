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
#define     FRAME_TABLE_NAME                @"chat_frame"

#define     SQL_CREATE_FRAME_TABLE        @"CREATE TABLE IF NOT EXISTS %@(\
                                            NodeLevel INTEGER,\
                                            NodeId INTEGER,\
                                            NodeName TEXT,\
                                            ShortName TEXT, \
                                            Children TEXT,\
                                            Contacts TEXT,\
                                            Comment TEXT,\
                                            PRIMARY KEY(NodeId))"

#define SQL_SELECT_ALL_FRAME @"SELECT * FROM %@"

#define SQL_SELECT_FRAME @"SELECT * FROM %@ WHERE NodeId = %@"

//创建框架表下的子表(子类)
#define     FRAME_CHILDREN_TABLE_NAME       @"chat_frame_children"

#define     SQL_CREATE_FRAME_CHILDREN_TABLE        @"CREATE TABLE IF NOT EXISTS %@(\
                                                    SuperNodeId INTEGER,\
                                                    NodeId INTEGER,\
                                                    NodeName TEXT,\
                                                    ShortName TEXT, \
                                                    Children TEXT,\
                                                    Contacts TEXT,\
                                                    Comment TEXT,\
                                                    PRIMARY KEY(SuperNodeId,NodeId))"

#define SQL_SELECT_FRAME @"SELECT * FROM %@ WHERE SuperNodeId = %@"

//聊天框架表下的字表(每个框架下的人员)
#define     FRAME_CONTACTS_TABLE_NAME       @"chat_frame_contacts"

#define     SQL_CREATE_FRAME_CONTACTS_TABLE        @"CREATE TABLE IF NOT EXISTS %@(\
                                                    SuperNodeId INTEGER,\
                                                    NodeId INTEGER,\
                                                    UserNo TEXT,\
                                                    UserName TEXT, \
                                                    PRIMARY KEY(SuperNodeId,NodeId))"



#define     SQL_SELECT_FRAME             @"SELECT * FROM %@ WHERE uid = %@"

#define     SQL_DELETE_FRAME             @"DELETE FROM %@ WHERE uid = '%@' and fid = '%@'"

#endif /* EHIFrameSQL_h */
