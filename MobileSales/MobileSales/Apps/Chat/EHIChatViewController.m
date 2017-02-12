//
//  EHIChatViewController.m
//  MobileSales
//
//  Created by dengwx on 2017/2/7.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatViewController.h"

@interface EHIChatViewController ()

@end

@implementation EHIChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"沟通";
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [EHIHttpRequest getChatFramesInfoWithNodeId:0 FailedCallback:^(id object) {
        
    } SuccessCallBack:^(id object) {
        
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [EHIHttpRequest loginWithUserNo:@"1234" withPassword:@"1234" FailedCallback:^(id object) {
        
    } SuccessCallBack:^(id object) {
        
    }];
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
