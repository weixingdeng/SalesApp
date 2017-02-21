//
//  EHIChatMessageDisplayView+Delegate.m
//  MobileSales
//
//  Created by dengwx on 17/2/17.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatMessageDisplayView+Delegate.h"
#import "EHIMyInfomationViewController.h"

@implementation EHIChatMessageDisplayView (Delegate)

#pragma mark - # Public Methods
- (void)registerCellClassForTableView:(UITableView *)tableView
{
    [tableView registerClass:[EHITextMessageCell class] forCellReuseIdentifier:@"EHITextMessageCell"];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"EmptyCell"];
}

//tableView每组的单元格数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

//具体单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EHIMessage * message = self.data[indexPath.row];
    if (message.messageType == EHIMessageTypeText) {
        EHITextMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EHITextMessageCell"];
        [cell setMessage:message];
        [cell.avatarButton addTarget:self action:@selector(clickAvatar) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    return [tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];
}

- (void)clickAvatar
{
    EHIMyInfomationViewController *infoVC = [[EHIMyInfomationViewController alloc] init];
    [[self viewController].navigationController pushViewController:infoVC animated:YES];
}
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    EHIMessage * message = self.data[indexPath.row];
    return message.messageFrame.height;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.window endEditing:YES];
}


@end
