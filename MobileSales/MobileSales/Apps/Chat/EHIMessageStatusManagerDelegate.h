//
//  EHIMessageStatusManagerDelegate.h
//  MobileSales
//
//  Created by dengwx on 2017/2/23.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EHIMessageStatusManagerDelegate <NSObject>

@optional
- (void)messageStatusCheckComplete:(NSArray *)data;

@end
