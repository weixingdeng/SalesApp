//
//  EHIChatMessageDisplayView+Delegate.h
//  MobileSales
//
//  Created by dengwx on 17/2/17.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatMessageDisplayView.h"
#import "EHITextMessageCell.h"

@interface EHIChatMessageDisplayView (Delegate)<UITableViewDelegate,UITableViewDataSource>

- (void)registerCellClassForTableView:(UITableView *)tableView;

@end
