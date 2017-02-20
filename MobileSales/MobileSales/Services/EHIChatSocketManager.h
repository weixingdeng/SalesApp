//
//  EHIChatSocketManager.h
//  MobileSales
//
//  Created by dengwx on 17/2/20.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHIChatSocketManagerDelegate.h"
#import "GCDAsyncSocket.h"
#import "EHIMessage.h"

#import "EHITextMessage.h"

typedef NS_ENUM(NSInteger, EHISocketTag) {
    EHISocketTagMESSAGE = 1000,
    EHISocketTagACK,          // 文字
    EHISocketTagINIT,         // 
};

@interface EHIChatSocketManager : NSObject<GCDAsyncSocketDelegate>


+ (EHIChatSocketManager *)shareInstance;

@property (nonatomic, assign) id<EHIChatSocketManagerDelegate>delegate;

@property (nonatomic , strong) GCDAsyncSocket  *socket;

-(void)connectToHostWithHost:(NSString *)socketHost
                    withPort:(NSInteger)socketPort;// socket连接


- (void)sendMessageWithMessage:(EHIMessage *)message;

@end
