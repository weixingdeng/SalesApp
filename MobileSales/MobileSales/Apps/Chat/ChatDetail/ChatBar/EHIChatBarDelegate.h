//
//  EHIChatBarDelegate.h
//  MobileSales
//
//  Created by dengwx on 17/2/17.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EHIChatBar;
@protocol EHIChatBarDelegate <NSObject>

@optional
/**
 *  发送文字
 */
- (void)chatBar:(EHIChatBar *)chatBar sendText:(NSString *)text;


/**
 *  输入框高度改变
 */
- (void)chatBar:(EHIChatBar *)chatBar didChangeTextViewHeight:(CGFloat)height;

@end
