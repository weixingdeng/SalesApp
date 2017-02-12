//
//  EHIUrlList.h
//  MobileSales
//
//  Created by dengwx on 17/2/8.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ENVIRONMENT) {
    ENVIRONMENT_PRODUCTION,
    ENVIRONMENT_DEVELOPMENT,
    ENVIRONMENT_DEMO,
};

@interface EHIUrlList : NSObject

@property(assign,nonatomic) ENVIRONMENT environment;

@property(strong,nonatomic) NSString *BASE_HOST;

@end
