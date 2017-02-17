//
//  EHIChatMessageDisplayViewDelegate.h
//  MobileSales
//
//  Created by dengwx on 17/2/17.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EHIChatMessageDisplayView;
@protocol EHIChatMessageDisplayViewDelegate <NSObject>

/**
 *  聊天界面点击事件，用于收键盘
 */
- (void)chatMessageDisplayViewDidTouched:(EHIChatMessageDisplayView *)chatTVC;

@end
