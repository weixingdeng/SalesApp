//
//  NSString+EHIDateFormat.m
//  MobileSales
//
//  Created by dengwx on 17/2/20.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "NSString+EHIDateFormat.h"

@implementation NSString (EHIDateFormat)

+ (NSDate *)getDateWithString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}


@end
