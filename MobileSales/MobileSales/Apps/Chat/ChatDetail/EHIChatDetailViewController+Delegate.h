//
//  EHIChatDetailViewController+Delegate.h
//  MobileSales
//
//  Created by dengwx on 17/2/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatDetailViewController.h"

#define     MAX_SHOWTIME_MSG_COUNT      10
#define     MAX_SHOWTIME_MSG_SECOND     30

@interface EHIChatDetailViewController (Delegate)<EHIChatMessageDisplayViewDelegate,EHIChatBarDelegate,EHIChatSocketManagerDelegate,EHIChatMessageDisplayViewDelegate,EHIMessageStatusManagerDelegate>

//- (void)registerCellClassForTableView:(UITableView *)tableView;

#pragma mark keyboad Delegate
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
- (void)keyboardFrameWillChange:(NSNotification *)notification;

#pragma mark messageDisplay delegate

//显示message
- (void)addToShowMessage:(EHIMessage *)message;


/**
 *  发送消息
 */
- (void)sendMessage:(EHIMessage *)message;


@end
