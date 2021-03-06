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
#import "EHIResponseModel.h"

typedef void (^RequestFailedCallBack)(id object);
typedef void (^RequestSuccessCallBack)(id object);

@interface EHIHttpRequest : NSObject

+ (void)startRequestByBaseRequest:(EHIBaseRequestModel *)baseRequest
                   FailedCallback:(RequestFailedCallBack)failedCallback
                  SuccessCallBack:(RequestSuccessCallBack)successCallBack;


//获取聊天框架信息
+ (void)getChatFramesInfoWithNodeId:(NSInteger)nodeId
                     FailedCallback:(RequestFailedCallBack)failedCallback
                        SuccessCallBack:(RequestSuccessCallBack)successCallBack;

//登录
+ (void)loginWithUserNo:(NSString *)userNo withPassword:(NSString *)password
         FailedCallback:(RequestFailedCallBack)failedCallback
        SuccessCallBack:(RequestSuccessCallBack)successCallBack;
@end
