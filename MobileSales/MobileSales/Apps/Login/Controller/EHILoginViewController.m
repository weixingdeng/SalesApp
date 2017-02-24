//
//  EHLoginViewController.m
//  MobileSales
//
//  Created by 李旭 on 17/1/11.
//  Copyright © 2017年 wxdeng. All rights reserved.
//


#import "EHILoginViewController.h"
#import "EHILoginContentView.h"
#import "EHIHomeViewController.h"
#import "EHIChatMemberViewController.h"

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
    
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:50];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

#pragma  mark - Event Response
//登录
- (void) clickLoginButton:(UIButton *) button
{    
    BOOL isSuccess = [self isLocalCheckedSuccess];
    
    //本地验证成功 发起登录请求
    if (isSuccess) {
        [MBProgressHUD showMessage:@"正在登陆中..."];
      [EHIHttpRequest loginWithUserNo:self.loginContentView.userIdTextField.text
                         withPassword:self.loginContentView.userPassWordTextField.text
                       FailedCallback:^(id object) {
                           
                           [self showLoginErrorMessage:object];
                           
                       } SuccessCallBack:^(id object) {
                           
                           [self saveLoginMessageWithObject:object];
                           
                           [self initHomeViewController];
                           
                       }];
    }
}

//保存本地信息
- (void)saveLoginMessageWithObject:(id)object
{
    EHIResponseModel *responseModel = (EHIResponseModel *)object;
    if (responseModel.Data) {
        NSDictionary *dataDic = (NSDictionary *)responseModel.Data;
        
        SHARE_USER_CONTEXT.user.user_id = dataDic[@"UserNo"];
        SHARE_USER_CONTEXT.user.user_name = dataDic[@"UserName"];
        SHARE_USER_CONTEXT.user.user_sex = dataDic[@"Sex"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:SHARE_USER_CONTEXT.user.user_id
                                              forKey:USER_ID_KEY];
    
    [[NSUserDefaults standardUserDefaults] setObject:SHARE_USER_CONTEXT.user.user_name
                                              forKey:USER_NAME_KEY];

    [[NSUserDefaults standardUserDefaults] setObject:SHARE_USER_CONTEXT.user.user_sex
                                                forKey:USER_SEX_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //如果勾选自动登录 本地保存账号密码
    [[NSUserDefaults standardUserDefaults] setObject:self.loginContentView.userIdTextField.text
                                              forKey:REMEMBER_USERNO];
    if (self.loginContentView.autoLoginButton.selected) {
        [[NSUserDefaults standardUserDefaults] setObject:self.loginContentView.userPassWordTextField.text
                                                  forKey:REMEMBER_PASSWORD];
    }else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:REMEMBER_PASSWORD];
    }
    
}

//是否自动登录
- (void) clickAutoLoginButton:(UIButton *) button
{
    button.selected = !button.selected;
}

//初始化主页
- (void)initHomeViewController
{
    EHIHomeViewController *homeVC = [[EHIHomeViewController alloc] init];
    [self.window setRootViewController:homeVC];
}

#pragma error tips
//本地登录信息非空验证是否通过
- (BOOL)isLocalCheckedSuccess
{
    //账号为空
    if (!self.loginContentView.userIdTextField.text.length) {
        [EHISingleAlertController showSingleAlertOnViewController:self
                                                        withTitle:nil
                                                      withMessage:@"请输入账号!"
                                                  withActionTitle:@"确认"
                                                          handler:nil];
        return NO;
    }
    
    //密码为空
    if (!self.loginContentView.userPassWordTextField.text.length) {
        [EHISingleAlertController showSingleAlertOnViewController:self
                                                        withTitle:nil
                                                      withMessage:@"请输入密码!"
                                                  withActionTitle:@"确认"
                                                          handler:nil];
        return NO;
    }
    
    return YES;
    
}

//展示登录错误信息
- (void)showLoginErrorMessage:(id)object
{
    NSString *message = @"";
    if ([object isKindOfClass:[NSError class]]) {
        message = @"请检查你的网络后重试或联系技术部";
    }else
    {
        EHIResponseModel *model = (EHIResponseModel *)object;
        if (model.Msg.length) {
            message = model.Msg;
        }else
        {
            message = @"登录失败 请重试";
        }
    }
    
    [EHISingleAlertController showSingleAlertOnViewController:self
                                                    withTitle:@"登录失败"
                                                  withMessage:message
                                              withActionTitle:@"确定"
                                                      handler:^(WXAlertAction *action) {
                                                        
                                                    }];
}




#pragma  mark - Delegate


#pragma  mark - Notification


#pragma  mark - Private Method
- (void) updateUI
{
    [self.view addSubview:self.backgroundImageView];
     [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.loginContentView];
    
    NSString *userNo = [[NSUserDefaults standardUserDefaults] objectForKey:REMEMBER_USERNO];
    NSString *passwordNo = [[NSUserDefaults standardUserDefaults] objectForKey:REMEMBER_PASSWORD];
    if (userNo && [userNo length]) {
        self.loginContentView.userIdTextField.text = userNo;
        self.loginContentView.autoLoginButton.selected = YES;
    }
    if (passwordNo) {
        self.loginContentView.userPassWordTextField.text = passwordNo;
    }
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
    }
    return _backgroundImageView;
}

- (UIImageView *) logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = EHI_LOAD_IMAGE(@"login_logo_icon");
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _logoImageView;
}

- (EHILoginContentView *) loginContentView
{
    if (!_loginContentView) {
        _loginContentView = [[EHILoginContentView alloc] init];
        
        [_loginContentView.loginButton addTarget:self
                                          action:@selector(clickLoginButton:)
                                forControlEvents:UIControlEventTouchUpInside];
        
        [_loginContentView.autoLoginButton addTarget:self
                                              action:@selector(clickAutoLoginButton:)
                                    forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginContentView;
}

//释放键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.window endEditing:YES];
}


@end
