//
//  EHIMovieViewController.h
//  MobileSales
//
//  Created by dengwx on 17/2/8.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, EHIMoviewShowStates) {
    EHIAppFirstStart,       // 第一次启动
    EHIAppNormalStart,   // 不是第一次启动
};
@interface EHIMovieViewController : UIViewController

@property (nonatomic , strong) NSURL  *movieURL;

@property (nonatomic , assign) EHIMoviewShowStates  movieShowState;

@property (nonatomic , assign) EHISelectCallback selectCallback;

@end
