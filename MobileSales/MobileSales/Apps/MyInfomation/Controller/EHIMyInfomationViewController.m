//
//  EHIMyInfomationViewController.m
//  MobileSales
//
//  Created by dengwx on 17/2/20.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIMyInfomationViewController.h"
#import "EHISexSelectView.h"
#import "EHILoginViewController.h"

@interface EHIMyInfomationViewController ()

@property (nonatomic , strong) EHISexSelectView *sexView;

@end

@implementation EHIMyInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
    
    [self.view addSubview:self.iconImgView];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.userNoLabel];
    [self.view addSubview:self.sexLabel];
    [self.view addSubview:self.sexView];
    [self.view addSubview:self.exitBtn];
    
    [self addMasonry];
}

- (void)addMasonry
{
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(autoHeightOf6(40));
        make.height.mas_equalTo(autoHeightOf6(50));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(self.iconImgView.mas_bottom).offset(autoHeightOf6(19));
    }];
    
    [self.userNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(autoHeightOf6(15));
    }];
    
    [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(self.userNoLabel.mas_bottom).offset(autoHeightOf6(15));
    }];
    
    [self.sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.sexLabel.mas_bottom).offset(autoHeightOf6(15));
    }];
    
    [self.exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.right.offset(-40);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.sexView.mas_bottom).offset(autoHeightOf6(70));
    }];
}

- (void)exitLogin
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USER_ID_KEY];
    SHARE_USER_CONTEXT.user.user_id = nil;
    SHARE_USER_CONTEXT.user.user_name = nil;
    SHARE_USER_CONTEXT.user.user_sex = nil;
    self.window.rootViewController = [[EHILoginViewController alloc] init];
}

- (UIImageView *)iconImgView {
	if (_iconImgView == nil) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
        if (self.isBoy) {
            _iconImgView.image = EHI_LOAD_IMAGE(@"myinfo_boy_icon");
        }else
        {
            _iconImgView.image = EHI_LOAD_IMAGE(@"myinfo_girl_icon");
        }
	}
	return _iconImgView;
}

- (EHIShowInfoLabel *)nameLabel {
	if (_nameLabel == nil) {
        _nameLabel = [[EHIShowInfoLabel alloc] init];
        _nameLabel.text = SHARE_USER_CONTEXT.user.user_name;
	}
	return _nameLabel;
}

- (EHIShowInfoLabel *)userNoLabel {
	if (_userNoLabel == nil) {
        _userNoLabel = [[EHIShowInfoLabel alloc] init];
        _userNoLabel.text = [NSString stringWithFormat:@"工号:%@",SHARE_USER_CONTEXT.user.user_id];
	}
	return _userNoLabel;
}

- (EHIShowInfoLabel *)sexLabel {
    if (_sexLabel == nil) {
        _sexLabel = [[EHIShowInfoLabel alloc] init];
        _sexLabel.text = @"性别";
    }
    return _sexLabel;
}

- (EHISexSelectView *)sexView
{
    if (!_sexView) {
        _sexView = [[EHISexSelectView alloc] initWithSelectBoy:NO];
    }
    return _sexView;
}
- (UIButton *)exitBtn {
	if (_exitBtn == nil) {
        _exitBtn = [[UIButton alloc] init];
        [_exitBtn setTitle:@"退出" forState:UIControlStateNormal];
        _exitBtn.backgroundColor = HEXCOLOR_718DDE;
        _exitBtn.layer.cornerRadius = 4;
        _exitBtn.clipsToBounds = YES;
        [_exitBtn addTarget:self action:@selector(exitLogin) forControlEvents:UIControlEventTouchUpInside];

	}
	return _exitBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
