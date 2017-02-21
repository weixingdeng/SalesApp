//
//  EHIDBFrameDAO.h
//  MobileSales
//
//  Created by dengwx on 17/2/21.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIDBBaseDAO.h"
#import "EHIMessage.h"
#import "EHIChatListModel.h"

@interface EHIDBFrameDAO : EHIDBBaseDAO

//添加信息到 聊天记录
- (BOOL)addMessage:(EHIMessage *)message
        toChatListNodeId:(NSString *)nodeId
            isRead:(BOOL)isRead;


//更新聊天列表的状态
- (EHIChatListModel *)updateChatListStateWithChatListModel:(EHIChatListModel *)chatList;


//更新聊天列表为已读
- (BOOL)updateChatToReadWithNodeLevel:(NSString *)nodeLevel
                           withNodeId:(NSString *)nodeId;

- (BOOL)isMessageNoRead;
@end
