//
//  NSMutableDictionary+EHIDicSaveString.m
//  MobileSales
//
//  Created by dengwx on 17/2/8.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "NSMutableDictionary+EHIDicSaveString.h"

@implementation NSMutableDictionary (EHIDicSaveString)

-(void)saveString:(NSString *)string forKey:(id)key{
    if (!string||[string isKindOfClass:[NSString class]]) {
        string=string.length?string:@"";
    }
    [self setObject:string forKey:key];
}

@end
