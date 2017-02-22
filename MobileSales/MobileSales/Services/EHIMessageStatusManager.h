//
//  EHIMessageStatusManager.h
//  MobileSales
//
//  Created by dengwx on 2017/2/22.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHIMessageStatusManagerDelegate.h"

@interface EHIMessageStatusManager : NSObject

@property (nonatomic , assign) id<EHIMessageStatusManagerDelegate> delegate;

@property (nonatomic , strong) NSTimer *checkTimer;

+ (EHIMessageStatusManager *)shareInstance;

- (void)starCheckSendTimeoutMessage;

- (void)stopCheckSendTimeoutMessage;


@end
