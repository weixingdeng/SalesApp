//
//  AppDelegate.m
//  MobileSales
//
//  Created by dengwx on 17/1/10.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIAppDelegate.h"
#import "EHIRootViewController.h"

@interface EHIAppDelegate ()

@end

@implementation EHIAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    EHIRootViewController *rootVC = [[EHIRootViewController alloc] init];
    [self.window setRootViewController:rootVC];
    [self.window makeKeyAndVisible];
    
    SHARE_USER_CONTEXT.urlList.environment = ENVIRONMENT_DEMO;
    //初始化第三方SDK
    [self initThirdSDK];
    
   
    
    return YES;
}

#pragma mark initThirt
//初始化第三方sdk
- (void)initThirdSDK
{
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    [MobClick startWithConfigure:nil];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    //腾讯bugly初始化
    BuglyConfig *config = [[BuglyConfig alloc] init];
    config.debugMode = YES;
    config.blockMonitorEnable = YES;
    config.reportLogLevel = BuglyLogLevelWarn;
    
    [Bugly startWithAppId:@"9cb1749a18" developmentDevice:YES config:config];
    
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
   
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  
}


- (void)applicationWillTerminate:(UIApplication *)application {
   
}


@end
