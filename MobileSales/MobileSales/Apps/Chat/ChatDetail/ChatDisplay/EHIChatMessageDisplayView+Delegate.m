//
//  EHIChatMessageDisplayView+Delegate.m
//  MobileSales
//
//  Created by dengwx on 17/2/17.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatMessageDisplayView+Delegate.h"

@implementation EHIChatMessageDisplayView (Delegate)

//tableView每组的单元格数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

//具体单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    EHITextMessage *manager = self.data[indexPath.row];
    cell.textLabel.text = manager.text;
    return cell;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.window endEditing:YES];
}


@end
