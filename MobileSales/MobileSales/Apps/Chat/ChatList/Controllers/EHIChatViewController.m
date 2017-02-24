//
//  EHIChatViewController.m
//  MobileSales
//
//  Created by dengwx on 2017/2/7.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatViewController.h"
#import "EHIChatViewController+Delegate.h"
#import "EHIChatListModel.h"
#import "EHIChatSocketManager.h"
#import "EHIChatManager.h"
#import "UITabBar+EHIBadge.h"
#import <AFNetworkReachabilityManager.h>

@interface EHIChatViewController()

@end

@implementation EHIChatViewController
{
    EHISegmentedControl *segment;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"沟通";
    self.view.backgroundColor = HEXCOLOR_F7F7F7;
    [self addSegmentViewAndTableView];
    [self registerCellClass];
    [self requestFrameData];
}

- (void)networkStatusChange:(NSNotification *)noti
{
    AFNetworkReachabilityStatus status = [noti.userInfo[@"AFNetworkingReachabilityNotificationStatusItem"] longValue];
    switch (status) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
        case AFNetworkReachabilityStatusReachableViaWWAN:
        case AFNetworkReachabilityStatusUnknown:
                self.title = @"沟通";
            break;
        case AFNetworkReachabilityStatusNotReachable:
                self.title = @"沟通(未连接)";
            break;
        default:
            break;
    }

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadTableView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.chatListTable reloadData];
        BOOL hasNoRead = [[EHIChatManager sharedInstance] isMessageNoRead];
        if (hasNoRead) {
            [self.tabBarController.tabBar showBadgeOnItemIndex:0];
            return;
        }
        [self.tabBarController.tabBar hideBedgeOnItemIndex:0];
    });
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.chatListTable reloadData];
    BOOL hasNoRead = [[EHIChatManager sharedInstance] isMessageNoRead];
    if (hasNoRead) {
        [self.tabBarController.tabBar showBadgeOnItemIndex:0];
        return;
    }
    [self.tabBarController.tabBar hideBedgeOnItemIndex:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:HAVE_NEW_MESSAGE_NOTIFATION object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

#pragma mark 界面视图
//添加头部滚动栏
- (void)addSegmentViewAndTableView
{
    NSArray *titlesArray = [[NSUserDefaults standardUserDefaults] objectForKey:DEFAULT_TITLES_ARRAY];
    
    segment = [[EHISegmentedControl alloc] initWithSectionTitles:titlesArray];
    segment.font = autoFont(15);
    segment.selectedTextColor = HEXCOLOR_718DDE;
    segment.textColor = HEXCOLOR_333333;
    segment.selectionIndicatorColor = HEXCOLOR_718DDE;
    segment.selectionIndicatorHeight = 2;
    segment.selectionIndicatorLocation = CPBSegmentedControlSelectionIndicatorLocationDown;
    
    [self.view addSubview:segment];
    [self.view addSubview:self.chatListTable];
    
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(64);
        make.height.equalTo(@50);
    }];
    
    [self.chatListTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.equalTo(segment.mas_bottom).offset(2);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    //添加选择头部事件
    [segment addTarget:self action:@selector(segmentSelectHandle:) forControlEvents:UIControlEventValueChanged];
    
}

#pragma mark 网络请求
//网络请求
- (void)requestFrameData
{
    
    [MBProgressHUD showMessage:@"加载中..."];
    
    [EHIHttpRequest getChatFramesInfoWithNodeId:0 FailedCallback:^(id object) {
        
        [self requestFaildHandle:object];
        
    } SuccessCallBack:^(id object) {
        
        [self requestSuccessHandle:object];
        
    }];
}

//请求失败
- (void)requestFaildHandle:(id)object
{
    NSString *message = REQUEST_FAILED;
    if ([object isKindOfClass:[EHIResponseModel class]]) {
        EHIResponseModel *responseModel = (EHIResponseModel *)object;
        if (responseModel.Msg.length) {
            message = responseModel.Msg;
        }
    }
    [EHISingleAlertController showSingleAlertOnViewController:self
                                                    withTitle:@"错误"
                                                  withMessage:message
                                              withActionTitle:@"确定"
                                                      handler:^(WXAlertAction *action) {
                                                          
                                                          [self requestFrameData];
                                                          
                                                      }];
    
}

//请求成功
- (void)requestSuccessHandle:(id)object
{
    EHIResponseModel *responseModel = (EHIResponseModel *)object;
    NSMutableArray *titlesArray = [NSMutableArray arrayWithCapacity:0];
    if (responseModel.Data) {
        NSArray *data = (NSArray *)responseModel.Data;
        for (NSDictionary *dic in data) {
            EHIChatListModel *model = [EHIChatListModel mj_objectWithKeyValues:dic];
            [titlesArray addObject:model.NodeName];
            [self.dataAttay addObject:model];
        }
        //吧表头缓存起来 防止下次首页一片空白
        //暂时这么写 以后可能会用数据库缓存整个首页内容
        if (titlesArray.count) {
            [[NSUserDefaults standardUserDefaults] setObject:titlesArray forKey:DEFAULT_TITLES_ARRAY];
        }
        [self.chatListTable reloadData];
    }
    [self connectToChatSocketServer];
    
}

//开始连接socket服务器
- (void)connectToChatSocketServer
{
    [[EHIChatSocketManager shareInstance] connectToHostWithHost:SHARE_USER_CONTEXT.urlList.SOCKET_HOST
                                                       withPort:SHARE_USER_CONTEXT.urlList.SOCKET_PORT];
}

- (UITableView *)chatListTable
{
    if (!_chatListTable) {
        _chatListTable = [[UITableView alloc] init];
        _chatListTable.separatorColor = HEXCOLOR_D4D4D4;
        //与聊天标题对齐
        _chatListTable.separatorInset = UIEdgeInsetsMake(0, autoHeightOf6(45)+autoWidthOf6(36), 0, 0);
        _chatListTable.delegate = self;
        _chatListTable.dataSource = self;
        _chatListTable.rowHeight = autoHeightOf6(65);
        _chatListTable.tableFooterView = [UIView new];
    }
    return _chatListTable;
}

- (NSMutableArray *)dataAttay
{
    if (!_dataAttay) {
        _dataAttay = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataAttay;
}

- (NSArray *)colorArray
{
    if (!_colorArray) {
        _colorArray = [NSArray arrayWithObjects:HEXCOLOR(@"#de7180"),HEXCOLOR(@"#b971de"),HEXCOLOR(@"#71dea4"),
                                               HEXCOLOR(@"#7195de"),HEXCOLOR(@"#deac71"),HEXCOLOR(@"#71debe"),
                                               HEXCOLOR(@"#ded271"),HEXCOLOR(@"#71b4de"),HEXCOLOR(@"#dd71de"),
                                               HEXCOLOR(@"#aede70"),HEXCOLOR(@"#7176de"),HEXCOLOR(@"#de71a4"),
                                               HEXCOLOR(@"#8671de"),HEXCOLOR(@"#de9270"),HEXCOLOR(@"#70c3de"), nil];
    }
    return _colorArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
