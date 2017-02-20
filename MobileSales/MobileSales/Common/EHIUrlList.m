//
//  EHIUrlList.m
//  MobileSales
//
//  Created by dengwx on 17/2/8.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIUrlList.h"

@implementation EHIUrlList



- (void)setEnvironment:(enum ENVIRONMENT) environment {
    if (_environment != environment) {
        _environment = environment;
    }
    
    switch (environment) {
        case ENVIRONMENT_PRODUCTION:
        {
            self.BASE_HOST = @"";
            break;
        }
        case ENVIRONMENT_DEVELOPMENT:
        {
            self.BASE_HOST = @"http://192.168.5.185:8032";
            self.SOCKET_HOST = @"192.168.5.172";
            self.SOCKET_PORT = 10000;
            break;
        }
        case ENVIRONMENT_DEMO:
        {
            self.BASE_HOST = @"http://demo5.1hai.cn/SalesAppAPI";
            self.SOCKET_HOST = @"192.168.5.172";
            self.SOCKET_PORT = 10000;
            break;
        }
            
        default:
            self.BASE_HOST = @"";
            break;
    }
}


@end
