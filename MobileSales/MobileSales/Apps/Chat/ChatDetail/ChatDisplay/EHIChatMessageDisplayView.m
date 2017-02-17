//
//  EHIChatMessageDisplayView.m
//  MobileSales
//
//  Created by dengwx on 17/2/17.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatMessageDisplayView.h"
#import "UITableView+TLChat.h"
#import "EHIChatMessageDisplayView+Delegate.h"

@implementation EHIChatMessageDisplayView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.chatDetailTable];
//        [self registerCellClassForTableView:self.tableView];
        
        [self.chatDetailTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        //添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchTableView)];
        [self.chatDetailTable addGestureRecognizer:tap];
        
//        [self.tableView addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)scrollToBottomWithAnimation:(BOOL)animation
{
    [self.chatDetailTable scrollToBottomWithAnimation:animation];
}

//table点击 键盘失去响应
- (void)didTouchTableView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayViewDidTouched:)]) {
        [self.delegate chatMessageDisplayViewDidTouched:self];
    }
}


- (UITableView *)chatDetailTable
{
    if (_chatDetailTable == nil) {
        _chatDetailTable = [[UITableView alloc] init];
        [_chatDetailTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_chatDetailTable setBackgroundColor:[UIColor clearColor]];
        [_chatDetailTable setTableFooterView:[UIView new]];
        [_chatDetailTable setDelegate:self];
        [_chatDetailTable setDataSource:self];
    }
    return _chatDetailTable;
}


@end
