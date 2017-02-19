//
//  EHIChatMessageDisplayView.h
//  MobileSales
//
//  Created by dengwx on 17/2/17.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHIChatMessageDisplayViewDelegate.h"
#import "EHIMessage.h"

#import "EHITextMessage.h"

@interface EHIChatMessageDisplayView : UIView

@property (nonatomic, assign) id<EHIChatMessageDisplayViewDelegate>delegate;

@property (nonatomic , strong) UITableView *chatDetailTable;

@property (nonatomic, strong) NSMutableArray *data; //聊天数据

/**
 *  发送消息（在列表展示）
 */
- (void)addMessage:(NSString *)message;

/**
 *  滚动到底部
 *
 *  @param animation 是否执行动画
 */
- (void)scrollToBottomWithAnimation:(BOOL)animation;

//重置页面(第一次进入刷新记录)
//有个坑 如果放到init会失败 这时候delegate还没有设置 所以提出来
//暂时这么写 待改
- (void)resetMessageView;

@end
