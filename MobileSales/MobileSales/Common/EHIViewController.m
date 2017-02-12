//
//  EHIViewController.m
//  MobileSales
//
//  Created by dengwx on 17/2/7.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIViewController.h"

@interface EHIViewController ()

@end

@implementation EHIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}
//释放键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.window endEditing:YES];
}

- (EHIAppDelegate *)delegate
{
    if (!_delegate) {
        _delegate = (EHIAppDelegate*)[[UIApplication sharedApplication] delegate];
    }
    return _delegate;
}

- (UIWindow *)window
{
    if (!_window) {
        _window = [[[UIApplication sharedApplication] delegate] window];
    }
    return _window;
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
