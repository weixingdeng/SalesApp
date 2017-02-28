//
//  EHIResponseModel.h
//  MobileSales
//
//  Created by dengwx on 17/2/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHIResponseModel : NSObject


@property (nonatomic, assign) BOOL IsSuccess;

@property (nonatomic, copy) NSString *MsgCode;

@property (nonatomic, assign) NSInteger ErrorCode;

@property (nonatomic, copy) NSString *Msg;

//返回的内容
@property (nonatomic , strong) id Data ;


@end
