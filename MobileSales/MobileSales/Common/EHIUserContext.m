//
//  EHIUserContext.m
//  MobileSales
//
//  Created by dengwx on 17/2/8.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIUserContext.h"

@implementation EHIUserContext

+(instancetype)sharedUserDefault{
    static EHIUserContext *userDefault;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userDefault=[[super alloc] init];
    });
    
    return userDefault;
}

@end
