//
//  EHIChatBar.m
//  MobileSales
//
//  Created by dengwx on 17/2/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatBar.h"

@interface EHIChatBar()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *sendBtn;

@end

@implementation EHIChatBar

- (instancetype)init
{
    if (self = [super init]) {
        [self setBackgroundColor:HEXCOLOR_F7F7F7];
        
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
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.textView);
        make.right.offset(-14);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(50);
    }];
}

#pragma mark - Private Methods
- (void)p_reloadTextViewWithAnimation:(BOOL)animation
{
    CGFloat textHeight = [self.textView sizeThatFits:CGSizeMake(self.textView.width, MAXFLOAT)].height;
    CGFloat height = textHeight > 36 ? textHeight : 36;
    height = (textHeight <= 111.5 ? textHeight : 111.5);
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
            } completion:^(BOOL finished) {
                if (textHeight > height) {
                    [self.textView setContentOffset:CGPointMake(0, textHeight - height) animated:YES];
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){
        NSLog(@"发送");
        return NO;
    }
    else if (textView.text.length > 0 && [text isEqualToString:@""]) {       // delete
        if ([textView.text characterAtIndex:range.location] == ']') {
            NSUInteger location = range.location;
            NSUInteger length = range.length;
            while (location != 0) {
                location --;
                length ++ ;
                char c = [textView.text characterAtIndex:location];
                if (c == '[') {
                    textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
                    [self p_reloadTextViewWithAnimation:YES];
                    return NO;
                }
                else if (c == ']') {
                    return YES;
                }
            }
        }
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
        [_sendBtn.layer setCornerRadius:4.0f];
	}
	return _sendBtn;
}




@end
