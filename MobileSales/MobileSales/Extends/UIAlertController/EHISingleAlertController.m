//
//  EHISingleAlertControllerViewController.m
//  MobileSales
//
//  Created by dengwx on 17/2/10.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHISingleAlertController.h"

@interface EHISingleAlertController ()

@end

@implementation EHISingleAlertController


//+ (EHISingleAlertController *)shareSingleVC
//{
//    
//}

+ (void)showSingleAlertOnViewController:(UIViewController *)vc
                              withTitle:(NSString *)title
                            withMessage:(NSString *)message
                        withActionTitle:(NSString *)actionTitle
                                handler:(void (^)(WXAlertAction *action))handler;
{
    WXAlertController *singleAlert = [WXAlertController alertControllerWithTitle:title
                                                                         message:message preferredStyle:WXAlertControllerStyleAlert];
    
    WXAlertAction *defaultAction = [WXAlertAction actionWithTitle:actionTitle
                                                            style:WXAlertActionStyleDefault
                                                          handler:handler];
    
    [singleAlert addAction:defaultAction];
    [vc presentViewController:singleAlert animated:YES completion:nil];
}

@end
