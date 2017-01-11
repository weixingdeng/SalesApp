//
//  EHLoginViewController.m
//  MobileSales
//
//  Created by 李旭 on 17/1/11.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#warning 设计稿暂时没出，布局用了很多magic number。后期可能会单独拆出去

#import "EHLoginViewController.h"
#import "EHMineViewController.h"
#import <Masonry.h>


#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)

@interface EHLoginViewController () <UITextFieldDelegate>

/** 显示“嗨行天下“ */
@property (strong ,nonatomic) UILabel *titleLabel;

/** 工号的背景视图 */
@property (strong ,nonatomic) UIView *userIdBackgroundView;

/** 密码的背景视图 */
@property (strong ,nonatomic) UIView *userPassWordBackgroundView;

/** 显示“工号“ */
@property (strong ,nonatomic) UILabel *userIdLabel;

/** 显示“密码“ */
@property (strong ,nonatomic) UILabel *userPassWordLabel;

/** 显示“自动登录“ */
@property (strong ,nonatomic) UILabel *autoLoginLabel;

/** “输入工号文字框” */
@property (strong ,nonatomic) UITextField *userIdTextField;

/** “输入密码文字框” */
@property (strong ,nonatomic) UITextField *userPassWordTextField;

/** 是否自动登录按钮 */
@property (strong ,nonatomic) UIButton *autoLoginButton;

/** 登录按钮 */
@property (strong ,nonatomic) UIButton *loginButton;

@end

@implementation EHLoginViewController

#pragma  mark - ViewController Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self updateUI];
}

#pragma  mark - Event Response
//登录
- (void) clickLoginButton:(UIButton *) button
{
#warning 测试
    EHMineViewController *mineCtrl = [[EHMineViewController alloc] init];
    [self.navigationController pushViewController:mineCtrl animated:YES];
}

//是否自动登录
- (void) clickAutoLoginButton:(UIButton *) button
{

}

#pragma  mark - Delegate


#pragma  mark - Notification


#pragma  mark - Private Method
- (void) updateUI
{
    CGFloat padding = 20;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.height.equalTo(@(44));
        make.width.equalTo(@(100));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.userIdBackgroundView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(50);
        make.left.equalTo(self.view.mas_left).offset(padding);
        make.right.equalTo(self.view.mas_right).offset(-padding);
        make.height.equalTo(@(44));
    }];
    
    [self.userPassWordBackgroundView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.userIdBackgroundView.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(padding);
        make.right.equalTo(self.view.mas_right).offset(-padding);
        make.height.equalTo(self.userIdBackgroundView);
    }];
    
    [self.userIdLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.top.equalTo(self.userIdBackgroundView.mas_top).offset(0);
        make.left.equalTo(self.userIdBackgroundView.mas_left).offset(padding);
        make.width.equalTo(@(60));
        make.height.equalTo(@(44));
    }];
    
    
    [self.userIdTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.top.equalTo(self.userIdBackgroundView.mas_top).offset(0);
        make.left.equalTo(self.userIdLabel.mas_right).offset(padding);
        make.right.equalTo(self.userIdBackgroundView.mas_right).offset(-padding);
        make.height.equalTo(self.userIdLabel);
    }];
    
    
    [self.userPassWordLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.userPassWordBackgroundView.mas_top).offset(0);
        make.left.equalTo(self.userPassWordBackgroundView.mas_left).offset(padding);
        make.width.equalTo(@(60));
        make.height.equalTo(@(44));
    }];
    
    [self.userPassWordTextField mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.userPassWordBackgroundView.mas_top).offset(0);
        make.left.equalTo(self.userPassWordLabel.mas_right).offset(padding);
        make.right.equalTo(self.userPassWordBackgroundView.mas_right).offset(-padding);
        make.height.equalTo(self.userPassWordLabel);
    }];
    
    
    [self.autoLoginButton mas_makeConstraints:^(MASConstraintMaker *make)
    {
        CGFloat pointSize = self.autoLoginLabel.font.pointSize;
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.autoLoginLabel.mas_left).offset(0);
        make.width.equalTo(@(pointSize));
        make.height.equalTo(@(pointSize));
        make.centerY.equalTo(self.autoLoginLabel.mas_centerY);
    }];
    
    [self.autoLoginLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.top.equalTo(self.userPassWordBackgroundView.mas_bottom).offset(0);
        make.left.equalTo(self.autoLoginButton.mas_right).offset(0);
        make.height.equalTo(@(44));
        make.width.equalTo(@(150));
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.top.equalTo(self.autoLoginLabel.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(padding);
        make.right.equalTo(self.view.mas_right).offset(-padding);
        make.height.equalTo(@(44));
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - getter / setter
- (UILabel *) titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"嗨行天下";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIView *) userIdBackgroundView
{
    if (!_userIdBackgroundView)
    {
        _userIdBackgroundView = [[UIView alloc] init];
        _userIdBackgroundView.layer.borderWidth = 1;
        [self.view addSubview:_userIdBackgroundView];
    }
    return _userIdBackgroundView;
}

- (UIView *) userPassWordBackgroundView
{
    if (!_userPassWordBackgroundView)
    {
        _userPassWordBackgroundView = [[UIView alloc] init];
        _userPassWordBackgroundView.layer.borderWidth = 1;
        [self.view addSubview:_userPassWordBackgroundView];
    }
    return _userPassWordBackgroundView;
}

- (UILabel *) userIdLabel
{
    if (!_userIdLabel)
    {
        _userIdLabel = [[UILabel alloc] init];
        _userIdLabel.text = @"工号";
        [self.userIdBackgroundView addSubview:_userIdLabel];
    }
    return _userIdLabel;
}

- (UILabel *) userPassWordLabel
{
    if (!_userPassWordLabel)
    {
        _userPassWordLabel = [[UILabel alloc] init];
        _userPassWordLabel.text = @"密码";
        [self.view addSubview:_userPassWordLabel];
    }
    return _userPassWordLabel;
}

- (UILabel *) autoLoginLabel
{
    if (!_autoLoginLabel)
    {
        _autoLoginLabel = [[UILabel alloc] init];
        _autoLoginLabel.text = @"是否自动登录";
        [self.view addSubview:_autoLoginLabel];
    }
    return _autoLoginLabel;
}

- (UITextField *) userIdTextField
{
    if (!_userIdTextField)
    {
        _userIdTextField = [[UITextField alloc] init];
        _userIdTextField.placeholder = @"请输入员工工号";
        _userIdTextField.delegate = self;
        [self.userIdBackgroundView addSubview:_userIdTextField];
    }
    return _userIdTextField;
}

- (UITextField *) userPassWordTextField
{
    if (!_userPassWordTextField)
    {
        _userPassWordTextField = [[UITextField alloc] init];
        _userPassWordTextField.placeholder = @"请输入密码";
        _userPassWordTextField.delegate = self;
        _userPassWordTextField.secureTextEntry = YES;
        [self.view addSubview:_userPassWordTextField];
    }
    return _userPassWordTextField;
}

- (UIButton *) autoLoginButton
{
    if (!_autoLoginButton)
    {
        _autoLoginButton = [[UIButton alloc] init];
        [_autoLoginButton setBackgroundImage:[UIImage imageNamed:@"no"] forState:UIControlStateNormal];
        [_autoLoginButton addTarget:self action:@selector(clickAutoLoginButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_autoLoginButton];
    }
    return _autoLoginButton;
}

- (UIButton *) loginButton
{
    if (!_loginButton)
    {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _loginButton.layer.borderWidth = 1;
        [_loginButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginButton];
    }
    return _loginButton;
}

@end
