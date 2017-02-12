//
//  WXAlertController.h
//
//  Created by wxdeng on 15/12/29.
//  Copyright © 2015年 wx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WXAlertActionStyle) {
    WXAlertActionStyleDefault = 0,
    WXAlertActionStyleCancel,
    WXAlertActionStyleDestructive
};

typedef NS_ENUM(NSInteger, WXAlertControllerStyle) {
    WXAlertControllerStyleActionSheet = 0,
    WXAlertControllerStyleAlert
};

@interface WXAlertAction : NSObject

@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) WXAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;
@property (nullable,nonatomic,strong,readonly) void (^handler)(WXAlertAction *);

+ (id)actionWithTitle:(nullable NSString *)title style:(WXAlertActionStyle)style handler:(nullable void (^)(WXAlertAction *action))handler;

@end

@interface WXAlertController : UIViewController



@property (nonatomic,strong,readonly) id adaptiveAlert;
@property (nullable,nonatomic,weak) UIViewController *ownerController;
@property (nullable,nonatomic,strong) UIColor *tintColor;
@property(nonatomic,assign) UIAlertViewStyle alertViewStyle;

//
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(WXAlertControllerStyle)preferredStyle;
- (void)addAction:(WXAlertAction *)action;

@property (nonatomic, readonly) NSArray<WXAlertAction *> *actions;
@property (nullable, nonatomic, copy, readonly) NSArray< void (^)(UITextField *textField)> *textFieldHandlers;

@property (nonatomic, strong, nullable) WXAlertAction *preferredAction NS_AVAILABLE_IOS(9_0);

- (void)addTextFieldWithConfigurationHandler:(nullable void (^)(UITextField *textField))configurationHandler;

@property (nullable, nonatomic, readonly) NSArray<UITextField *> *textFields;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *message;

@property (nonatomic, readonly) WXAlertControllerStyle preferredStyle;

@end

NS_ASSUME_NONNULL_END
