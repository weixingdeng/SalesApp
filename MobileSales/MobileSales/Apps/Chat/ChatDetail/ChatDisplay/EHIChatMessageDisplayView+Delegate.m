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
    return 10;
}

//具体单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"hello";
    return cell;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.window endEditing:YES];
}


@end
