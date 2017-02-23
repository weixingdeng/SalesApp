//
//  EHIMessageBaseCell.m
//  MobileSales
//
//  Created by dengwx on 17/2/19.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIMessageBaseCell.h"
#import "NSDate+EHIChatFormat.h"

#define     TIMELABEL_HEIGHT    20.0f
#define     TIMELABEL_SPACE_Y   10.0f

#define     NAMELABEL_HEIGHT    14.0f
#define     NAMELABEL_SPACE_X   12.0f
#define     NAMELABEL_SPACE_Y   1.0f

#define     AVATAR_WIDTH        40.0f
#define     AVATAR_SPACE_X      8.0f
#define     AVATAR_SPACE_Y      12.0f

#define     MSGBG_SPACE_X       5.0f
#define     MSGBG_SPACE_Y       1.0f

#define     ACTIVITY_WIDTH      40.0f



@interface EHIMessageBaseCell()

@end

@implementation EHIMessageBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.avatarButton];
        [self.contentView addSubview:self.usernameLabel];
        [self.contentView addSubview:self.messageBackgroundView];
        [self.contentView addSubview:self.activityView];
        [self.contentView addSubview:self.sendAgainBtn];
        [self addMasonry];
    }
    return self;
}

- (void)addMasonry
{
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(TIMELABEL_SPACE_Y);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarButton).mas_equalTo(-NAMELABEL_SPACE_Y);
        make.right.mas_equalTo(self.avatarButton.mas_left).mas_offset(- NAMELABEL_SPACE_X);
    }];
    
    // 默认是在右边 使用时候重新布局
    [self.avatarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-AVATAR_SPACE_X);
        make.width.and.height.mas_equalTo(AVATAR_WIDTH);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(AVATAR_SPACE_Y);
    }];
    
    [self.messageBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.avatarButton.mas_left).mas_offset(-MSGBG_SPACE_X);
        make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_offset(-MSGBG_SPACE_Y);
    }];
    
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.messageBackgroundView);
        make.right.mas_equalTo(self.messageBackgroundView.mas_left).offset(-STATUS_GAP);
        make.height.width.mas_equalTo(ACTIVITY_WIDTH);
    }];
    
    [self.sendAgainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.messageBackgroundView);
        make.right.mas_equalTo(self.messageBackgroundView.mas_left).offset(-STATUS_GAP);
        make.height.width.mas_equalTo(SEND_AGAIN_WIDTH);
    }];
}

- (void)setMessage:(EHIMessage *)message
{
    [self.timeLabel setText:[NSString stringWithFormat:@"  %@  ", message.date.chatTimeFormat]];
    [self.usernameLabel setText:message.sendName];
  
    [self.avatarButton setImage:[UIImage imageNamed:@"myinfo_girl_icon"] forState:UIControlStateNormal];
  
    
    // 时间
    [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(message.showTime ? TIMELABEL_HEIGHT : 0);
        make.top.mas_equalTo(self.contentView).mas_offset(message.showTime ? TIMELABEL_SPACE_Y : 0);
    }];
    
    // 头像
    [self.avatarButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(AVATAR_WIDTH);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(AVATAR_SPACE_Y);
        if(message.ownerTyper == EHIMessageOwnerTypeSelf) {
            make.right.mas_equalTo(self.contentView).mas_offset(-AVATAR_SPACE_X);
        }
        else {
            make.left.mas_equalTo(self.contentView).mas_offset(AVATAR_SPACE_X);
        }
    }];
    
    // 用户名
    [self.usernameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarButton).mas_equalTo(-NAMELABEL_SPACE_Y);
        if (message.ownerTyper == EHIMessageOwnerTypeSelf) {
            make.right.mas_equalTo(self.avatarButton.mas_left).mas_offset(- NAMELABEL_SPACE_X);
        }
        else {
            make.left.mas_equalTo(self.avatarButton.mas_right).mas_equalTo(NAMELABEL_SPACE_X);
        }
    }];
    
    // 背景
    [self.messageBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        message.ownerTyper == EHIMessageOwnerTypeSelf ? make.right.mas_equalTo(self.avatarButton.mas_left).mas_offset(-MSGBG_SPACE_X) : make.left.mas_equalTo(self.avatarButton.mas_right).mas_offset(MSGBG_SPACE_X);
        make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_offset(message.showName ? 0 : -MSGBG_SPACE_Y);
    }];
    
    
    
//    if (message.ownerTyper == EHIMessageOwnerTypeSelf) {
        switch (message.sendState) {
            case EHIMessageSending:{
                [self.activityView startAnimating];
                self.sendAgainBtn.hidden = YES;
                break;
            }
                
            case EHIMessageSendSuccess:{
                [self.activityView stopAnimating];
                self.sendAgainBtn.hidden = YES;
                break;
            }
                
            case EHIMessageSendFail:{
                self.sendAgainBtn.hidden = message.ownerTyper == EHIMessageOwnerTypeFriend;
                break;
            }
            default:
                break;
        }
//    }else
//    {
//        self.sendAgainBtn.hidden = YES;
//    }
    
    [self.usernameLabel setHidden:!message.showName];
    [self.usernameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(message.showName ? NAMELABEL_HEIGHT : 0);
    }];
    _message = message;
}


#pragma mark - Getter -
- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [_timeLabel setTextColor:[UIColor whiteColor]];
        [_timeLabel setBackgroundColor:HEXCOLOR_D4D4D4];
        [_timeLabel.layer setMasksToBounds:YES];
        [_timeLabel.layer setCornerRadius:5.0f];
    }
    return _timeLabel;
}

- (UIButton *)avatarButton
{
    if (_avatarButton == nil) {
        _avatarButton = [[UIButton alloc] init];
        [_avatarButton.layer setMasksToBounds:YES];
        [_avatarButton addTarget:self action:@selector(avatarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _avatarButton;
}

- (UILabel *)usernameLabel
{
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc] init];
        [_usernameLabel setTextColor:[UIColor grayColor]];
        [_usernameLabel setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _usernameLabel;
}

- (UIImageView *)messageBackgroundView
{
    if (_messageBackgroundView == nil) {
        _messageBackgroundView = [[UIImageView alloc] init];
        [_messageBackgroundView setUserInteractionEnabled:YES];
    }
    return _messageBackgroundView;
}

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] init];
        _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
    return _activityView;
}

- (UIButton *)sendAgainBtn
{
    if (!_sendAgainBtn) {
        _sendAgainBtn = [[UIButton alloc] init];
        [_sendAgainBtn setBackgroundImage:EHI_LOAD_IMAGE(@"chat_sendagain") forState:UIControlStateNormal];
        [_sendAgainBtn addTarget:self action:@selector(sendAgainBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendAgainBtn;
}

//重发按钮
- (void)sendAgainBtnClick
{
    if (_delegate && [_delegate respondsToSelector:@selector(messageCellDidClickSendAgainForMessage:)]) {
        [_delegate messageCellDidClickSendAgainForMessage:self.message];
    }
}

//头像点击
- (void)avatarButtonClick
{
    if (_delegate && [_delegate respondsToSelector:@selector(messageCellDidClickAvatarForMessage:)]) {
        [_delegate messageCellDidClickAvatarForMessage:self.message];
    }
}



@end
