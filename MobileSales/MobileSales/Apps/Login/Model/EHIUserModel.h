//
//  EHIUserModel.h
//  MobileSales
//
//  Created by dengwx on 17/2/10.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHIUserModel : NSObject

//用户名
@property (nonatomic , copy) NSString *user_id;

//密码
@property (nonatomic , copy) NSString *password ;

//姓名
@property (nonatomic , copy) NSString *user_name;

//性别
@property (nonatomic , copy) NSString *user_sex;

@end
