//
//  EHIChatLabel.h
//  后台允许
//
//  Created by dengwx on 17/2/15.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHIChatLabel : UILabel

@end

@interface UILabel (Copyable)

//@property (nonatomic) BOOL copyable;
/**
 Set this property to YES in order to enable the copy feature. Defaults to NO.
 */
@property (nonatomic) IBInspectable BOOL copyingEnabled;

/**
 Used to enable/disable the internal long press gesture recognizer. Defaults to YES.
 */
@property (nonatomic) IBInspectable BOOL shouldUseLongPressGestureRecognizer;

@end
