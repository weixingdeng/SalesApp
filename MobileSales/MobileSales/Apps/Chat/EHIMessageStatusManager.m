//
//  EHIMessageStatusManager.m
//  MobileSales
//
//  Created by dengwx on 2017/2/22.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIMessageStatusManager.h"
#import "EHIChatManager.h"
#define CHECK_TIME 3

@implementation EHIMessageStatusManager

+ (EHIMessageStatusManager *)shareInstance
{
    static EHIMessageStatusManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


- (void)starCheckSendTimeoutMessage{
    
    self.checkTimer = [NSTimer scheduledTimerWithTimeInterval:CHECK_TIME target:self selector:@selector(checkTimeoutMessage) userInfo:nil repeats:YES];
}

- (void)stopCheckSendTimeoutMessage
{
    [self.checkTimer invalidate];
    self.checkTimer = nil;
}

//检查发送超时消息
- (void)checkTimeoutMessage
{
    [[EHIChatManager sharedInstance] messageSendTimeoutComplete:^(NSArray *data) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(messageStatusCheckComplete:)]) {
            [self.delegate messageStatusCheckComplete:data];
        }
    }];
}


@end
