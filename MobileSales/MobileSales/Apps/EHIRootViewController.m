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

static EHIRootViewController *rootVC = nil;

@interface EHIRootViewController ()

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
    // Do any additional setup after loading the view.
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
