//
//  EHIChatSocketManagerDelegate.h
//  MobileSales
//
//  Created by dengwx on 17/2/20.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHIMessage.h"

@protocol EHIChatSocketManagerDelegate <NSObject>

- (void)receivedMessage:(EHIMessage *)message;
//- (void)ehi_socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err;
//
//- (void)ehi_socket:(GCDAsyncSocket *)sock didReadMessage:(EHIMessage *)message;
//- (void)ehi_socket:(GCDAsyncSocket *)sock didReadACK:(EHIMessage *)message;
//- (void)ehi_socket:(GCDAsyncSocket *)sock didReadINIT:(EHIMessage *)message;

@end
