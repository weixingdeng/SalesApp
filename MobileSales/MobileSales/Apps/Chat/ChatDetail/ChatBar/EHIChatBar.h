//
//  EHIChatBar.h
//  MobileSales
//
//  Created by dengwx on 17/2/16.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHIChatBarDelegate.h"

@interface EHIChatBar : UIView

@property (nonatomic, assign) id<EHIChatBarDelegate> delegate;

/**
 *  发送文字消息
 */
- (void)sendCurrentText;

@end
