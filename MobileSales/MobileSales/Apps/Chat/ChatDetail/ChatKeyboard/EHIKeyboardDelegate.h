//
//  EHIKeyboardDelegate.h
//  MobileSales
//
//  Created by dengwx on 17/2/17.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EHIKeyboardDelegate <NSObject>

@optional
- (void)chatKeyboardWillShow:(id)keyboard animated:(BOOL)animated;

- (void)chatKeyboardDidShow:(id)keyboard animated:(BOOL)animated;

- (void)chatKeyboardWillDismiss:(id)keyboard animated:(BOOL)animated;

- (void)chatKeyboardDidDismiss:(id)keyboard animated:(BOOL)animated;

- (void)chatKeyboard:(id)keyboard didChangeHeight:(CGFloat)height;

@end
