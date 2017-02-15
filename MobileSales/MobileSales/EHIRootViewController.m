//
//  EHIRootViewController.m
//  MobileSales
//
//  Created by dengwx on 17/2/10.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIRootViewController.h"
#import <AFNetworking.h>
#import "EHILoginViewController.h"
#import "EHIHomeViewController.h"
#import "EHIMovieViewController.h"

@interface EHIRootViewController ()

@end

@implementation EHIRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化第三方SDK
    [self initThirdSDK];
    
    //加载动画
//    [self loadAnimationLaunch];
    [self initHomeViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark initThirt
//初始化第三方sdk
- (void)initThirdSDK
{
    [MobClick startWithConfigure:nil];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
}

//加载启动动画
- (void)loadAnimationLaunch
{
    EHIMovieViewController *movieVC = [[EHIMovieViewController alloc] init];
    
    BOOL isNotFirstOpen = [[[NSUserDefaults standardUserDefaults]
                        objectForKey:ISFIRSTSTARTAPP_KEY] isEqualToString:ISFIRSTSTARTAPP_FALSE];
    //如果不是第一次打开APP 进普通逻辑
    if (isNotFirstOpen) {
        
        movieVC.movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"normal_movie" ofType:@"mp4"]];
        
        movieVC.movieShowState = EHIAppNormalStart;
        
    }else
    {
        movieVC.movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"login_movie" ofType:@"mp4"]];
        
        movieVC.movieShowState = EHIAppFirstStart;
        
        [[NSUserDefaults standardUserDefaults] setObject:ISFIRSTSTARTAPP_FALSE
                                                  forKey:ISFIRSTSTARTAPP_KEY];
    }
    
    self.window.rootViewController = movieVC;
    
    movieVC.selectCallback = ^(NSInteger selectIndex){
        //如果是第一次打开App 调到登录页 否则进入正常打开逻辑
        if (selectIndex == EHIAppFirstStart) {
            [self initLoginViewController];
        }else if (selectIndex == EHIAppNormalStart){
            [self initNormalOpenApp];
        }
    };
    
}

//初始化登录页
- (void)initLoginViewController
{
    EHILoginViewController *loginVC = [[EHILoginViewController alloc] init];
    [self.window setRootViewController:loginVC];
}

//初始化主页
- (void)initHomeViewController
{
    EHIHomeViewController *rootVC = [EHIHomeViewController sharedRootViewController];
    [self.window setRootViewController:rootVC];
}

//正常App打开的逻辑
- (void)initNormalOpenApp
{
    //判断是否登录
    BOOL isLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_KEY] length] != 0;
    //如果登录了
    if (isLogin) {
        [self initHomeViewController];
    }else
    {
        [self initLoginViewController];
    }
    
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
