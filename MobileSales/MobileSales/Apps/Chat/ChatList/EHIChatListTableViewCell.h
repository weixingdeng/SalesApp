//
//  EHIChatListTableViewCell.h
//  MobileSales
//
//  Created by dengwx on 17/2/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHIChatListModel.h"

@interface EHIChatListTableViewCell : UITableViewCell

@property (nonatomic , strong) EHIChatListModel *chatListModel;

@property (nonatomic , strong) UILabel *iconLabel; //头像

@end
