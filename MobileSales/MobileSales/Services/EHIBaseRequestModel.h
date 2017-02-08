//
//  EHIBaseRequestModel.h
//  MobileSales
//
//  Created by dengwx on 17/2/8.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHIBaseRequestModel : NSObject

/** 请求url */
@property(nonatomic,strong)NSString *requestUrl;
/** 请求方式 ，GET, POST.....*/
@property(nonatomic,strong)NSString *requestMethod;
/** 请求参数 */
@property(nonatomic,strong)id requestBody;

@end
