//
//  EHIChatViewController.h
//  MobileSales
//
//  Created by dengwx on 2017/2/7.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIViewController.h"
#import "EHISegmentedControl.h"

@interface EHIChatViewController : EHIViewController

@property (nonatomic , strong) UITableView *chatListTable;

@property (nonatomic , strong) NSMutableArray  *dataAttay;

@property (nonatomic , assign) NSInteger selectIndex; //当前选中的下标

@property (nonatomic , strong) NSArray *colorArray;

//对应 EHIChatDetailVC中的isResetTime的坑
//后期处理
@property (nonatomic , copy) NSString *lastClickNodeId ; // 上次进入的聊天下标

@end
