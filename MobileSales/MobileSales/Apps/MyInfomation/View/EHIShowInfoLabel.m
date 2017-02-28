//
//  EHIShowInfoLabel.m
//  MobileSales
//
//  Created by dengwx on 2017/2/20.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIShowInfoLabel.h"

@implementation EHIShowInfoLabel

- (instancetype)init
{
    if (self = [super init]) {
        
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = HEXCOLOR_333333;
        self.font = autoFont(14);
        
    }
    return self;
}

@end
