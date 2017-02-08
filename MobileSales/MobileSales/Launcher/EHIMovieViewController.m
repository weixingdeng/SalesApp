//
//  EHIMovieViewController.m
//  MobileSales
//
//  Created by dengwx on 17/2/8.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIMovieViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "EHILauncherButton.h"

@interface EHIMovieViewController ()

@property (strong , nonatomic) MPMoviePlayerController *player;

@end

@implementation EHIMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoviePlayer];

}

- (void)setupMoviePlayer
{
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:_movieURL];
    [self.view addSubview:self.player.view];
    self.player.shouldAutoplay = YES;
    [self.player setControlStyle:MPMovieControlStyleNone];
    self.player.repeatMode = MPMovieRepeatModeOne;
    [self.player.view setFrame:self.view.bounds];
    self.player.view.alpha = 0;
    [UIView animateWithDuration:3 animations:^{
        self.player.view.alpha = 1;
        [self.player prepareToPlay];
    }];
    
    switch (self.movieShowState) {
        case EHIAppFirstStart:
            [self addLoginButton];
            break;
        case EHIAppNormalStart:
            [self addSkipButton];
            break;
            
        default:
            break;
    }

}

//添加登录按钮
- (void)addLoginButton
{
    EHILauncherButton *loginButton = [[EHILauncherButton alloc] initWithTitle:@"登录"];
    loginButton.tag = 0;
    loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [loginButton addTarget:self
                    action:@selector(btnClickToNextPage:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.player.view addSubview:loginButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(100);
        make.right.mas_offset(-100);
        make.height.mas_equalTo(40);
        make.bottom.mas_offset(-100);
    }];
    
}

//添加跳过按钮
- (void)addSkipButton
{
    EHILauncherButton *skipButton = [[EHILauncherButton alloc] initWithTitle:@"跳过"];
    skipButton.tag = 1;
    skipButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [skipButton addTarget:self
                   action:@selector(btnClickToNextPage:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.player.view addSubview:skipButton];
    
    [skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(40);
        make.right.mas_offset(-20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
}
//登录或跳转事件
- (void)btnClickToNextPage:(EHILauncherButton *)btn
{
    self.selectCallback(btn.tag);
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
