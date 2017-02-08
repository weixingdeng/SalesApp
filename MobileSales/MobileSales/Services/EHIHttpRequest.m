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
     NSString* bodyString = @"";
    if (![baseRequest.requestMethod isEqualToString:HTTP_GET]){
        if (!baseRequest.requestBody) {
            baseRequest.requestBody = [NSMutableDictionary dictionary];
        }
        NSMutableDictionary* MobileContextDic = [NSMutableDictionary dictionary];
        [MobileContextDic setObject:baseRequest.requestBody forKey:@"Data"];
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
        [MobileContextDic saveString:@"" forKey:@"UserNo"];
        bodyString = [self dataToJsonString:MobileContextDic];
#ifdef DEBUG
        NSLog(@"请求地址:%@",baseRequest.requestUrl);
        printf("请求参数:%s", [bodyString UTF8String]);
#endif
    }
    else
    {
        
    }
    NSURL* url = [NSURL URLWithString:[baseRequest.requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:baseRequest.requestMethod];
    [urlRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"success:%@",responseObject);
        NSLog(@"error:%@",error);
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

//获取聊天人员配置信息
+ (void)getChatSetInfo
{
    NSString* urlString = @"http://192.168.5.185:8032/api/Frame/GetFrameInfo";
    EHIBaseRequestModel* baseRequest = [[EHIBaseRequestModel alloc] init];
    baseRequest.requestUrl = urlString;
    baseRequest.requestMethod = @"POST";
    [self startRequestByBaseRequest:baseRequest FailedCallback:^(id object) {
        
    } SuccessCallBack:^(id object) {
        //        NSLog(@"success");
    }];

}


//登录
//+ (void)loginWith

+ (void)test {
    NSString* urlString = @"https://app.1hai.cn/Car/BatchStoreStockList";
    EHIBaseRequestModel* baseRequest = [[EHIBaseRequestModel alloc] init];
    baseRequest.requestUrl = urlString;
    baseRequest.requestMethod = @"POST";
    [self startRequestByBaseRequest:baseRequest FailedCallback:^(id object) {
        
    } SuccessCallBack:^(id object) {
//        NSLog(@"success");
    }];

}
@end
