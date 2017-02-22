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
    
    self.checkTimer = [NSTimer timerWithTimeInterval:CHECK_TIME target:self selector:@selector(checkTimeoutMessage) userInfo:nil repeats:YES];
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

//开个定时器 3S刷新一次数据库

//查找出所有的sending 状态 并且时间和现在差30s以上 的message (array)

//更新他们的状态为 fail

//返回一个数据 里面是所有的fail message

//for(message in array ){
    //for (mess in data) me.id = me.id reture;
//}
- (NSArray *)me1
{
    return nil;
}

//重发
//message id
// 把messaged的[socket sha]send]

//把加到数据库 放到 socket发送消息中
//重发只需要删除当前数据源 调用send方法

/*
 
 思路:
 cell的头像点击 和 消息重发设置为代理
 vc响应代理 统一到vc处理
 
 点重发 删除当前数据源走sendMessage代理方法(时间应该已经改了)

 
 */



@end
