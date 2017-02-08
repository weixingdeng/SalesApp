//
//  UITabBar+EHIBadge.h
//  MobileSales
//
//  Created by dengwx on 17/2/7.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (EHIBadge)

//显示小红点
- (void)showBadgeOnItemIndex:(int)index;

//隐藏小红点
- (void)hideBedgeOnItemIndex:(int)index;

//总的tabbaritem数量 
- (void)showBadgeOnItemIndex:(int)index totalItemCount:(int)count;

@end
