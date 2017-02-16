//
//  EHINavigationController.m
//  MobileSales
//
//  Created by dengwx on 17/2/7.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHINavigationController.h"

@interface EHINavigationController ()

@end

@implementation EHINavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setBarTintColor:HEXCOLOR_F7F7F7];
    [self.navigationBar setTintColor:HEXCOLOR_718DDE];
    [self.view setBackgroundColor:HEXCOLOR_F7F7F7];
    // 自定义UIBarButtonItem返回按钮背景图片
    UIImage *backButton = [[UIImage imageNamed:@"nav_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20.0, 0, 5.0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    // 自定义UIBarButtonItem返回按钮标题文字位置
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-1.0, 0) forBarMetrics:UIBarMetricsDefault];

    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:HEXCOLOR_333333,
                                                           NSFontAttributeName:[UIFont boldSystemFontOfSize:16]}];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
