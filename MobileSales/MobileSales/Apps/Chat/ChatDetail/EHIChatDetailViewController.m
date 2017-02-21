//
//  EHIChatDetailViewController.m
//  MobileSales
//
//  Created by dengwx on 17/2/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatDetailViewController.h"
#import "EHIChatDetailViewController+Delegate.h"
#import "EHIChatManager.h"
#import "EHIChatMemberViewController.h"

@interface EHIChatDetailViewController ()

@end

@implementation EHIChatDetailViewController

//- (void)loadView
//{
//    [super loadView];
//    
//    [self.view addSubview:self.messageView];
//    [self.messageView resetMessageView];
//    [self.view addSubview:self.chatBar];
//    [self addMasonry];
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    [self.socketManager setDelegate:self];
    [self.messageView resetMessageView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
   
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[EHIChatSocketManager shareInstance] setDelegate:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.listModel.NodeName;
    [self.view addSubview:self.messageView];
    [self.view addSubview:self.chatBar];
    [self addMasonry];
    
    [self setNavigationRight];
    [[EHIChatSocketManager shareInstance] setDelegate:self];
    [[EHIChatManager sharedInstance] updateChatToReadWithNodeLevel:@"0" withNodeId:self.listModel.NodeId];
    
}

- (void)addMasonry
{
    [self.messageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.chatBar.mas_top);
    }];
    
    [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_greaterThanOrEqualTo(40);
    }];
}

//设置导航右边
- (void)setNavigationRight
{
    UIImage *navRightImage = [UIImage imageNamed:@"nav_right_img"];
    navRightImage = [navRightImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:navRightImage style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonDown)];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
}

- (void)rightBarButtonDown
{
    EHIChatMemberViewController *memberVC = [[EHIChatMemberViewController alloc] init];
    [self.navigationController pushViewController:memberVC animated:YES];
}


- (EHIChatMessageDisplayView *)messageView
{
    if (!_messageView) {
        _messageView = [[EHIChatMessageDisplayView alloc] init];
        [_messageView setDelegate:self];
    }
    return _messageView;
}
- (EHIChatBar *)chatBar
{
    if (!_chatBar) {
        _chatBar = [[EHIChatBar alloc] init];
        [_chatBar setDelegate:self];
    }
    return _chatBar;
}

- (EHIChatSocketManager *)socketManager
{
    if (!_socketManager) {
        _socketManager = [EHIChatSocketManager shareInstance];
//        [_socketManager setDelegate:self];
    }
    return _socketManager;
}

- (void)dealloc
{
    NSLog(@"kill");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
