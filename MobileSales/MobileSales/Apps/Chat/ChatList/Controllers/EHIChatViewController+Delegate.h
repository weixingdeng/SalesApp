//
//  EHIChatViewController+Delegate.h
//  MobileSales
//
//  Created by dengwx on 17/2/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatViewController.h"

@interface EHIChatViewController (Delegate)<UITableViewDelegate , UITableViewDataSource>

- (void)registerCellClass;

- (void)segmentSelectHandle:(EHISegmentedControl *)segment;

@end
