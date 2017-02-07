//
//  EHMineViewController.m
//  MobileSales
//
//  Created by 李旭 on 17/1/11.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIMyInfomationViewController.h"
#import "EHMineHeaderView.h"
#import <Masonry.h>

@interface EHIMyInfomationViewController ()

/** 头部视图 */
@property (strong ,nonatomic) EHMineHeaderView *headerView;

/** 退出按钮 */
@property (strong ,nonatomic) UIButton *quitButton;

@end

@implementation EHIMyInfomationViewController

#pragma  mark - ViewController Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self updateUI];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - Event Response
- (void) clickQuitButton:(UIButton *) button
{
    
}

#pragma  mark - Delegate


#pragma  mark - Notification


#pragma  mark - Private Method
- (void) updateUI
{
    CGFloat padding = 20;
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(@(90));
    }];
    
    [self.quitButton mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.headerView.mas_bottom).offset(padding);
        make.left.equalTo(self.view.mas_left).offset(padding);
        make.right.equalTo(self.view.mas_right).offset(-padding);
        make.height.equalTo(@(44));
    }];
}

#pragma mark - getter / setter
- (EHMineHeaderView *) headerView
{
    if (!_headerView)
    {
        _headerView = [[EHMineHeaderView alloc] init];
        _headerView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_headerView];
    }
    return _headerView;
}


- (UIButton *) quitButton
{
    if (!_quitButton) {
        _quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_quitButton setTitle:@"退出" forState:UIControlStateNormal];
        _quitButton.layer.borderWidth = 1;
        [_quitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_quitButton addTarget:self action:@selector(clickQuitButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_quitButton];
    }
    return _quitButton;
}


@end
