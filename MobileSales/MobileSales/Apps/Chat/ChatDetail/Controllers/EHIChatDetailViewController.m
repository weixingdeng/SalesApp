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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.socketManager setDelegate:self];
    //坑 强制每次新对话都显示时间
    if (self.isResetTime) {
        [self resetTimeShow];
        self.isResetTime = NO;
    }
    //每次进入都刷新列表
    [self.messageView resetMessageView];
    
    
    //每次聊天都把当前聊天置为已读状态
    [[EHIChatManager sharedInstance] updateChatToReadWithNodeId:self.listModel.NodeId];
    
     [[EHIChatSocketManager shareInstance] setDelegate:self];
    [[EHIMessageStatusManager shareInstance] setDelegate:self];
    [self.statusManager starCheckSendTimeoutMessage];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.statusManager stopCheckSendTimeoutMessage];
   
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[EHIChatSocketManager shareInstance] setDelegate:nil];
    [[EHIMessageStatusManager shareInstance] setDelegate:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.listModel.NodeName;

    [self.view addSubview:self.commentButton];
    [self.view addSubview:self.messageView];
    [self.view addSubview:self.chatBar];
    
    if (self.listModel.Comment.length) {
        [self.commentButton setTitle:self.listModel.Comment forState:UIControlStateNormal];
    }
    
    [self addMasonry];
    
    [self setNavigationRight];
   
}

- (void)addMasonry
{
    CGSize size = [self.commentButton.titleLabel.text boundingRectWithSize:CGSizeMake((SCREEN_WIDTH - 2 * 10.0), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.commentButton.titleLabel.font} context:nil].size;
    CGFloat commentHeight = size.height > 0 ? ( size.height + 10 ) : 0;

    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.height.mas_equalTo(commentHeight);
    }];
    
    [self.messageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.commentButton);
        make.top.mas_equalTo(self.commentButton.mas_bottom);
        make.bottom.equalTo(self.chatBar.mas_top);
    }];
    
    [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_greaterThanOrEqualTo(40);
    }];
     [self.view layoutIfNeeded];
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
    [self.chatBar.textView resignFirstResponder];
    EHIChatMemberViewController *memberVC = [[EHIChatMemberViewController alloc] init];
    memberVC.memberArray = [NSMutableArray arrayWithArray:self.listModel.Contacts];
    self.hidesBottomBarWhenPushed=YES;
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
    }
    return _socketManager;
}

- (EHIMessageStatusManager *)statusManager
{
    if (!_statusManager) {
        _statusManager = [EHIMessageStatusManager shareInstance];
    }
    return _statusManager;
}

- (UIButton *)commentButton
{
    if (!_commentButton) {
        _commentButton = [[UIButton alloc] init];
        [_commentButton setTitleColor:HEXCOLOR_333333 forState:UIControlStateNormal];
        [_commentButton setBackgroundColor:HEXCOLOR_FFFBE0];
        _commentButton.titleLabel.font = autoFont(10);
        _commentButton.titleLabel.numberOfLines = 0;
        _commentButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    return _commentButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
