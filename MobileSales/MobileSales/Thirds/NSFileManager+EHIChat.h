//
//  NSFileManager+EHIChat.h
//  MobileSales
//
//  Created by dengwx on 17/2/15.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (EHIChat)

/**
 *  数据库 — 聊天
 */
+ (NSString *)pathDBMessage;

/**
 *  数据库 — 架构
 */
+ (NSString *)pathDBFrame;

@end
