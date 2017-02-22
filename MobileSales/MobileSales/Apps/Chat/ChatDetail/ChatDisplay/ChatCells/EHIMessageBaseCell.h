//
//  EHIMessageBaseCell.h
//  MobileSales
//
//  Created by dengwx on 17/2/19.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHIMessageCellDelegate.h"
#import "EHIMessage.h"

@interface EHIMessageBaseCell : UITableViewCell

@property (nonatomic, assign) id<EHIMessageCellDelegate>delegate;

//时间
@property (nonatomic, strong) UILabel *timeLabel;

//头像
@property (nonatomic, strong) UIButton *avatarButton;

//用户名
@property (nonatomic, strong) UILabel *usernameLabel;

//聊天背景
@property (nonatomic, strong) UIImageView *messageBackgroundView;

//状态 菊花
@property (nonatomic , strong) UIActivityIndicatorView  *activityView;

@property (nonatomic , strong) UIButton  *sendAgainBtn;

@property (nonatomic, strong) EHIMessage *message;

@end
