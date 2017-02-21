//
//  EHIMyInfomationViewController.h
//  MobileSales
//
//  Created by dengwx on 17/2/20.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIViewController.h"
#import "EHIShowInfoLabel.h"

@interface EHIMyInfomationViewController : EHIViewController

//头像
@property (nonatomic , strong) UIImageView  *iconImgView;

//姓名
@property (nonatomic , strong) EHIShowInfoLabel  *nameLabel;

//工号
@property (nonatomic , strong) EHIShowInfoLabel  *userNoLabel;

//性别
@property (nonatomic , strong) EHIShowInfoLabel *sexLabel;

//退出按钮
@property (nonatomic , strong) UIButton  *exitBtn;

//性别
@property (nonatomic , assign) BOOL isBoy;

//是否是自己的信息
@property (nonatomic , assign) BOOL isOtherInfo;

@property (nonatomic , copy) NSString *userName;

@property (nonatomic , copy) NSString *userNo;

@end
