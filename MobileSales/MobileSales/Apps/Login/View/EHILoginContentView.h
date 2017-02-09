//
//  EHLoginContentView.h
//  MobileSales
//
//  Created by 李旭 on 17/1/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHILoginContentView : UIView

/** “输入工号文字框” */
@property (strong ,nonatomic) UITextField *userIdTextField;

/** “输入密码文字框” */
@property (strong ,nonatomic) UITextField *userPassWordTextField;

/** 是否自动登录按钮 */
@property (strong ,nonatomic) UIButton *autoLoginButton;

/** 登录按钮 */
@property (strong ,nonatomic) UIButton *loginButton;

@end
