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

@end
