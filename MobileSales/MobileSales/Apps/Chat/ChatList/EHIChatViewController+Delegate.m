//
//  EHIChatViewController+Delegate.m
//  MobileSales
//
//  Created by dengwx on 17/2/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatViewController+Delegate.h"
#import "EHIChatListTableViewCell.h"
#import "EHIChatDetailViewController.h"

@implementation EHIChatViewController (Delegate)

- (void)registerCellClass
{
    [self.chatListTable registerClass:[EHIChatListTableViewCell class] forCellReuseIdentifier:@"EHIChatListTableViewCell"];
}

//滑动顶部条事件
- (void)segmentSelectHandle:(EHISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex != self.selectIndex) {
        self.selectIndex = segment.selectedSegmentIndex;
        [self.chatListTable reloadData];
    }
}

#pragma mark tableView代理

//tableView每组的单元格数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataAttay.count > 0) {
        EHIChatListModel *model = self.dataAttay[self.selectIndex];
        if (model) {
            return model.Children.count;
        }
    }
    return 0;
}

//具体单元格
- (EHIChatListTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EHIChatListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EHIChatListTableViewCell" forIndexPath:indexPath];
    EHIChatListModel *outerModel = self.dataAttay[self.selectIndex];
    EHIChatListModel *subModel = outerModel.Children[indexPath.row];
    cell.chatListModel = subModel;
    cell.iconLabel.backgroundColor = self.colorArray[indexPath.row%15];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EHIChatListModel *outerModel = self.dataAttay[self.selectIndex];
    EHIChatListModel *subModel = outerModel.Children[indexPath.row];
    
    EHIChatDetailViewController *detailVC = [[EHIChatDetailViewController alloc] init];
    detailVC.listModel = subModel;
      self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
@end
