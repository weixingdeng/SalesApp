//
//  EHIChatDetailViewController.h
//  MobileSales
//
//  Created by dengwx on 17/2/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIViewController.h"
#import "EHIChatListModel.h"
#import "EHIChatMessageDisplayView.h"
#import "EHIChatBar.h"
#import "EHIChatSocketManager.h"
#import "EHIMessageStatusManager.h"

@interface EHIChatDetailViewController : EHIViewController

@property (nonatomic , strong) EHIChatListModel *listModel;

//信息展示视图
@property (nonatomic , strong) EHIChatMessageDisplayView *messageView;

/// 聊天输入栏
@property (nonatomic, strong) EHIChatBar *chatBar;

/// 聊天socket管理器
@property (nonatomic, strong) EHIChatSocketManager *socketManager;

//检查发送失败消息
@property (nonatomic , strong) EHIMessageStatusManager *statusManager;

//说明文本
@property (nonatomic , strong) UIButton  *commentButton;

//是否重置时间
//此处为埋的一个坑 后期处理掉 暂时为了解决 开始一个新聊天 必须要显示时间 
@property (nonatomic , assign) BOOL isResetTime ;

- (void)resetTimeShow;
@end
