//
//  EHIChatListModel.m
//  MobileSales
//
//  Created by dengwx on 17/2/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatListModel.h"

@implementation EHIChatListModel

+ (NSDictionary *)objectClassInArray{
    return @{
             @"Children" : [EHIChatListModel class],
             @"Contacts" : [EHIContactModel class]
             };
}

@end


