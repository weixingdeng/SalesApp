//
//  EHIChatMessageDisplayView.h
//  MobileSales
//
//  Created by dengwx on 17/2/17.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHIChatMessageDisplayViewDelegate.h"

@interface EHIChatMessageDisplayView : UIView

@property (nonatomic, assign) id<EHIChatMessageDisplayViewDelegate>delegate;

@property (nonatomic , strong) UITableView *chatDetailTable;

/**
 *  发送消息（在列表展示）
 */
//- (void)addMessage:(NSString *)message;

/**
 *  滚动到底部
 *
 *  @param animation 是否执行动画
 */
- (void)scrollToBottomWithAnimation:(BOOL)animation;

@end
