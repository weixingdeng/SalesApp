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

- (EHIUrlList *)urlList
{
    if (!_urlList) {
        _urlList = [[EHIUrlList alloc] init];
    }
    return _urlList;
}

- (EHIUserModel *)user
{
    if (!_user) {
        _user = [[EHIUserModel alloc] init];
    }
    return _user;
}

@end
