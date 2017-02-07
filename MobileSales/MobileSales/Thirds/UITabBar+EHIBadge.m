//
//  UITabBar+EHIBadge.m
//  MobileSales
//
//  Created by dengwx on 17/2/7.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "UITabBar+EHIBadge.h"

@implementation UITabBar (EHIBadge)

- (void)showBadgeOnItemIndex:(int)index totalItemCount:(int)count {
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5;//圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / count;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);//圆形大小为10
    [self addSubview:badgeView];

}

- (void)showBadgeOnItemIndex:(int)index {
    //显示小红点
   	[self showBadgeOnItemIndex:index totalItemCount:4];
}

- (void)hideBedgeOnItemIndex:(int)index {
    //隐藏小红点
    [self removeBadgeOnItemIndex:index];
	
}

//移除小红点
- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}





@end
