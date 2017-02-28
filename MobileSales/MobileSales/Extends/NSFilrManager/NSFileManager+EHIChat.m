//
//  NSFileManager+EHIChat.m
//  MobileSales
//
//  Created by dengwx on 17/2/15.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "NSFileManager+EHIChat.h"
#import "NSFileManager+Paths.h"

@implementation NSFileManager (EHIChat)
+ (NSString *)pathDBMessage
{
    NSString *path = [NSString stringWithFormat:@"%@/User/%@/message/DB/", [NSFileManager documentsPath], SHARE_USER_CONTEXT.user.user_id];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"File Create Failed: %@", path);
        }
    }
    return [path stringByAppendingString:@"message.sqlite3"];
}

+ (NSString *)pathDBFrame
{
    NSString *path = [NSString stringWithFormat:@"%@/User/%@/Frame/DB/", [NSFileManager documentsPath], SHARE_USER_CONTEXT.user.user_id];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"File Create Failed: %@", path);
        }
    }
    return [path stringByAppendingString:@"frame.sqlite3"];
}
@end
