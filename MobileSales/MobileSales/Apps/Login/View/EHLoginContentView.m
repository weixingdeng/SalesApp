//
//  EHLoginContentView.m
//  MobileSales
//
//  Created by 李旭 on 17/1/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHLoginContentView.h"
#import <Masonry.h>

@interface EHLoginContentView () <UITextFieldDelegate>

/** 工号图标 */
@property (strong ,nonatomic) UIImageView *idImageView;

/** 密码图标 */
@property (strong ,nonatomic) UIImageView *passWordImageView;

/** “输入工号文字框” */
@property (strong ,nonatomic) UITextField *userIdTextField;

/** “输入密码文字框” */
@property (strong ,nonatomic) UITextField *userPassWordTextField;

/** 工号下方灰色线条 */
@property (strong ,nonatomic) UIView *idLineView;

/** 密码下方灰色线条 */
@property (strong ,nonatomic) UIView *passWordLineView;

/** 是否自动登录按钮 */
@property (strong ,nonatomic) UIButton *autoLoginButton;

/** 显示“自动登录“ */
@property (strong ,nonatomic) UILabel *autoLoginLabel;

/** 登录按钮 */
@property (strong ,nonatomic) UIButton *loginButton;

@end

@implementation EHLoginContentView

- (instancetype) init
{
    self = [super init];
    
    if (self)
    {
        [self updateUI];
    }
    
    return self;
}

#pragma mark - private method
- (void) updateUI
{
    //icon的尺寸
    CGFloat iconPointSize = self.userIdTextField.font.pointSize;
    
    //图片边框的距离
    CGFloat padding = 10;
    
    [self.idImageView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.equalTo(self.mas_left).offset(padding);
        make.right.equalTo(self.userIdTextField.mas_left).offset(-10);
        make.height.equalTo(@(iconPointSize));
        make.width.equalTo(@(iconPointSize));
    }];
    
    [self.userIdTextField mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.equalTo(self.idImageView.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.equalTo(self.idImageView.mas_height);
    }];
    
    [self.idLineView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.userIdTextField.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.equalTo(@(1));
    }];
    
    [self.passWordImageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.idLineView.mas_top).offset(10);
         make.left.equalTo(self.mas_left).offset(padding);
         make.right.equalTo(self.userPassWordTextField.mas_left).offset(-10);
         make.height.equalTo(@(iconPointSize));
         make.width.equalTo(@(iconPointSize));
     }];
    
    [self.userPassWordTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.idLineView.mas_top).offset(10);
         make.left.equalTo(self.passWordImageView.mas_right).offset(10);
         make.right.equalTo(self.mas_right).offset(0);
         make.height.equalTo(self.passWordImageView.mas_height);
     }];
    
    [self.passWordLineView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.userPassWordTextField.mas_bottom).offset(10);
         make.left.equalTo(self.mas_left).offset(0);
         make.right.equalTo(self.mas_right).offset(0);
         make.height.equalTo(@(1));
     }];
    
    [self.autoLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat pointSize = self.autoLoginLabel.font.pointSize;
        make.left.equalTo(self.mas_left).offset(padding);
        make.right.equalTo(self.autoLoginLabel.mas_left).offset(0);
        make.width.equalTo(@(pointSize));
        make.height.equalTo(@(pointSize));
        make.centerY.equalTo(self.autoLoginLabel.mas_centerY);
    }];
    
    [self.autoLoginLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.passWordLineView.mas_bottom).offset(15);
         make.left.equalTo(self.autoLoginButton.mas_right).offset(0);
         make.right.equalTo(self.mas_right).offset(0);
         make.height.equalTo(@(44));
     }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.autoLoginLabel.mas_bottom).offset(15);
         make.left.equalTo(self.mas_left).offset(0);
         make.bottom.equalTo(self.mas_bottom).offset(-15);
         make.right.equalTo(self.mas_right).offset(0);
     }];
}

//点击登陆按钮
- (void) clickLoginButton:(UIButton *) button
{
    NSLog(@"click");
}

#pragma mark - getter / setter
- (UIImageView *) idImageView
{
    if (!_idImageView)
    {
        _idImageView = [[UIImageView alloc] init];
        _idImageView.image = [UIImage imageNamed:@"yes"];
        [self addSubview:_idImageView];
    }
    return _idImageView;
}

- (UIImageView *) passWordImageView
{
    if (!_passWordImageView)
    {
        _passWordImageView = [[UIImageView alloc] init];
        _passWordImageView.image = [UIImage imageNamed:@"no"];
        [self addSubview:_passWordImageView];
    }
    return _passWordImageView;
}

- (UIView *) idLineView
{
    if (!_idLineView)
    {
        _idLineView = [self lineView: [UIColor grayColor]];
        [self addSubview:_idLineView];
    }
    return _idLineView;
}

- (UIView *) passWordLineView
{
    if (!_passWordLineView)
    {
        _passWordLineView = [self lineView:[UIColor grayColor]];
        [self addSubview:_passWordLineView];
    }
    return _passWordLineView;
}

#warning 这个方法应当单独抽出作为类方法
- (UIView *) lineView:(UIColor *) color
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = color;
    return lineView;
}

- (UILabel *) autoLoginLabel
{
    if (!_autoLoginLabel)
    {
        _autoLoginLabel = [[UILabel alloc] init];
        _autoLoginLabel.text = @"是否自动登录";
        [self addSubview:_autoLoginLabel];
    }
    return _autoLoginLabel;
}

- (UITextField *) userIdTextField
{
    if (!_userIdTextField)
    {
        _userIdTextField = [[UITextField alloc] init];
        _userIdTextField.placeholder = @"请输入工号";
        _userIdTextField.delegate = self;
        [self addSubview:_userIdTextField];
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
        [self addSubview:_userPassWordTextField];
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
        [self addSubview:_autoLoginButton];
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
        _loginButton.userInteractionEnabled = YES;
        [self addSubview:_loginButton];
    }
    return _loginButton;
}
@end
