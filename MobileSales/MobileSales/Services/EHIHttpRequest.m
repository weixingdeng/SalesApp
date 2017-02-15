//
//  EHIHttpRequest.m
//  MobileSales
//
//  Created by dengwx on 17/2/8.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIHttpRequest.h"
#import "NSMutableDictionary+EHIDicSaveString.h"
#import "UIDevice+IdentifierAddition.h"

@implementation EHIHttpRequest

static NSString* const HTTP_GET = @"GET";
static NSString* const HTTP_POST = @"POST";
static NSString* const HTTP_PUT = @"PUT";
static NSString* const HTTP_DELETE = @"DELETE";

//公共参数拼接
+ (void)startRequestByBaseRequest:(EHIBaseRequestModel *)baseRequest
                   FailedCallback:(RequestFailedCallBack)failedCallback
                  SuccessCallBack:(RequestSuccessCallBack)successCallBack
{
    NSString *bodyString = @"";
    NSString *user_id = baseRequest.user_id ? baseRequest.user_id : SHARE_USER_CONTEXT.user.user_id;
    if (![baseRequest.requestMethod isEqualToString:HTTP_GET]){
        if (!baseRequest.requestBody) {
            baseRequest.requestBody = [NSMutableDictionary dictionary];
        }
        NSMutableDictionary* MobileContextDic = [NSMutableDictionary dictionary];
        [MobileContextDic setObject:baseRequest.requestBody forKey:@"Data"];
        [MobileContextDic saveString:user_id forKey:@"UserNo"];
        //公共参数
        [MobileContextDic setObject:@"IPhone" forKey:@"Source"];
        [MobileContextDic saveString:kAppVersion forKey:@"Version"];
        [MobileContextDic setObject:@([kAppVersion integerValue]) forKey:@"VersionCode"];
        [MobileContextDic setObject:@"" forKey:@"IMEI"];
        [MobileContextDic saveString:[[UIDevice currentDevice] deviceIPAddress] forKey:@"IP"];
        [MobileContextDic setObject:@"" forKey:@"MAC"];
        [MobileContextDic setObject:@"" forKey:@"ICCID"];
        [MobileContextDic setObject:@"" forKey:@"PhoneType"];
        [MobileContextDic saveString:kSystemVersion forKey:@"PhoneSys"];
        [MobileContextDic setObject:@(0) forKey:@"Latitude"];
        [MobileContextDic setObject:@(0) forKey:@"Longitude"];
        bodyString = [self dataToJsonString:MobileContextDic];
#ifdef DEBUG
        NSLog(@"请求地址:%@",baseRequest.requestUrl);
        printf("请求参数:%s", [bodyString UTF8String]);
#endif
    }
    NSURL* url = [NSURL URLWithString:[baseRequest.requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:baseRequest.requestMethod];
    [urlRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        //如果错误 返回错误信息
        if (error) {
            if (failedCallback) {
                failedCallback(error);
                return ;
            }
        }
        
        
        successCallBack(responseObject);
    }];
    [dataTask resume];
}

#pragma mark - 格式转换
+ (NSString*)dataToJsonString:(id)object
{
    NSString* jsonString = nil;
    NSError* error;
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    
        
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    }
    else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


// ===================================请求方法============================================

//获取聊天架构信息
+ (void)getChatFramesInfoWithNodeId:(NSInteger)nodeId
                     FailedCallback:(RequestFailedCallBack)failedCallback
                    SuccessCallBack:(RequestSuccessCallBack)successCallBack
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:@(nodeId) forKey:@"NodeId"];
    NSString* urlString = [NSString stringWithFormat:@"%@/api/Frame/GetFrameInfo",SHARE_USER_CONTEXT.urlList.BASE_HOST];
    
    EHIBaseRequestModel* baseRequest = [[EHIBaseRequestModel alloc] init];
    baseRequest.requestUrl = urlString;
    baseRequest.requestMethod = @"POST";
    baseRequest.requestBody = paramDic;
    
    [self startRequestByBaseRequest:baseRequest FailedCallback:failedCallback SuccessCallBack:successCallBack];

}

//登录
+ (void)loginWithUserNo:(NSString *)userNo withPassword:(NSString *)password
         FailedCallback:(RequestFailedCallBack)failedCallback
        SuccessCallBack:(RequestSuccessCallBack)successCallBack
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic saveString:password forKey:@"PassWord"];
    NSString* urlString = [NSString stringWithFormat:@"%@/api/User/Login",SHARE_USER_CONTEXT.urlList.BASE_HOST];
    
    EHIBaseRequestModel* baseRequest = [[EHIBaseRequestModel alloc] init];
    baseRequest.requestUrl = urlString;
    baseRequest.requestMethod = @"POST";
    baseRequest.requestBody = paramDic;
    baseRequest.user_id = userNo;
    
    [self startRequestByBaseRequest:baseRequest FailedCallback:failedCallback SuccessCallBack:successCallBack];
}



@end
