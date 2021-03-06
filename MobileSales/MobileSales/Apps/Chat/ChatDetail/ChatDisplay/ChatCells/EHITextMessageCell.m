//
//  EHITextMessageCell.m
//  MobileSales
//
//  Created by dengwx on 17/2/19.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHITextMessageCell.h"
#import "EHITextMessage.h"
#import "EHIChatLabel.h"
#import "UIImage+EHIResize.h"

@interface EHITextMessageCell()

@property (nonatomic, strong) EHIChatLabel *messageLabel;

@end

#define     MSG_SPACE_TOP       14
#define     MSG_SPACE_BTM       14
#define     MSG_SPACE_LEFT      19
#define     MSG_SPACE_RIGHT     22

@implementation EHITextMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.messageLabel];
    }
    return self;
}

- (void)setMessage:(EHITextMessage *)message
{
//    EHIMessageOwnerType lastOwnType = self.message ? self.message.ownerTyper : -1;
    [super setMessage:message];
    self.messageLabel.text = message.text;
    
    [self.messageLabel setContentCompressionResistancePriority:500 forAxis:UILayoutConstraintAxisHorizontal];
    [self.messageBackgroundView setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
    
    if (message.ownerTyper == EHIMessageOwnerTypeSelf) {
        [_messageLabel setTextColor:[UIColor whiteColor]];
        [self.messageBackgroundView setImage:[UIImage resizeImage:@"chat_send"]];
        
        [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.messageBackgroundView).mas_offset(-MSG_SPACE_RIGHT);
            make.top.mas_equalTo(self.messageBackgroundView).mas_offset(MSG_SPACE_TOP);
        }];
        [self.messageBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.messageLabel).mas_offset(-MSG_SPACE_LEFT);
            make.bottom.mas_equalTo(self.messageLabel).mas_offset(MSG_SPACE_BTM);
        }];
    }
    else if (message.ownerTyper == EHIMessageOwnerTypeFriend){
        [_messageLabel setTextColor:HEXCOLOR_333333];
        [self.messageBackgroundView setImage:[UIImage resizeImage:@"chat_recive"]];
        
        [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.messageBackgroundView).mas_offset(MSG_SPACE_LEFT);
            make.top.mas_equalTo(self.messageBackgroundView).mas_offset(MSG_SPACE_TOP);
        }];
        [self.messageBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.messageLabel).mas_offset(MSG_SPACE_RIGHT);
            make.bottom.mas_equalTo(self.messageLabel).mas_offset(MSG_SPACE_BTM);
        }];
    }
    
    [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(message.messageFrame.contentSize);
    }];
}

#pragma mark - Getter -
- (EHIChatLabel *)messageLabel
{
    if (_messageLabel == nil) {
        _messageLabel = [[EHIChatLabel alloc] init];
        _messageLabel.copyingEnabled = YES;
        _messageLabel.shouldUseLongPressGestureRecognizer = YES;
        [_messageLabel setFont:EHI_FONT(14)];
        [_messageLabel setNumberOfLines:0];
    }
    return _messageLabel;
}

@end
