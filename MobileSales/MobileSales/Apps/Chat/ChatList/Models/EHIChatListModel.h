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
@property (nonatomic, copy) NSString *NodeId;

//下级目录(里面也是chatlistmodel)
@property (nonatomic, strong) NSArray *Children;

//负责人()
@property (nonatomic, strong) NSArray *Contacts;

//说明
@property (nonatomic, copy) NSString *Comment;

#pragma mark 扩展字段 非后台返回 用于方便界面标示更多信息
//最后一条信息时间
@property (nonatomic, strong) NSDate *date;

//最后一条信息内容
@property (nonatomic, strong) NSString *content;

//是否已读
@property (nonatomic, assign, readonly) BOOL isRead;


@end
