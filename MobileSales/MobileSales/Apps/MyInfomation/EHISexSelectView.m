//
//  EHISexSelectView.m
//  MobileSales
//
//  Created by dengwx on 2017/2/20.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHISexSelectView.h"

#define ICON_WIDTH 40
#define LABEL_WIDTH 20

@implementation EHISexSelectView

- (instancetype)initWithSelectBoy:(BOOL)isSelectBoy
{
    self = [super init];
    if (self) {
        [self setSexView:isSelectBoy];
    }
    return self;
}

- (void)setSexView:(BOOL)isSelectBoy
{
    UIImageView *boyImgView = [[UIImageView alloc] init];
    [self addSubview:boyImgView];
    
    if (isSelectBoy) {
        boyImgView.image = EHI_LOAD_IMAGE(@"myinfo_boy_select");
    }else
    {
        boyImgView.image = EHI_LOAD_IMAGE(@"myinfo_boy");
    }
    
    UILabel *boyLable = [[UILabel alloc] init];
    boyLable.textColor = HEXCOLOR_333333;
    boyLable.font = autoFont(14);
    boyLable.text = @"男";
    boyLable.textAlignment = NSTextAlignmentRight;
    [self addSubview:boyLable];
    
    UIImageView *girlImgView = [[UIImageView alloc] init];
    [self addSubview:girlImgView];
    
    if (isSelectBoy) {
        girlImgView.image = EHI_LOAD_IMAGE(@"myinfo_girl");
    }else
    {
        girlImgView.image = EHI_LOAD_IMAGE(@"myinfo_girl_select");
    }
    
    UILabel *girlLabel = [[UILabel alloc] init];
    girlLabel.textColor = HEXCOLOR_333333;
    girlLabel.font = autoFont(14);
    girlLabel.text = @"女";
    girlLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:girlLabel];
    
    //添加masonry
    [boyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.mas_equalTo(self.mas_centerX).offset(-autoWidthOf6(17));
        make.width.mas_equalTo(LABEL_WIDTH);
    }];
    
    [boyImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.mas_equalTo(boyLable.mas_left).offset(-autoWidthOf6(10));
        make.width.mas_equalTo(ICON_WIDTH);
    }];
    
    [girlImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.mas_equalTo(self.mas_centerX).offset(autoWidthOf6(17));
        make.width.mas_equalTo(ICON_WIDTH);
    }];
    
    [girlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.mas_equalTo(girlImgView.mas_right).offset(autoWidthOf6(10));
        make.width.mas_equalTo(LABEL_WIDTH);
    }];
    
}


@end
