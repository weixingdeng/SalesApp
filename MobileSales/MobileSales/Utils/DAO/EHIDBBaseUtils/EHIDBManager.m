//
//  EHIDBManager.m
//  MobileSales
//
//  Created by dengwx on 17/2/15.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIDBManager.h"
#import "NSFileManager+EHIChat.h"

static EHIDBManager *manager;

@implementation EHIDBManager

+ (EHIDBManager *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[EHIDBManager alloc] init];
    });
    return manager;
}

- (id)init
{
    if (self = [super init]) {
//        NSString *messageQueuePath = [NSFileManager pathDBMessage];
//        self.messageQueue = [FMDatabaseQueue databaseQueueWithPath:messageQueuePath];
//        
//        NSString *frameQueuePath = [NSFileManager pathDBFrame];
//        self.commonQueue = [FMDatabaseQueue databaseQueueWithPath:frameQueuePath];
    }
    return self;
}

- (FMDatabaseQueue *)messageQueue
{
    if (!_messageQueue) {
        NSString *messageQueuePath = [NSFileManager pathDBMessage];
        _messageQueue = [FMDatabaseQueue databaseQueueWithPath:messageQueuePath];
    }
    return _messageQueue;
}
@end
