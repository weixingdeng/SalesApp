//
//  NSDate+EHIChatFormat.h
//  MobileSales
//
//  Created by dengwx on 17/2/19.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Extension.h"
#import "NSDate+Utilities.h"

@interface NSDate (EHIChatFormat)

- (NSString *)chatTimeFormat;

- (NSString *)chatListTimeInfo;
@end
