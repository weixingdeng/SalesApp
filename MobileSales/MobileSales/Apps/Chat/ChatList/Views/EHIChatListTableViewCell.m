//
//  EHIChatListTableViewCell.m
//  MobileSales
//
//  Created by dengwx on 17/2/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatListTableViewCell.h"
#import "NSDate+EHIChatFormat.h"

@interface EHIChatListTableViewCell()

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) UILabel *lastMsgLabel;

@property (nonatomic , strong) UILabel *timeLabel;

@property (nonatomic , strong) UIView *redIconView; //未读信息小红点

@end

@implementation EHIChatListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    [self.contentView addSubview:self.iconLabel];
    [self.contentView addSubview:self.redIconView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.lastMsgLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.redIconView];
    
    [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(autoHeightOf6(10));
        make.bottom.offset(-autoHeightOf6(10));
        make.width.equalTo(self.iconLabel.mas_height);
        make.left.offset(autoWidthOf6(18));
    }];
    
    [self.redIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(10);
        make.top.equalTo(self.iconLabel.mas_top).offset(1);
        make.right.equalTo(self.iconLabel.mas_right).offset(-1);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconLabel.mas_right).offset(autoWidthOf6(18));
        make.top.offset(autoHeightOf6(14));
        make.height.equalTo(@(autoHeightOf6(20)));
        make.right.equalTo(self.timeLabel.mas_left);
    }];
    
    [self.lastMsgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.titleLabel.mas_right);
        make.bottom.offset(-autoHeightOf6(14));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_top);
        make.right.offset(-18);
        make.width.equalTo(@(80));
        make.height.equalTo(@18);
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.iconLabel.layer.cornerRadius = CGRectGetHeight(self.iconLabel.frame)/2;
    self.iconLabel.clipsToBounds = YES;
}

- (void)setChatListModel:(EHIChatListModel *) chatListModel {

    //设置填充数据时候 立刻刷新视图 (为了切圆角)
    [self.iconLabel layoutIfNeeded];
    
    if (_chatListModel != chatListModel) {
        _chatListModel = chatListModel;
    }
    [self.iconLabel setText:chatListModel.ShortName];
    [self.titleLabel setText:chatListModel.NodeName];
    [self.redIconView setHidden:chatListModel.isRead];
    [self.timeLabel setText:chatListModel.date.chatListTimeInfo];
    
    NSDictionary *contentDic = [chatListModel.content mj_JSONObject];
    if (chatListModel.senderName.length && [contentDic[@"text"] length]) {
        NSString *showString = [NSString stringWithFormat:@"%@:%@",chatListModel.senderName,contentDic[@"text"]];
        [self.lastMsgLabel setText:showString];
    }else
    {
        [self.lastMsgLabel setText:@""];
    }
}


- (UILabel *)iconLabel {
	if (_iconLabel == nil) {
        _iconLabel = [[UILabel alloc] init];
        _iconLabel.textAlignment = NSTextAlignmentCenter;
        _iconLabel.textColor = [UIColor whiteColor];
        _iconLabel.font = [UIFont boldSystemFontOfSize:14];
	}
	return _iconLabel;
}

- (UILabel *)titleLabel {
	if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = HEXCOLOR_333333;
        _titleLabel.font = autoFont(15);
	}
	return _titleLabel;
}

- (UILabel *)lastMsgLabel {
	if (_lastMsgLabel == nil) {
        _lastMsgLabel = [[UILabel alloc] init];
        _lastMsgLabel.textColor = HEXCOLOR_B6B6B6;
        _lastMsgLabel.font = autoFont(12);
	}
	return _lastMsgLabel;
}

- (UILabel *)timeLabel {
	if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = HEXCOLOR_B6B6B6;
        _timeLabel.font = autoFont(12);
	}
	return _timeLabel;
}
- (UIView *)redIconView {
	if (_redIconView == nil) {
        _redIconView = [[UIView alloc] init];
        _redIconView.backgroundColor = [UIColor redColor];
        _redIconView.layer.cornerRadius = 5;
        _redIconView.clipsToBounds = YES;
	}
	return _redIconView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
