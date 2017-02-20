//
//  NSString+EHIDateFormat.h
//  MobileSales
//
//  Created by dengwx on 17/2/20.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EHIDateFormat)

+ (NSDate *)getDateWithString:(NSString *)dateString;

@end
