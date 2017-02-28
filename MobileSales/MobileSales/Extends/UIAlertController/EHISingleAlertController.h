//
//  EHISingleAlertControllerViewController.h
//  MobileSales
//
//  Created by dengwx on 17/2/10.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "WXAlertController.h"

@interface EHISingleAlertController : WXAlertController

+ (void)showSingleAlertOnViewController:(UIViewController *)vc
                              withTitle:(NSString *)title
                            withMessage:(NSString *)message
                        withActionTitle:(NSString *)actionTitle
                                handler:(void (^)(WXAlertAction *action))handler;

@end
