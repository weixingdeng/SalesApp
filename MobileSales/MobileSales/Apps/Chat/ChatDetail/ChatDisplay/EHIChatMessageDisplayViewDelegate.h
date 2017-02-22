//
//  EHIChatMessageDisplayViewDelegate.h
//  MobileSales
//
//  Created by dengwx on 17/2/17.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EHIChatMessageDisplayView;
@class EHIMessage;
@protocol EHIChatMessageDisplayViewDelegate <NSObject>

/**
 *  聊天界面点击事件，用于收键盘
 */
- (void)chatMessageDisplayViewDidTouched:(EHIChatMessageDisplayView *)chatTVC;

/**
 *  下拉刷新，获取某个时间段的聊天记录（异步）
 *
 *  @param chatTVC   chatTVC
 *  @param date      开始时间
 *  @param count     条数
 *  @param completed 结果Blcok
 */
- (void)chatMessageDisplayView:(EHIChatMessageDisplayView *)chatTVC
            getRecordsFromDate:(NSDate *)date
                         count:(NSUInteger)count
                     completed:(void (^)(NSDate *, NSArray *, BOOL))completed;

/**
 *  用户头像点击事件
 */
- (void)chatMessageDisplayView:(EHIChatMessageDisplayView *)chatTVC
            didClickMessageAvatar:(EHIMessage *)message;

/**
 *  重发消息点击事件
 */
- (void)chatMessageDisplayView:(EHIChatMessageDisplayView *)chatTVC
         didClickMessageSendAgain:(EHIMessage *)message;

@end
