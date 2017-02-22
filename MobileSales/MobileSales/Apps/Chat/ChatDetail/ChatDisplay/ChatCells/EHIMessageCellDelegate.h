//
//  EHIMessageCellDelegate.h
//  MobileSales
//
//  Created by dengwx on 2017/2/23.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EHIMessage;

@protocol EHIMessageCellDelegate <NSObject>

- (void)messageCellDidClickAvatarForMessage:(EHIMessage *)message;

- (void)messageCellDidClickSendAgainForMessage:(EHIMessage *)message;

@end
