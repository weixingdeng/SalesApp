//
//  EHIChatDetailViewController.h
//  MobileSales
//
//  Created by dengwx on 17/2/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIViewController.h"
#import "EHIChatListModel.h"
#import "EHIChatBar.h"

@interface EHIChatDetailViewController : EHIViewController

@property (nonatomic , strong) EHIChatListModel *listModel;

@property (nonatomic , strong) UITableView *chatDetailTable;

/// 聊天输入栏
@property (nonatomic, strong) EHIChatBar *chatBar;

@end
