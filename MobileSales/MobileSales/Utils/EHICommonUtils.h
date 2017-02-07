//
//  MSCommonUtils.h
//  MobileSales
//
//  Created by dengwx on 17/1/11.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+ColorWithHex.h"

typedef void(^MSOnSuccessBlock)(id result);
typedef void(^MSOnFailureBlock)(id error);

#define MS_LOAD_IMAGE(imageName) \
[UIImage imageNamed:imageName]

#pragma mark --系统

#define VERSION_EQUAL_OR_LATER(_version) \
( [[[UIDevice currentDevice] systemVersion] compare:(@#_version)] != NSOrderedAscending )

//util for empty string
#define INCASE_EMPTY(str, replace) \
( ([(str) length]==0)?(replace):(str) )


//app version
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//system version
#define kSystemVersion [[UIDevice currentDevice] systemVersion]

#pragma mark --适配
#define MS_ONE_PIXEL 1.f/[UIScreen mainScreen].scale

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define autoSizeScaleX_IPhone6 (SCREEN_WIDTH/375)

#define autoSizeScaleH_IPhone6 (SCREEN_HEIGHT/667)
//autoscale with iPhone6
#define autoHeightOf6(HEIGHT) HEIGHT * autoSizeScaleH_iPhone6
#define autoWidthOf6(WIDTH) WIDTH * autoSizeScaleX_iPhone6

#pragma mark --颜色

#define HEXCOLOR(COLOR) [UIColor colorWithHexString:COLOR]

#define HEXCOLOR_718BBE HEXCOLOR(@"#718dde") //tabbar选中颜色

#pragma mark --方法

//create __weak point of an object, use outside the block, with `strongself`
#define WEAKSELF(_instance)  __weak typeof(_instance) weak##_instance = _instance;

//create __strong point of a weak object, use inside the block, with `weakself`
#define STRONGSELF(_instance) __strong typeof(weak##_instance) _instance = weak##_instance


@interface EHICommonUtils : NSObject


@end
