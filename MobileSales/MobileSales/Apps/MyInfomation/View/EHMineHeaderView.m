//
//  EHMineHeaderView.m
//  MobileSales
//
//  Created by 李旭 on 17/1/11.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHMineHeaderView.h"
#import <Masonry.h>

@interface EHMineHeaderView ()

/** 用户头像 */
@property (strong ,nonatomic) UIImageView *userImageView;

/** 用户性别 */
@property (strong ,nonatomic) UILabel *sexLabel;

/** 用户名字 */
@property (strong ,nonatomic) UILabel *userNameLabel;

/** 用户工号 */
@property (strong ,nonatomic) UILabel *userIdLabel;

@end

@implementation EHMineHeaderView

#pragma  mark - ViewController Life Cycle
- (instancetype) init
{
    self = [super init];
    
    if (self)
    {
        [self updateUI];
    }
    
    return self;
}

#pragma  mark - Private Method
- (void) updateUI
{
    
}

#pragma mark - getter / setter
- (UIImageView *) userImageView
{
    if (!_userImageView)
    {
        _userImageView = [[UIImageView alloc] init];
        [self addSubview:_userImageView];
    }
    return _userImageView;
}

- (UILabel *) sexLabel
{
    if (!_sexLabel)
    {
        _sexLabel = [[UILabel alloc] init];
        [self addSubview:_sexLabel];
    }
    return _sexLabel;
}

- (UILabel *) userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        [self addSubview:_userNameLabel];
    }
    return _userNameLabel;
}

- (UILabel *) userIdLabel
{
    if (!_userIdLabel) {
        _userIdLabel = [[UILabel alloc] init];
        [self addSubview:_userIdLabel];
    }
    return _userIdLabel;
}

@end
