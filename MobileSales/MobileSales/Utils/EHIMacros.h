//
//  EHICommonUtils.h
//  MobileSales
//
//  Created by dengwx on 17/1/11.
//  Copyright © 2017年 wxdeng. All rights reserved.
//  宏定义

#import <Foundation/Foundation.h>
#import "UIColor+ColorWithHex.h"

typedef void(^EHIOnSuccessBlock)(id result);
typedef void(^EHIOnFailureBlock)(id error);
typedef void(^EHISelectCallback)(NSInteger selectIndex);

#define EHI_LOAD_IMAGE(imageName) \
[UIImage imageNamed:imageName]

//系统

#define VERSION_EQUAL_OR_LATER(_version) \
( [[[UIDevice currentDevice] systemVersion] compare:(@#_version)] != NSOrderedAscending )



//app version
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//system version
#define kSystemVersion [[UIDevice currentDevice] systemVersion]

//适配


#define EHI_ONE_PIXEL 1.f/[UIScreen mainScreen].scale

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS  (SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (SCREEN_MAX_LENGTH == 736.0)

#define autoSizeScaleX_iPhone6 (SCREEN_WIDTH/375)

#define autoSizeScaleH_iPhone6 (SCREEN_HEIGHT/667)
//autoscale with iPhone6
#define autoHeightOf6(HEIGHT) HEIGHT * autoSizeScaleH_iPhone6
#define autoWidthOf6(WIDTH) WIDTH * autoSizeScaleX_iPhone6

#define EHI_FONT(SIZE) [UIFont systemFontOfSize:SIZE]
#define autoFont(SIZE) IS_IPHONE_6P ? EHI_FONT(SIZE * 1.1) :  EHI_FONT(SIZE)

#pragma mark --颜色

#define HEXCOLOR(COLOR) [UIColor colorWithHexString:COLOR]

#define HEXCOLOR_718DDE HEXCOLOR(@"#718dde") //tabbar选中颜色
#define HEXCOLOR_333333 HEXCOLOR(@"#333333") //深灰颜色
#define HEXCOLOR_F7F7F7 HEXCOLOR(@"#f7f7f7") //主背景色
#define HEXCOLOR_D4D4D4 HEXCOLOR(@"#d4d4d4") //分割线颜色
#define HEXCOLOR_B6B6B6 HEXCOLOR(@"#b6b6b6") //淡灰色(副标题文字)
#define HEXCOLOR_F5F7FE HEXCOLOR(@"#f5f7fe") //聊天背景色
#define HEXCOLOR_E0E0E0 HEXCOLOR(@"#e0e0e0") //输入框背景
#define HEXCOLOR_FFFBE0 HEXCOLOR(@"#fffbe0") //顶部提示背景 淡黄色


#pragma mark - # Methods

#define     EHIURL(urlString)    [NSURL URLWithString:urlString]
#define     EHINoNilString(str)  (str.length > 0 ? str : @"")
#define     EHITimeStamp(date)   ([NSString stringWithFormat:@"%lf", [date timeIntervalSince1970]])

#define WEAKSELF(_instance)  __weak typeof(_instance) weak##_instance = _instance;
#define STRONGSELF(_instance) __strong typeof(weak##_instance) _instance = weak##_instance

@interface EHIMacros : NSObject


@end
