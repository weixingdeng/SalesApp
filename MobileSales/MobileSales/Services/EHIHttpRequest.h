//
//  EHIHttpRequest.h
//  MobileSales
//
//  Created by dengwx on 17/2/8.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "EHIBaseRequestModel.h"

typedef void (^RequestFailedCallBack)(id object);
typedef void (^RequestSuccessCallBack)(id object);

@interface EHIHttpRequest : NSObject

+ (void)startRequestByBaseRequest:(EHIBaseRequestModel *)baseRequest
                   FailedCallback:(RequestFailedCallBack)failedCallback
                  SuccessCallBack:(RequestSuccessCallBack)successCallBack;


+ (void)test;
+ (void)getChatSetInfo;
@end
