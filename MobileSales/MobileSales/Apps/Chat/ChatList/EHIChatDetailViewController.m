//
//  EHIChatDetailViewController.m
//  MobileSales
//
//  Created by dengwx on 17/2/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatDetailViewController.h"
#import "EHIChatDetailViewController+Delegate.h"

@interface EHIChatDetailViewController ()

@end

@implementation EHIChatDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.listModel.NodeName;
    
    [self setNavigationRight];
    
    [self setUI];
    
}

- (void)setUI
{
    [self.view addSubview:self.chatDetailTable];
    [self.view addSubview:self.chatBar];
    
    [self.chatDetailTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.chatBar);
    }];
    
    [self.chatBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];

}

//设置导航右边
- (void)setNavigationRight
{
    UIImage *navRightImage = [UIImage imageNamed:@"nav_right_img"];
    navRightImage = [navRightImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:navRightImage style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonDown)];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
}

- (void)rightBarButtonDown
{
    
}

#pragma mark - # Getter
- (UITableView *)chatDetailTable
{
    if (_chatDetailTable == nil) {
        _chatDetailTable = [[UITableView alloc] init];
        [_chatDetailTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_chatDetailTable setBackgroundColor:[UIColor clearColor]];
        [_chatDetailTable setTableFooterView:[UIView new]];
        [_chatDetailTable setDelegate:self];
        [_chatDetailTable setDataSource:self];
    }
    return _chatDetailTable;
}

- (EHIChatBar *)chatBar
{
    if (!_chatBar) {
        _chatBar = [[EHIChatBar alloc] init];
    }
    return _chatBar;
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
