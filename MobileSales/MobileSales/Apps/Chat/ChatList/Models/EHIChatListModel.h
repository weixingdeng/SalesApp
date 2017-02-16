//
//  EHIChatListModel.h
//  MobileSales
//
//  Created by dengwx on 17/2/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHIContactModel.h"

@interface EHIChatListModel : NSObject

//级别
@property (nonatomic, copy) NSString *NodeLevel;

//node名字
@property (nonatomic, copy) NSString *NodeName;

//截取段字符串名字
@property (nonatomic, copy) NSString *ShortName;

//nodeid
@property (nonatomic, assign) NSInteger NodeId;

//下级目录(里面也是chatlistmodel)
@property (nonatomic, strong) NSArray *Children;

//负责人()
@property (nonatomic, strong) NSArray *Contacts;

//说明
@property (nonatomic, copy) NSString *Comment;


@end
