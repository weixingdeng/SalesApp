//
//  EHIChatSocketManagerDelegate.h
//  MobileSales
//
//  Created by dengwx on 17/2/20.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>


@class EHIMessage;

@protocol EHIChatSocketManagerDelegate <NSObject>

- (void)receivedMessage:(EHIMessage *)message;

- (void)receivedACKWithMessageId:(NSString *)messageId toSenderStatus:(EHIMessageSendState)status;


@end
