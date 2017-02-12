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

/** 是否自定义user_id 主要用于登录时候 */
@property(nonatomic,strong)NSString *user_id;


@end
