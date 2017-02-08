//
//  EHIUserContext.h
//  MobileSales
//
//  Created by dengwx on 17/2/8.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHIUrlList.h"

@interface EHIUserContext : NSObject

+(instancetype)sharedUserDefault;

@property (nonatomic , strong) EHIUrlList  *urlList;

@end
