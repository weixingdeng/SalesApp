//
//  EHLoginViewController.m
//  MobileSales
//
//  Created by 李旭 on 17/1/11.
//  Copyright © 2017年 wxdeng. All rights reserved.
//


#import "EHILoginViewController.h"
#import "EHILoginContentView.h"

@interface EHILoginViewController () <UITextFieldDelegate>

/** 背景图 */
@property (strong ,nonatomic) UIImageView *backgroundImageView;

/** 显示“嗨行天下“ */
@property (strong ,nonatomic) UIImageView *logoImageView;

/** 登录内容 */
@property (strong ,nonatomic) EHILoginContentView *loginContentView;

@end

@implementation EHILoginViewController

#pragma  mark - ViewController Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

#pragma  mark - Event Response
//登录
- (void) clickLoginButton:(UIButton *) button
{
    
}

//是否自动登录
- (void) clickAutoLoginButton:(UIButton *) button
{
    button.selected = !button.selected;
}

- (void)autoLogin:(UIButton *)btn
{
    
}

#pragma  mark - Delegate


#pragma  mark - Notification


#pragma  mark - Private Method
- (void) updateUI
{
    //登录内容与屏幕左右边距
    CGFloat padding = 20;
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView.mas_top).offset(120);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(0);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(0);
        make.height.equalTo(@(45));
    }];
    
    [self.loginContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView.mas_bottom).offset(80);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
        make.bottom.equalTo(@(0));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - getter / setter
- (UIImageView *) backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.image = EHI_LOAD_IMAGE(@"login_bg");
        _backgroundImageView.frame = self.view.bounds;
        _backgroundImageView.userInteractionEnabled = YES;
        [self.view addSubview:_backgroundImageView];
    }
    return _backgroundImageView;
}

- (UIImageView *) logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = EHI_LOAD_IMAGE(@"login_logo_icon");
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.backgroundImageView addSubview:_logoImageView];
    }
    return _logoImageView;
}

- (EHILoginContentView *) loginContentView
{
    if (!_loginContentView) {
        _loginContentView = [[EHILoginContentView alloc] init];
        [self.backgroundImageView addSubview:_loginContentView];
        
        [_loginContentView.loginButton addTarget:self
                                          action:@selector(clickLoginButton:)
                                forControlEvents:UIControlEventTouchUpInside];
        
        [_loginContentView.autoLoginButton addTarget:self
                                              action:@selector(clickAutoLoginButton:)
                                    forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginContentView;
}

@end
