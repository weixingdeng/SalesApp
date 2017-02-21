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

#define     PAGE_MESSAGE_COUNT      15

@interface EHIChatMessageDisplayView()

@property (nonatomic, strong) MJRefreshNormalHeader *refresHeader;

/// 用户决定新消息是否显示时间
@property (nonatomic, strong) NSDate *curDate;

@end

@implementation EHIChatMessageDisplayView
@synthesize data = _data;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = HEXCOLOR_F5F7FE;
        [self addSubview:self.chatDetailTable];
        [self registerCellClassForTableView:self.chatDetailTable];
       
        [self.chatDetailTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        //添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchTableView)];
        [self.chatDetailTable addGestureRecognizer:tap];
    }
    return self;
}

- (void)addMessage:(EHIMessage *)message
{
    [self.data addObject:message];
    [self.chatDetailTable reloadData];

}

//重置
- (void)resetMessageView
{
    [self.chatDetailTable setMj_header:self.refresHeader];
    self.curDate = [NSDate date];
    
    WEAKSELF(self);
    [self p_tryToRefreshMoreRecord:^(NSInteger count, BOOL hasMore) {
        if (!hasMore) {
            weakself.chatDetailTable.mj_header = nil;
        }
        if (count > 0) {
            [weakself.chatDetailTable reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.chatDetailTable scrollToBottomWithAnimation:NO];
            });
        }
    }];
}
/**
 *  获取聊天历史记录
 */
- (void)p_tryToRefreshMoreRecord:(void(^)(NSInteger count, BOOL hasMore))complete
{
    WEAKSELF(self);
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayView:getRecordsFromDate:count:completed:)]) {
        
        [self.delegate chatMessageDisplayView:self
                           getRecordsFromDate:self.curDate
                                        count:PAGE_MESSAGE_COUNT
                                    completed:^(NSDate *date, NSArray *array, BOOL hasMore) {
                                        if (array.count > 0 && [date isEqualToDate:weakself.curDate]) {
                                            weakself.curDate = [array[0] date];
                                            [weakself.data insertObjects:array atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, array.count)]];
                                            complete(array.count, hasMore);
                                        }
                                        else {
                                            complete(0, hasMore);
                                        }
                                    }];
    }
}

- (void)setData:(NSMutableArray *)data
{
    _data = data;
    [self.chatDetailTable reloadData];
}

//滑到底部
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

//数据源
- (NSMutableArray *)data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _data;
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

- (MJRefreshNormalHeader *)refresHeader
{
    if (_refresHeader == nil) {
        WEAKSELF(self);
        _refresHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself p_tryToRefreshMoreRecord:^(NSInteger count, BOOL hasMore) {
                [weakself.chatDetailTable.mj_header endRefreshing];
                if (!hasMore) {
                    weakself.chatDetailTable.mj_header = nil;
                }
                if (count > 0) {
                    [weakself.chatDetailTable reloadData];
                    [weakself.chatDetailTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
            }];
        }];
        _refresHeader.lastUpdatedTimeLabel.hidden = YES;
        _refresHeader.stateLabel.hidden = YES;
    }
    return _refresHeader;
}


@end
