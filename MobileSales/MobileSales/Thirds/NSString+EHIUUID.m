//
//  NSString+EHIUUID.m
//  MobileSales
//
//  Created by dengwx on 17/2/20.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "NSString+EHIUUID.h"

@implementation NSString (EHIUUID)

+ (NSString *)createUUID
{
    NSString *  result;
    
    CFUUIDRef  uuid;
    
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    
    result =[NSString stringWithFormat:@"%@",uuidStr];
    
    CFRelease(uuidStr);
    
    CFRelease(uuid);
    
    return result;
}

@end
