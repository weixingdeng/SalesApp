//
//  EHIRootViewController.m
//  MobileSales
//
//  Created by dengwx on 2017/2/7.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIRootViewController.h"
#import "EHIChatViewController.h"
#import "EHICRMViewController.h"
#import "EHIOfficeViewController.h"
#import "EHIMyInfomationViewController.h"
#import "EHINavigationController.h"

static EHIRootViewController *rootVC = nil;

@interface EHIRootViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) NSArray *childVCArray;

@property (nonatomic, strong) EHIChatViewController *chatVC;
@property (nonatomic, strong) EHICRMViewController *CRMVC;
@property (nonatomic, strong) EHIOfficeViewController *officeVC;
@property (nonatomic, strong) EHIMyInfomationViewController *myInfomationVC;

@end

@implementation EHIRootViewController

+ (EHIRootViewController *) sharedRootViewController
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        rootVC = [[EHIRootViewController alloc] init];
    });
    return rootVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setBackgroundColor:[UIColor redColor]];
    [self.tabBar setTintColor:HEXCOLOR_718BBE];
    self.delegate = self;
    [self setViewControllers:self.childVCArray];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (viewController == self.childVCArray[1] || viewController == self.childVCArray[2]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"正在开发中" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark GET && SET

- (EHIChatViewController *)chatVC
{
	if (!_chatVC){
        _chatVC = [[EHIChatViewController alloc] init];
        [_chatVC.tabBarItem setTitle:@"沟通"];
        [_chatVC.tabBarItem setImage:[[UIImage imageNamed:@"tabbar_chat"]
                                      imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
        [_chatVC.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_chat_high"]
                                              imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];

	}
	return _chatVC;
}

- (EHICRMViewController *)CRMVC
{
	if (!_CRMVC){
        _CRMVC = [[EHICRMViewController alloc] init];
        [_CRMVC.tabBarItem setTitle:@"CRM"];
        [_CRMVC.tabBarItem setImage:[[UIImage imageNamed:@"tabbar_crm"]
                                     imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal) ]];
        [_CRMVC.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_crm_high"]
                                             imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
	}
	return _CRMVC;
}

- (EHIOfficeViewController *)officeVC
{
	if (!_officeVC){
        _officeVC = [[EHIOfficeViewController alloc] init];
        [_officeVC.tabBarItem setTitle:@"办公"];
        [_officeVC.tabBarItem setImage:[[UIImage imageNamed:@"tabbar_office"]
                                        imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
        [_officeVC.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_office_high"]
                                                imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
	}
	return _officeVC;
}

- (EHIMyInfomationViewController *)myInfomationVC
{
	if (!_myInfomationVC){
        _myInfomationVC = [[EHIMyInfomationViewController alloc] init];
        [_myInfomationVC.tabBarItem setTitle:@"我的"];
        [_myInfomationVC.tabBarItem setImage:[[UIImage imageNamed:@"tabbar_myinfo"]
                                              imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
        [_myInfomationVC.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_myinfo_high"]
                                                      imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
	}
	return _myInfomationVC;
}

- (NSArray *)childVCArray
{
	if (!_childVCArray){
        EHINavigationController *chatNavVC = [[EHINavigationController alloc] initWithRootViewController:self.chatVC];
        EHINavigationController *CRMNavVC = [[EHINavigationController alloc] initWithRootViewController:self.CRMVC];
        EHINavigationController *officeNavVC = [[EHINavigationController alloc] initWithRootViewController:self.officeVC];
        EHINavigationController *myInfoNavVC = [[EHINavigationController alloc] initWithRootViewController:self.myInfomationVC];
        _childVCArray = @[chatNavVC, CRMNavVC, officeNavVC, myInfoNavVC];

	}
	return _childVCArray;
}

@end
