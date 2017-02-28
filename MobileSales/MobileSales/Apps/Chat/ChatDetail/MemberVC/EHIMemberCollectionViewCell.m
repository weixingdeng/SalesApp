//
//  EHIMemberCollectionViewCell.m
//  MobileSales
//
//  Created by dengwx on 2017/2/21.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIMemberCollectionViewCell.h"

@interface EHIMemberCollectionViewCell()

@property (nonatomic , strong) UIImageView *iconImgView;
@property (nonatomic , strong) UILabel *nameLabel;

@end

@implementation EHIMemberCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.iconImgView];
        [self.contentView addSubview:self.nameLabel];
        
        [self addMasonry];
    }
    return self;
}

- (void)addMasonry
{
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(autoHeightOf6(45));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.iconImgView.mas_bottom).offset(3);
        make.height.mas_equalTo(autoHeightOf6(16));
    }];
}

- (void)setName:(NSString *)name
{
    if (name) {
        self.nameLabel.text = name;
    }
}

- (void)setIsBoy:(BOOL)isBoy
{
    if (isBoy) {
        [self.iconImgView setImage:EHI_LOAD_IMAGE(@"myinfo_boy_icon")];
    }else
    {
        [self.iconImgView setImage:EHI_LOAD_IMAGE(@"myinfo_girl_icon")];
    }
}

- (UIImageView *)iconImgView
{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImgView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = autoFont(10);
        _nameLabel.textColor = HEXCOLOR_333333;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

@end
