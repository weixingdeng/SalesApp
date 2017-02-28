//
//  EHIMessageStatusManager.h
//  MobileSales
//
//  Created by dengwx on 2017/2/22.
//  Copyright © 2017年 wxdeng. All rights reserved.
//  检测消息状态 (发送中 失败 成功)

#import <Foundation/Foundation.h>
#import "EHIMessageStatusManagerDelegate.h"

@interface EHIMessageStatusManager : NSObject

@property (nonatomic , assign) id<EHIMessageStatusManagerDelegate> delegate;

@property (nonatomic , strong) NSTimer *checkTimer;

+ (EHIMessageStatusManager *)shareInstance;

- (void)starCheckSendTimeoutMessage;

- (void)stopCheckSendTimeoutMessage;


@end
