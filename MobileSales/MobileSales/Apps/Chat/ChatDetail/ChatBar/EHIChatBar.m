//
//  EHIChatBar.m
//  MobileSales
//
//  Created by dengwx on 17/2/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatBar.h"

#define     HEIGHT_CHATBAR_TEXTVIEW         36.0f
#define     HEIGHT_MAX_CHATBAR_TEXTVIEW     111.5f

@interface EHIChatBar()<UITextViewDelegate>

@property (nonatomic, strong) UIButton *sendBtn;

@end

@implementation EHIChatBar

- (instancetype)init
{
    if (self = [super init]) {
        [self setBackgroundColor:HEXCOLOR_F5F5F6];
        
        [self addSubview:self.textView];
        [self addSubview:self.sendBtn];
        
        [self addMasonry];
    }
    return self;
}

- (void)addMasonry
{
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(6);
        make.bottom.offset(-6);
        make.left.offset(14);
        make.right.equalTo(self.sendBtn.mas_left).offset(-6);
        make.height.mas_equalTo(36);
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(36);
        make.right.offset(-14);
        make.bottom.mas_equalTo(-6);
        make.width.mas_equalTo(60);
    }];
}

#pragma mark - Private Methods
- (void)p_reloadTextViewWithAnimation:(BOOL)animation
{
    CGFloat textHeight = [self.textView sizeThatFits:CGSizeMake(self.textView.width, MAXFLOAT)].height;
    CGFloat height = textHeight > HEIGHT_CHATBAR_TEXTVIEW ? textHeight : HEIGHT_CHATBAR_TEXTVIEW;
    height = (textHeight <= HEIGHT_MAX_CHATBAR_TEXTVIEW ? textHeight : HEIGHT_MAX_CHATBAR_TEXTVIEW);
    [self.textView setScrollEnabled:textHeight > height];
    if (height != self.textView.height) {
        if (animation) {
            [UIView animateWithDuration:0.2 animations:^{
                [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(height);
                }];
                if (self.superview) {
                    [self.superview layoutIfNeeded];
                }
                if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:didChangeTextViewHeight:)]) {
                    [self.delegate chatBar:self didChangeTextViewHeight:self.textView.height];
                }
            } completion:^(BOOL finished) {
                if (textHeight > height) {
                    [self.textView setContentOffset:CGPointMake(0, textHeight - height) animated:YES];
                }
                if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:didChangeTextViewHeight:)]) {
                    [self.delegate chatBar:self didChangeTextViewHeight:height];
                }
            }];
        }
        else {
            [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
            if (self.superview) {
                [self.superview layoutIfNeeded];
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:didChangeTextViewHeight:)]) {
                [self.delegate chatBar:self didChangeTextViewHeight:height];
            }
            if (textHeight > height) {
                [self.textView setContentOffset:CGPointMake(0, textHeight - height) animated:YES];
            }
        }
    }
    else if (textHeight > height) {
        if (animation) {
            CGFloat offsetY = self.textView.contentSize.height - self.textView.height;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.textView setContentOffset:CGPointMake(0, offsetY) animated:YES];
            });
        }
        else {
            [self.textView setContentOffset:CGPointMake(0, self.textView.contentSize.height - self.textView.height) animated:NO];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

#pragma mark - Public Methods
- (void)sendCurrentText
{
    if (self.textView.text.length > 0) {     // send Text
        if (_delegate && [_delegate respondsToSelector:@selector(chatBar:sendText:)]) {
            [_delegate chatBar:self sendText:self.textView.text];
        }
    }
    [self.textView setText:@""];
    [self p_reloadTextViewWithAnimation:YES];
}

#pragma mark - Delegate -
//MARK: UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //回车发送信息
    if ([text isEqualToString:@"\n"]){
        [self sendCurrentText];
        return NO;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self p_reloadTextViewWithAnimation:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self p_reloadTextViewWithAnimation:YES];
}

#pragma mark lazy load
- (UITextView *)textView {
	if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        [_textView setFont:[UIFont systemFontOfSize:16.0f]];
        [_textView setReturnKeyType:UIReturnKeySend];
        [_textView.layer setMasksToBounds:YES];
        [_textView.layer setBorderWidth:EHI_ONE_PIXEL];
        [_textView.layer setBorderColor:HEXCOLOR_D4D4D4.CGColor];
        [_textView.layer setCornerRadius:4.0f];
        [_textView setDelegate:self];
        [_textView setScrollsToTop:NO];

	}
	return _textView;
}
- (UIButton *)sendBtn {
	if (_sendBtn == nil) {
        _sendBtn = [[UIButton alloc] init];
        [_sendBtn setBackgroundColor:HEXCOLOR_718DDE];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(sendCurrentText) forControlEvents:UIControlEventTouchUpInside];
        [_sendBtn.layer setCornerRadius:4.0f];
	}
	return _sendBtn;
}




@end
