//
//  EHIMyInfomationViewController.m
//  MobileSales
//
//  Created by dengwx on 17/2/20.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIMyInfomationViewController.h"

@interface EHIMyInfomationViewController ()
//头像
@property (nonatomic , strong) UIImageView  *iconImgView;

//姓名
@property (nonatomic , strong) UILabel  *nameLabel;

//工号
@property (nonatomic , strong) UILabel  *userNoLabel;

//退出按钮
@property (nonatomic , strong) UIButton  *exitBtn;


@end

@implementation EHIMyInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIImageView *)iconImgView {
	if (_iconImgView == nil) {
        _iconImgView = [[UIImageView alloc] init];
	}
	return _iconImgView;
}
- (UILabel *)nameLabel {
	if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
	}
	return _nameLabel;
}
- (UILabel *)userNoLabel {
	if (_userNoLabel == nil) {
        _userNoLabel = [[UILabel alloc] init];
	}
	return _userNoLabel;
}
- (UIButton *)exitBtn {
	if (_exitBtn == nil) {
        _exitBtn = [[UIButton alloc] init];
	}
	return _exitBtn;
}

@end
