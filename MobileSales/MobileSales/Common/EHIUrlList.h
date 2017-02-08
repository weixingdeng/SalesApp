//
//  EHIUrlList.h
//  MobileSales
//
//  Created by dengwx on 17/2/8.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>

enum ENVIRONMENT{
    ENVIRONMENT_PRODUCTION,
    ENVIRONMENT_DEMO,
} ;

@interface EHIUrlList : NSObject

@property(assign,nonatomic)enum ENVIRONMENT environment;

@property(strong,nonatomic)NSString *BASE_HOST;

@end
