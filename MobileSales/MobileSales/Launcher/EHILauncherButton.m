//
//  EHILauncherButton.m
//  MobileSales
//
//  Created by dengwx on 2017/2/8.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHILauncherButton.h"

@implementation EHILauncherButton

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 8;
        self.clipsToBounds = YES;
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[UIImage imageNamed:@"btnbg"] forState:UIControlStateHighlighted];
        [self setTitle:title forState:UIControlStateNormal];
        
    }
    return self;
}

@end
