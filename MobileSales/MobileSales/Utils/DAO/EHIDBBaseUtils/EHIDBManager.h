//
//  EHIDBManager.h
//  MobileSales
//
//  Created by dengwx on 17/2/15.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
@interface EHIDBManager : NSObject

+ (EHIDBManager *)sharedInstance;

/**
 *  与IM相关的DB队列
 */
@property (nonatomic, strong) FMDatabaseQueue *messageQueue;

/**
 *  DB队列（除IM相关）
 */
@property (nonatomic, strong) FMDatabaseQueue *commonQueue;

@end
