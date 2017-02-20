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

@interface EHIChatDetailViewController : EHIViewController

@property (nonatomic , strong) EHIChatListModel *listModel;

//信息展示视图
@property (nonatomic , strong) EHIChatMessageDisplayView *messageView;

/// 聊天输入栏
@property (nonatomic, strong) EHIChatBar *chatBar;

/// 聊天socket管理器
@property (nonatomic, strong) EHIChatSocketManager *socketManager;

@end
