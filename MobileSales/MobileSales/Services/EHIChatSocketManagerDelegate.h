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

@end
