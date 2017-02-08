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
}


- (void)setMovieShowState:(EHIMoviewShowStates) movieShowState {
    if (_movieShowState != movieShowState) {
        _movieShowState = movieShowState;
    }
    switch (movieShowState) {
        case EHIAppFirstStart:
            
            break;
        case EHIAppNormalStart:
            
            break;
            
        default:
            break;
    }
}

//添加登录按钮
- (void)addLoginButton
{
    
}

//添加跳过按钮
- (void)addSkipButton
{
    
}
//登录或跳转事件
- (void)btnClickToNextPage
{
    
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
