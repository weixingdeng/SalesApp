//
//  AppDelegate.m
//  MobileSales
//
//  Created by dengwx on 17/1/10.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIAppDelegate.h"
#import <AFNetworking.h>
#import "EHILoginViewController.h"
#import "EHIRootViewController.h"
#import "EHIMovieViewController.h"

@interface EHIAppDelegate ()

@end

@implementation EHIAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    SHARE_USER_CONTEXT.urlList.environment = ENVIRONMENT_DEMO;

    [self loadAnimationLaunch];
    
    return YES;
}

#pragma mark initThirt
//初始化第三方sdk
- (void)initThirdSDK
{
    [MobClick startWithConfigure:nil];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
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
    EHIRootViewController *rootVC = [EHIRootViewController sharedRootViewController];
    [self.window setRootViewController:rootVC];
//    [self.window addSubview:rootVC.view];
}

//加载启动动画
- (void)loadAnimationLaunch
{
    EHIMovieViewController *movieVC = [[EHIMovieViewController alloc] init];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:ISFIRSTSTARTAPP_KEY] isEqualToString:ISFIRSTSTARTAPP_FALSE]) {
        movieVC.movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"normal_movie" ofType:@"mp4"]];
        movieVC.movieShowState = EHIAppNormalStart;
         [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:ISFIRSTSTARTAPP_KEY];
    }else
    {
        movieVC.movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"login_movie" ofType:@"mp4"]];
        movieVC.movieShowState = EHIAppFirstStart;
        [[NSUserDefaults standardUserDefaults] setObject:ISFIRSTSTARTAPP_FALSE forKey:ISFIRSTSTARTAPP_KEY];
    }
   
    self.window.rootViewController = movieVC;
    
    movieVC.selectCallback = ^(NSInteger selectIndex){
        if (selectIndex == 0) {
            [self initLoginViewController];
        }else if (selectIndex == 1){
            [self initHomeViewController];
        }
    };

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
