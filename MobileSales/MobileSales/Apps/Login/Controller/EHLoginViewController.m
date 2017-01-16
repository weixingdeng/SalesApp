//
//  EHLoginViewController.m
//  MobileSales
//
//  Created by 李旭 on 17/1/11.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#warning 设计稿暂时没出，布局用了很多magic number。后期可能会单独拆出去

#import "EHLoginViewController.h"
#import "EHLoginContentView.h"
#import <Masonry.h>


#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)

@interface EHLoginViewController () <UITextFieldDelegate>

/** 背景图 */
@property (strong ,nonatomic) UIImageView *backgroundImageView;

/** 显示“嗨行天下“ */
@property (strong ,nonatomic) UIImageView *logoImageView;

/** 登录内容 */
@property (strong ,nonatomic) UIView *loginContentView;

@end

@implementation EHLoginViewController

#pragma  mark - ViewController Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        make.left.equalTo(self.backgroundImageView.mas_left).offset(100);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-100);
        make.height.equalTo(@(60));
    }];
    
    [self.loginContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView.mas_bottom).offset(100);
        make.left.equalTo(self.backgroundImageView.mas_left).offset(padding);
        make.right.equalTo(self.backgroundImageView.mas_right).offset(-padding);
        make.height.equalTo(@(200));
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
        _backgroundImageView.backgroundColor = [UIColor greenColor];
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
        _logoImageView.backgroundColor = [UIColor redColor];
        [self.backgroundImageView addSubview:_logoImageView];
    }
    return _logoImageView;
}

- (UIView *) loginContentView
{
    if (!_loginContentView) {
        EHLoginContentView *contentView = [[EHLoginContentView alloc] init];
        contentView.backgroundColor = [UIColor orangeColor];
        _loginContentView = contentView;
        _loginContentView.userInteractionEnabled = YES;
        [self.backgroundImageView addSubview:_loginContentView];
    }
    return _loginContentView;
}

@end
