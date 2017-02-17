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


@interface EHIChatViewController()

@end

@implementation EHIChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"沟通";
    self.view.backgroundColor = HEXCOLOR_F7F7F7;
    [self addSegmentViewAndTableView];
    [self registerCellClass];
    [self requestFrameData];
}

#pragma mark 界面视图
//添加头部滚动栏
- (void)addSegmentViewAndTableView
{
    NSArray *titlesArray = @[@"账户设置",@"车辆咨询",@"需求发布"];
    EHISegmentedControl *segment = [[EHISegmentedControl alloc] initWithSectionTitles:titlesArray];
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
    if (responseModel.Data) {
        NSArray *data = (NSArray *)responseModel.Data;
        for (NSDictionary *dic in data) {
            EHIChatListModel *model = [EHIChatListModel mj_objectWithKeyValues:dic];
            [self.dataAttay addObject:model];
        }
        [self.chatListTable reloadData];
    }
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
